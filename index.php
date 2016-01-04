<?php
define( "APP_RUNNING", true );
require("vendor/autoload.php");
require("config.php");
require("class.render.php");
require("class.query.php");

$app = new stdClass();
$app->db = null;
$app->smarty = null;
$app->klein = null;

if(
    !defined('MYSQL_HOSTNAME') ||
    !defined('MYSQL_DATABASE') ||
    !defined('MYSQL_USERNAME') ||
    !defined('MYSQL_PASSWORD') ||
    !defined('HOME') ||
    !defined('URL')
) {
    die( "ERROR: please check config.php for MySQL settings" );
}

try {
    $app->db = new PDO(
        'mysql:host=' . MYSQL_HOSTNAME .
        ';dbname=' . MYSQL_DATABASE .
        ';charset=utf8mb4',
        MYSQL_USERNAME,
        MYSQL_PASSWORD,
        array(
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
        )
    );
} catch( Exception $e ) {
    die( "ERROR: unable to connect to MySQL - please check config.php" );
}

$app->klein = new \Klein\Klein();
$app->smarty = new Smarty();

$app->klein->respond('GET', HOME.'/new', function() use ($app) {
    try {
        $query = $app->db->prepare(
            "insert into `timelines` (`title`, `created_on`, `status`) " .
            "values ('Untitled', now(), 'deleted')"
        );
        $query->execute();
    } catch( Exception $e ) {
        die( "ERROR: unable to create new timeline" );
    }
    $id = $app->db->lastInsertId();

    header("location:" . URL . "/config/{$id}" );
    die();
});

$app->klein->respond('GET', HOME.'/config/[i:id]', function($req, $res, $svc, $app) use ($app) {
    try {
        $query = $app->db->prepare(
            "select * from `timelines` where `id`=:id limit 1"
        );
        $query->execute(array(
            "id" => $req->id
        ));
        $timeline = $query->fetch(\PDO::FETCH_OBJ);
    } catch( Exception $e ) {
        die( "ERROR: unable to query timeline" );
    }

    if( empty($timeline) ) throw new Exception("Timeline {$req->id} is empty");

    try {
        $query = $app->db->prepare(
            "select * from `config` where `timeline_id`=:id and `status`='published'"
        );
        $query->execute(array(
            "id" => $req->id
        ));
        $config = $query->fetchAll(\PDO::FETCH_OBJ);
    } catch( Exception $e ) {
        die( "ERROR: unable to query config for timeline" );
    }

    try {
        $query = $app->db->prepare(
            "select * from `meta` where `timeline_id`=:id and `status`='published' order by `order_num`"
        );
        $query->execute(array(
            "id" => $req->id
        ));
        $meta = $query->fetchAll(\PDO::FETCH_OBJ);
    } catch( Exception $e ) {
        die( "ERROR: unable to query meta for timeline" );
    }

    $app->smarty->assign( "home", URL );
    $app->smarty->assign( "timeline", $timeline );
    $app->smarty->assign( "config", $config );
    $app->smarty->assign( "meta", $meta );
    $app->smarty->assign( "page", "config" );
    return( $app->smarty->fetch("config.tpl") );
});

$app->klein->respond('GET', HOME.'/', function() use ($app) {
    try {
        $query = $app->db->prepare(
            "select * from `timelines` where `status`='published' order by `parent`,`id`"
        );
        $query->execute();
        $timelines = $query->fetchAll(\PDO::FETCH_OBJ);
    } catch( Exception $e ) {
        die( "ERROR: unable to query timelines" );
    }
    $app->smarty->assign( "home", URL );
    $app->smarty->assign( "timelines", $timelines );
    $app->smarty->assign( "page", "timelines" );
    return( $app->smarty->fetch("timelines.tpl") );
});

$app->klein->respond('POST', HOME.'/save/config/[i:id]', function($req, $res, $svc, $app) use ($app) {
    $ret = array();

    try {
        $query = $app->db->prepare(
            "update `timelines` " .
            "set `title`=:title, `subtitle`=:subtitle, `status`=:status, " .
            "`template`=:template " .
            "where `id`=:id limit 1"
        );
        $query->execute(array(
            "title" => $req->title,
            "subtitle" => $req->subtitle,
            "template" => $req->template,
            "status" => "published",
            "id" => $req->id
        ));
    } catch( Exception $e ) {
        die( "ERROR: unable to update timeline" );
    }

    try {
        $query = $app->db->prepare(
            "update `meta` set status='deleted' where " .
            "`status`='published' and `timeline_id`=:id"
        );
        $query->execute(array(
            "id" => $req->id
        ));
    } catch( Exception $e ) {
        die( "ERROR: unable to delete meta fields" );
    }

    foreach( $req->meta as $count => $field ) {

        // validate presence of all required $field keys
        $required = array(
            "series", "position", "label", "symbol",
            "type", "possible_values", "default_value"
        );

        // this will allow additional keys, but not any to be missing
        $missing = array_diff($required, array_keys($field));
        if( !empty($missing) ) {
            die( "ERROR: cells missing in meta field" );
        }

        // field deleted, so ... don't add it back up
        if( $field["is_deleted"] == "true" ) continue;

        try {
            $query = $app->db->prepare(
                "insert into meta (timeline_id, order_num, series, position, label, " .
                " symbol, type, possible_values, default_value) values (" .
                ":id, :order, :series, :position, :label, :symbol, :type, " .
                ":possible_values, :default_value)"
            );
            $query->execute(array(
                "id" => $req->id,
                "order" => $count,
                "series" => $field["series"],
                "position" => $field["position"],
                "label" => $field["label"],
                "symbol" => $field["symbol"],
                "type" => $field["type"],
                "possible_values" => $field["possible_values"],
                "default_value" => $field["default_value"]
            ));
        } catch( Exception $e ) {
            die( "ERROR: unable to add meta fields" );
        }
    }

    //
    // $ret["id"] = $req->id;
    // $ret["status"] = "fail";
    // $ret["title"] = $req->title;
    // $ret["subtitle"] = $req->subtitle;
    // $ret["template"] = $req->template;
    #$ret["meta"] = print_r($req->meta[0],true);

    return( json_encode($ret) );
    die;
});

$app->klein->respond('POST', HOME.'/interactive/[i:id]/slides', function($req, $res, $svc, $app) use ($app) {
    try {
        $query = $app->db->prepare(
            "select * from `slides` where `parent`=:id order by num_order,id"
        );
        $query->execute(array(
            "id" => $req->id
        ));
        $slides = $query->fetchAll(\PDO::FETCH_OBJ);
    } catch( Exception $e ) {
        die( "ERROR: unable to query slides" );
    }

    $app->smarty->assign( "home", URL );
    $app->smarty->assign( "slides", $slides );
    $app->smarty->assign( "page", "slides" );
    return( $app->smarty->fetch("slides.tpl") );
});

$app->klein->respond('POST', HOME.'/interactive/[i:id_parent]/slide/new', function($req, $res, $svc, $app) use ($app) {
    try {
        $query = $app->db->prepare(
            "insert into `slides` (`parent`, `status`) values (:id_parent, :status)"
        );
        $query->execute(array(
            "id_parent" => $req->id_parent,
            "status" => "published"
        ));
        $id = $app->db->lastInsertId();
    } catch( Exception $e ) {
        die( "ERROR: unable to insert slide" . $e);
    }

    try {
        $query = $app->db->prepare(
            "select * from `slides` where `parent`=:id_parent and id=:id limit 1"
        );
        $query->execute(array(
            "id_parent" => $req->id_parent,
            "id" => $id
        ));
        $slide = $query->fetch(\PDO::FETCH_OBJ);
    } catch( Exception $e ) {
        die( "ERROR: unable to query slide" );
    }

    $app->smarty->assign( "home", URL );
    $app->smarty->assign( "slide", $slide );
    $app->smarty->assign( "page", "slide" );

    return( json_encode($slide) );
    #return( $app->smarty->fetch("slide.tpl") );
});

$app->klein->respond('POST', HOME.'/interactive/[i:id_parent]/slide/[i:id]', function($req, $res, $svc, $app) use ($app) {
    try {
        $query = $app->db->prepare(
            "select * from `slides` where `parent`=:id_parent and id=:id limit 1"
        );
        $query->execute(array(
            "id" => $req->id,
            "id_parent" => $req->id_parent
        ));
        $slide = $query->fetch(\PDO::FETCH_OBJ);
    } catch( Exception $e ) {
        die( "ERROR: unable to query slides" );
    }

    $app->smarty->assign( "home", URL );
    $app->smarty->assign( "slide", $slide );
    $app->smarty->assign( "page", "slide" );

    return( json_encode($slide) );
    #return( $app->smarty->fetch("slide.tpl") );
});

$app->klein->respond('GET', HOME.'/interactive/[i:id]', function($req, $res, $svc, $app) use ($app) {
    try {
        $query = $app->db->prepare(
            "select * from `timelines` where `id`=:id limit 1"
        );
        $query->execute(array(
            "id" => $req->id
        ));
        $timeline = $query->fetch(\PDO::FETCH_OBJ);
    } catch( Exception $e ) {
        die( "ERROR: unable to query timeline" );
    }

    if( empty($timeline) ) throw new Exception("Timeline {$req->id} is empty");

    $app->smarty->assign( "home", URL );
    $app->smarty->assign( "timeline", $timeline );
    $app->smarty->assign( "page", "timeline" );
    return( $app->smarty->fetch("timeline.tpl") );
});

$app->klein->dispatch();

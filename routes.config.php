<?php
if( !defined("APP_RUNNING") ) {
    die( "ERROR 201" );
}

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

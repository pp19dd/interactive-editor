<?php
if( !defined("APP_RUNNING") ) {
    die( "ERROR 201" );
}

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

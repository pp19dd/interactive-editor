<?php
if( !defined("APP_RUNNING") ) {
    die( "ERROR 201" );
}

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

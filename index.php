<?php
require("vendor/autoload.php");
require("config.php");

$app = new stdClass();
$app->db = null;
$app->smarty = null;
$app->klein = null;

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

$app->klein->respond('GET', HOME.'/', function() use ($app) {
    try {
        $query = $app->db->prepare(
            "select timelines.*,(
            select *
            from wp_postmeta
            where timelines.PID=wp_postmeta.post_id and
            wp_postmeta.meta_key='_timeline_copyid'
            ) as _copyid from timelines"
        );
        $query->execute();
        $timelines = $query->fetchAll(\PDO::FETCH_OBJ);
    } catch( Exception $e ) {
        die( "ERROR: unable to query timelines" );
    }
    $app->smarty->assign("timelines", $timelines);
    return( $app->smarty->fetch("timelines.tpl") );
});

$app->klein->dispatch();

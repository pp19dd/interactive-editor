<?php
require("vendor/autoload.php");
require("config.php");

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

$app->klein->respond('GET', HOME.'/', function() use ($app) {
    try {
        $query = $app->db->prepare(
            "select * from timelines"
        );
        $query->execute();
        $timelines = $query->fetchAll(\PDO::FETCH_OBJ);
    } catch( Exception $e ) {
        die( "ERROR: unable to query timelines" );
    }
    $app->smarty->assign( "home", URL );
    $app->smarty->assign("timelines", $timelines);
    return( $app->smarty->fetch("timelines.tpl") );
});

$app->klein->respond('GET', HOME.'/preview/[i:id]', function($req, $res, $svc, $app) use ($app) {
    # echo $req->id; die;
    # $app->smarty->assign("id", $req->id)
    # return( $app->smarty->fetch("preview.tpl") );
    ### $renderer = new interactive();
    ### $renderer->setTimelineid($req->id);
});

$app->klein->dispatch();

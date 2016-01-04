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

include( "routes.home.php" );
include( "routes.config.php" );
include( "routes.timeline.php" );

$app->klein->dispatch();

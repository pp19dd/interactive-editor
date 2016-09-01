<!doctype html>
<html>
<head>
{block name="title"}
<title>timeline #</title>
{/block}
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="{$home}/css/html5-reset.css" />
<link rel="stylesheet" type="text/css" href="{$home}/css/main.css" />
<script type="text/javascript" src="{$home}/js/jquery/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="{$home}/js/meta.js?rand={$smarty.now}"></script>
<script src="http://localhost:3000/socket.io/socket.io.js"></script>
<script type="text/javascript">
var home = {$home|json_encode};
var self = "";
$(document).ready(function() {
  var socket = io.connect("http://localhost:3000");
  socket.on("connect", function(msg) {
    self = socket.id;
    $("slides h1").html(self);
  });

  socket.on("joined", function(msg) {
    console.info( "i am " + self + " and brother joined: " + msg );

  });
});
</script>
{block name="head"}
{/block}
</head>
<body class="{$page}">
    <content>
{block name="content"}
{/block}
    </content>

    <slides>
{block name="slides"}
{/block}
    </slides>

    <actions>
{block name="actions"}
{/block}
    </actions>

{block name="foot"}
{/block}

</body>
</html>

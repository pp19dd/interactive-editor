var http = require("http");
var faye = require("faye");

var server = http.CreateServer();
var bayeux = faye.NodeAdapter({ mount: "/" });

bayeux.attach( server );
server.listen( 8000 );

var app = require("express")();
var http = require("http").Server(app);
var io = require("socket.io")(http);

io.on("connection", function(socket) {
    console.log( "user connected: " + socket.client.id);
    socket.emit( "joined", socket.client.id );
})

http.listen(3000, function() {
    console.log( "listening on *.3000" );
});

app.get("/", function(req, res) {
  var html = "hi<hr/>";

  console.dir( io.sockets.adapter.rooms );

  res.send( html );
});

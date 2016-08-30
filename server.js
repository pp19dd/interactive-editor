var app = require("express")();
var http = require("http").Server(app);
var io = require("socket.io")(http);

app.get("/", function(req, res) {
    res.send( "hi..." );
});

io.on("connection", function(socket) {
    console.log( "user connected: " + socket.client.id);
    socket.emit( "join", socket.client.id );
})

http.listen(3000, function() {
    console.log( "listening on *.3000" );
});

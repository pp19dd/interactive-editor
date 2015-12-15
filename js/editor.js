
function load_timeline(id) {
console.info( home + "/interactive/2/slides" );
    $.post(
        home + "/interactive/" + parseInt(id) + "/slides",
        {},
        function(d) {
            $("slides lower").html(d);
        }
    );

}

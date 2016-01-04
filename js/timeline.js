// ===========================================================================
// defines everything needed on timeline edit screen
// ===========================================================================

function ieTimeline(init) {
    this.init = init;
    this.id = init.id;

    this.load();
}

ieTimeline.prototype.load = function() {
    $.post(
        home + "/interactive/" + parseInt(this.id) + "/slides",
        {},
        function(d) {
            $("#slides_lower").html(d);
        }
    );
}

ieTimeline.prototype.addSlide = function() {
    $.ajax({
        url: home + "/interactive/" + parseInt(this.id) + "/slide/new",
        method: "post",
        data: {},
        dataType: "json",
        success: function(d) {
            $("#editor_lower").html(d.content);
        }
    });
}

ieTimeline.prototype.loadSlide = function(slide_id) {
    $.ajax({
        url: home + "/interactive/" + parseInt(this.id) + "/slide/" + slide_id,
        method: "post",
        data: {},
        dataType: "json",
        success: function(d) {
            $("#editor_lower").html(d.content);
        }
    });
}

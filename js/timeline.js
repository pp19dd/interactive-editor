// ===========================================================================
// defines everything needed on timeline edit screen
// ===========================================================================

function ieTimeline(init) {
    this.init = init;
    this.id = init.id;

    this.loadSlides();
}

ieTimeline.prototype.loadSlides = function() {
    $.ajax({
        url: home + "/interactive/" + parseInt(this.id) + "/slides",
        method: "post",
        data: {},
        dataType: "html",
        success: function(d) {
            $("#slides_lower").html(d);
        }
    });
}

ieTimeline.prototype.addSlide = function() {
    $.ajax({
        url: home + "/interactive/" + parseInt(this.id) + "/slide/new",
        method: "post",
        data: {},
        dataType: "html",
        success: function(d) {
            $("#slides_lower").html(d);
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

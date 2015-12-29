// ===========================================================================
// defines everything needed on config edit screen
// ===========================================================================

function save_config(id, button, slide_fields) {

    var payload = {
        id: id,
        title: $("input[name=title]").val(),
        subtitle: $("input[name=subtitle]").val(),
        template: $("input[name=template]").val(),
        meta: slide_fields.get()
    }

    //console.dir( payload ); return(false);
    $(button).attr("disabled", true);

    $.ajax({
        url: home + "/save/config/" + parseInt(id),
        method: "post",
        data: payload,
        dataType: "json",
        success: function(d) {
            $(button).attr("disabled", false);
            window.location.href = home;
        }
    });

}

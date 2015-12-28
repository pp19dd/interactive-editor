// ===========================================================================
// defines everything needed on config edit screen
// ===========================================================================

function save_config(id, button, slide_fields) {

    function get_meta() {
        var ret = [];
        for( var i = 0; i < slide_fields.rows.length; i++ ) {
            ret.push( slide_fields.rows[i].get() );
        }
        return( ret );
    }

    $(button).attr("disabled", true);
    console.dir( get_meta() );
    return(false);

    $.ajax({
        url: home + "/save/config/" + parseInt(id),
        method: "post",
        data: {
            id: id,
            title: $("input[name=title]").val(),
            subtitle: $("input[name=subtitle]").val(),
            template: $("input[name=template]").val(),
            meta: get_meta()
        },
        dataType: "json",
        success: function(d) {
            $(button).attr("disabled", false);
            window.location.href = home;
        }
    });

}

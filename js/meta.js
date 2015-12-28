
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

// ===========================================================================
// parts of the config interface
// ===========================================================================
function meta_field(init) {
    this.init = init;
    this.parts = [];
    this.position = -1;
    this.is_deleted = false;
    this.create();
}

meta_field.prototype.text_field = function(field) {
    var td = $("<td />");
    var input = $("<input />", {
        name: field.label,
        value: field.value
    });
    td.append(input);
    this.parts.push(input);
    return(td);
}

meta_field.prototype.type_of_field_option = function(parm) {
    var option = $("<option />", {
        value: parm.value,
        text: parm.value
    });

    if( parm.parent_value === parm.value ) {
        option.attr("selected", "selected");
    }
    return(option);
}

meta_field.prototype.type_of_field = function(field) {
    var td = $("<td />");
    var input = $("<select />", {
        name: field.label
    });

    var to_add = ["text", "textarea", "dropdown", "checkbox", "radio"];

    for( var i = 0; i < to_add.length; i++ ) {
        input.append(
            this.type_of_field_option({
                parent_value: field.value, field, value: to_add[i]
            })
        );
    }

    td.append(input);
    this.parts.push(input);
    return(td);
}

meta_field.prototype.type_of_position = function(field) {
    var td = $("<td />");
    var input = $("<select />", {
        name: field.label
    });

    var to_add = ["before", "after", "sidebar"];

    for( var i = 0; i < to_add.length; i++ ) {
        input.append(
            this.type_of_field_option({
                parent_value: field.value, field, value: to_add[i]
            })
        );
    }

    td.append(input);
    this.parts.push(input);
    return(td);
}

// actually each "field" is a collection of form fields
meta_field.prototype.get = function() {
    var ret = {};

    // hmm, need a ... field manager. taking a shortcut instead!
    // never mind, fail
    // this.position = $("tr.meta_field").length;

    ret["meta_id"] = this.init.id;
    ret["order_num"] = -1;
    ret["is_deleted"] = this.is_deleted;

    for( var i = 0; i < this.parts.length; i++ ) {
        //console.info( this.parts[i] );
        var k = $(this.parts[i]).attr("name");
        var v = $(this.parts[i]).val();
        ret[k] = v;
    }
    return( ret );
}

meta_field.prototype.remove_button = function() {
    var td = $("<td />");
    var a = $("<a href='#' class='remove-field' title='Mark for deletion'>-</a>");
    var that = this;
    a.click(function() {
        if( that.tr.hasClass("to-be-deleted") ) {
            that.tr.animate({ opacity: 1 }, 300, function() {
                that.tr.removeClass("to-be-deleted");
                a.attr("title", "Mark for deletion");
                that.is_deleted = false;
            });
        } else {
            that.tr.animate({ opacity: 0.1 }, 300, function() {
                that.tr.addClass("to-be-deleted");
                a.attr("title", "Unmark for deletion");
                that.is_deleted = true;
            });
        }
        return(false);
    });

    td.append(a);
    return(td);
}

meta_field.prototype.create = function() {
    var to_add = [
        this.text_field({ label: "series", value: this.init.series }),
        this.type_of_position({ label: "position", value: this.init.position }),
        this.text_field({ label: "label", value: this.init.label }),
        this.text_field({ label: "symbol", value: this.init.symbol }),
        this.type_of_field({ label: "type", value: this.init.type }),
        this.text_field({ label: "possible", value: this.init.possible_values }),
        this.text_field({ label: "default", value: this.init.default_value }),
        this.remove_button({ label: "default", value: this.init.default_value })
    ];
    var tr = $("<tr />", { "class": "meta_field" });
    for( var k in to_add ) {
        tr.append(to_add[k]);
    }
    this.tr = tr;
    $("#timeline_meta").append(tr);
}

// ===========================================================================
// glue this to the add button / link
// ===========================================================================
function add_meta_field(options) {
    options.container.push(
        new meta_field({
            id: -1,
            status: "published",
            position: "sidebar",
            type: "text",
            series: "",
            label: "",
            symbol: "",
            possible_values: "",
            default_value: ""
        })
    );
}

// ===========================================================================
// glue this to the save config button / link
// ===========================================================================
function save_config(id, button) {
    $(button).attr("disabled", true);

    function get_meta() {
        var ret = [];
        for( var i = 0; i < meta_fields.length; i++ ) {
            ret.push( meta_fields[i].get() );
        }
        return( ret );
    }

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

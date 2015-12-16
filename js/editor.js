
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
    this.create();
}

meta_field.prototype.text_field = function(field) {
    var td = $("<td />");
    var input = $("<input />", {
        name: field.label + "[]",
        value: field.value
    });
    td.append(input);
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
        name: field.label + "[]"
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
    return(td);
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
            });
        } else {
            that.tr.animate({ opacity: 0.1 }, 300, function() {
                that.tr.addClass("to-be-deleted");
                a.attr("title", "Unmark for deletion");
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
        this.text_field({ label: "label", value: this.init.label }),
        this.text_field({ label: "symbol", value: this.init.symbol }),
        this.type_of_field({ label: "type", value: this.init.type }),
        this.text_field({ label: "possible", value: this.init.possible_values }),
        this.text_field({ label: "default", value: this.init.default_value }),
        this.remove_button({ label: "default", value: this.init.default_value })
    ];
    var tr = $("<tr />");
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
            order_num: -1,
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
function save_config(id) {
    $.post(
        home + "/save/config/" + parseInt(id),
        {},
        function(d) {
            $("slides lower").html(d);
        }
    );

}

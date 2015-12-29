
// ===========================================================================
// generic 'meta' container, define rows here, field types, and so on
// ===========================================================================
function meta_container(selector) {
    this.table = $(selector);

    if( this.table.length !== 1 ) {
        console.error( "meta.js: need a unique table as a constructor" );
        return(false);
    }

    // head row describes how each tbody row should behave
    // body is where newly created trs go
    this.head = $("thead th", this.table);
    this.body = $("tbody", this.table);

    // describes types of td in a new/loaded row
    this.fields = [];

    // rows are loaded here when a new row is created
    this.rows = [];

    var that = this;
    $.each(this.head, function(k,v) {
        that.fields.push({
            name: $(this).attr("data-name"),
            type: $(this).attr("data-type"),
            options: $(this).attr("data-options")
        });
    });

    this.add_add_button();
}

meta_container.prototype.add_add_button = function() {
    var that = this;
    var a = $("<a class='add-field' href='#'>+ Add Field</a>");
    a.click(function() {
        that.add_row({ id: -1 });
        return(false);
    });
    var p = $("<p />");
    p.append(a);
    that.table.after(p);
}

// data.id is required
meta_container.prototype.add_row = function(data) {
    var tr = $("<tr/>", {
        "data-id": data.id,
        "class": "meta_field"
    });
    tr.hide();
    this.table.append(tr);

    this.rows.push( new meta_field({
        row: tr,
        fields: this.fields,
        data: data
    }) );

    tr.show("slide");
}

meta_container.prototype.load = function(data) {
    var that = this;
    $.each(data, function(k,v) {
        that.add_row( v );
    });
}

meta_container.prototype.get = function() {
    var ret = [];

    for( var i = 0; i < this.rows.length; i++ ) {
        ret.push( this.rows[i].get() );
    }
    return( ret );
}

// ===========================================================================
// parts of the config interface
// ===========================================================================
function meta_field(init) {
    this.init = init;

    this.cells = [];
    this.is_deleted = false;
    this.create();
}

meta_field.prototype.text_field = function(field) {
    var td = $("<td />");
    var input = $("<input />", {
        name: field.name,
        value: field.value
    });
    td.append(input);
    this.cells.push(input);
    return(td);
}

meta_field.prototype.field_option = function(parm) {
    var option = $("<option />", {
        value: parm.value,
        text: parm.value
    });

    if( parm.parent_value === parm.value ) {
        option.attr("selected", "selected");
    }
    return(option);
}

meta_field.prototype.dropdown_field = function(field) {
    var td = $("<td />");
    var input = $("<select />", {
        name: field.name
    });

    var to_add = field.options.split(",");
    for( var i = 0; i < to_add.length; i++ ) {
        input.append( this.field_option({
            value: to_add[i],
            parent_value: field.value
        }));
    }
    td.append(input);
    this.cells.push(input);
    return(td);
}

// actually each "field" is a collection of form fields
meta_field.prototype.get = function() {
    var ret = {};

    ret["meta_id"] = this.init.data.id;
    ret["order_num"] = -1;
    ret["is_deleted"] = this.is_deleted;

    for( var i = 0; i < this.cells.length; i++ ) {
        var k = $(this.cells[i]).attr("name");
        var v = $(this.cells[i]).val();
        ret[k] = v;
    }
    return( ret );
}

meta_field.prototype.remove_button = function() {
    var td = $("<td />");
    var a = $("<a href='#' class='remove-field' title='Mark for deletion'>-</a>");
    var that = this;

    a.click(function() {
        if( that.init.row.hasClass("to-be-deleted") ) {
            that.init.row.animate({ opacity: 1 }, 300, function() {
                that.init.row.removeClass("to-be-deleted");
                a.attr("title", "Mark for deletion");
                that.is_deleted = false;
            });
        } else {
            that.init.row.animate({ opacity: 0.1 }, 300, function() {
                that.init.row.addClass("to-be-deleted");
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
    var that = this;
    $.each(this.init.fields, function(k,v) {

        var p = {
            name: v.name,
            value: that.init.data[v.name],
            options: v.options
        }

        switch(v.type) {
            case 'text':
                that.init.row.append(that.text_field(p));
            break;

            case 'dropdown':
                that.init.row.append(that.dropdown_field(p));
            break;

            default:
                console.error( "Error: meta type " + v.type + " not supported");
            break;
        }
    });

    this.init.row.append(this.remove_button() );
}

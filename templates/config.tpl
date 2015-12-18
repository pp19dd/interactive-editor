{extends file="template.tpl"}

{block name="title"}
<title>Interactives</title>
{/block}

{block name="head"}
<script type="text/javascript">
var meta = {$meta|json_encode};
</script>
{/block}

{block name="foot"}
<script type="text/javascript">
var meta_fields = [];
for( var i = 0; i < meta.length; i++ ) {
    meta_fields.push(
        new meta_field(meta[i])
    );
}

$("#add_field").click(function() {
    add_meta_field( { container: meta_fields } );
    return(false);
});

$("#save_timeline_config").click(function() {
    save_config( {$timeline->id}, this );
    return(false);
});

</script>
{/block}

{block name="slides"}
<upper>
    <pad>
        <h1>
            &nbsp;
        </h1>
    </pad>
</upper>
<lower>
    <sidebar-menu>
        <a class="create-new" href="{$home}/">
            Cancel
        </a>
    </sidebar-menu>
</lower>
{/block}

{block name="actions"}
<upper>
    <pad>
        <h1>
            &nbsp;
        </h1>
    </pad>
</upper>
<lower>
    <sidebar-menu>
        <button id="save_timeline_config">Save Timeline Config</button>
    </sidebar-menu>
</lower>
{/block}

{block name="content"}
<upper>
    <pad>
        <h1>Interactive</h1>
    </pad>
</upper>
<lower>

{function name=row}
<tr class="{cycle values='even,odd'}">
    <td class="field_key">{$label}</td>
    <td class="field_value">
        <input autocomplete="off" type="text" name="{$key}" value="{$value}" />
    </td>
</tr>
{/function}

{function name=row_field}
<tr class="{cycle values='even,odd'}">
    <td class="field_key">{$label}</td>
    <td class="field_value">
        <input autocomplete="off" type="text" name="{$key}" value="{$value}" />
    </td>
</tr>
{/function}

<table class="timeline_config">
{row label="Title" key="title" value=$timeline->title}
{row label="Subtitle" key="subtitle" value=$timeline->subtitle}
{row label="Template" key="template" value=$timeline->template}
</table>

<pad>
    <h1>Slide Fields</h1>
</pad>

<table class="timeline_meta" id="timeline_meta">
    <thead>
        <tr>
            <th>Series</th>
            <th>Position</th>
            <th>Label</th>
            <th>Template Symbol</th>
            <th>Type</th>
            <th>Possible Values</th>
            <th>Default Value</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>

<p><a id="add_field" class="add-field" href="">+ Add Field</a></p>

<pad>
    <notes>
        <p>Notes:</p>
        <ul>
            <li>Dropdown, Radio: enter possible values separated by a comma.</li>
            <li>Checkbox: leave possible values blank, default value can be blank (unchecked) or any text (checked).</li>
        </ul>
    </notes>
</pad>

</lower>
{/block}

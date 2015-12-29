{extends file="template.tpl"}

{block name="title"}
<title>Interactives</title>
{/block}

{block name="head"}
<script type="text/javascript" src="{$home}/js/config.js?rand={$smarty.now}"></script>
<script type="text/javascript">
var meta = {$meta|json_encode};
</script>
{/block}

{block name="foot"}
<script type="text/javascript">

var slide_fields = new meta_container("#timeline_meta");
slide_fields.load(meta);

$("#save_timeline_config").click(function() {
    save_config( {$timeline->id}, this, slide_fields );
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
            <th data-name="series"          data-type="text">Series</th>
            <th data-name="position"        data-type="dropdown" data-options="before,after,sidebar" >Position</th>
            <th data-name="label"           data-type="text">Label</th>
            <th data-name="symbol"          data-type="text">Template Symbol</th>
            <th data-name="type"            data-type="dropdown" data-options="text,textarea,dropdown,checkbox,radio">Type</th>
            <th data-name="possible_values" data-type="text">Possible Values</th>
            <th data-name="default_value"   data-type="text">Default Value</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>

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

{extends file="template.tpl"}

{block name="title"}
<title>Interactives</title>
{/block}

{block name="head"}
<style>

</style>
{/block}

{block name="head"}
<script type="text/javascript">
</script>
{/block}

{block name="foot"}
<script type="text/javascript">
</script>
{/block}

{block name="slides"}
<upper>
    <logo>
        <h1>
            &nbsp;
        </h1>
    </logo>
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
    <logo>
        <h1>
            &nbsp;
        </h1>
    </logo>
</upper>
<lower>
    <sidebar-menu>
        <button>Save</button>
    </sidebar-menu>
</lower>
{/block}

{block name="content"}
<upper>
    <logo>
        <h1>Interactive</h1>
    </logo>
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

<logo>
    <h1>Slide Fields</h1>
</logo>

<table class="timeline_config">
    <thead>
        <tr>
            <th>Series</th>
            <th>Label</th>
            <th>Template Symbol</th>
            <th>Type of Field</th>
            <th>Default Value</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><input name="series[]" /></td>
            <td><input name="label[]" /></td>
            <td><input name="symbol[]" /></td>
            <td><input name="type[]" /></td>
            <td><input name="default[]" /></td>
        </tr>
    </tbody>
</table>
</lower>
{/block}

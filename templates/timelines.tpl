{extends file="template.tpl"}

{block name="title"}
<title>Interactives</title>
{/block}

{block name="head"}
<style>
actions { display: none }
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
        <a class="create-new" href="{$home}/new">
            Create New Interactive
        </a>
    </sidebar-menu>
</lower>
{/block}

{block name="content"}
<upper>
    <logo>
        <h1>Interactive Editor</h1>
    </logo>
</upper>
<lower>
<table class="timelines">

{foreach from=$timelines item=timeline}
    <tr class="{cycle values='odd,even'}">
        <td><pid>{$timeline->id}</pid/></td>
        <td><posted>{$timeline->created_on}</posted/></td>
        <td><headline>{$timeline->title}</headline></td>
        <td>
            <a href="{$home}/config/{$timeline->id}">Config</a>
        </td>
        <td>
            <a href="{$home}/interactive/{$timeline->id}">Edit</a>
        </td>
    </tr>
{/foreach}
</table>
</lower>
{/block}

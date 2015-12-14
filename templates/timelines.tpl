{extends file="template.tpl"}

{block name="title"}
<title>Interactives</title>
{/block}

{block name="head"}
<style>
actions { display: none }
logo h1 { font-size:2em; color: gray }
logo { padding: 1em }
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
    <button>Create New Interactive</button>
</upper>
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
{for $x = 1 to 75}
    <tr class="{cycle values='odd,even'}">
        <td><pid>{$timeline->id}</pid/></td>
        <td><posted>{$timeline->created_on}</posted/></td>
        <td><headline>{$timeline->title}</headline></td>
        <td>
            <a href="{$home}/interactive/{$timeline->id}">Edit</a>
        </td>
    </tr>
{/for}
{/foreach}
</table>
</lower>
{/block}

{extends file="template.tpl"}

{block name="title"}
<title>ie #{$timeline->id}: {$timeline->title}</title>
{/block}

{block name="head"}
<script type="text/javascript" src="{$home}/js/timeline.js?rand={$smarty.now}"></script>
<script type="text/javascript">
timeline = new ieTimeline({ id: {$timeline->id} });
</script>
{/block}

{block name="foot"}
<script type="text/javascript">
</script>
{/block}

{block name="slides"}
<upper id="slides_upper">
    <interactive>
        <h1>{$timeline->title}</h1>
        <h2>{$timeline->subtitle}</h2>
    </interactive>
    <button>add slide</button>
    <button>preview</button>
    <button>publish</button>
</upper>
<lower id="slides_lower">
{*for $x = 1 to 75}
    <slide>
        slide #{$x}
    </slide>
{/for*}
</lower>
{/block}

{block name="actions"}
<upper id="actions_upper">
{*
    <button>save</button>
    <button>cancel</button>
*}
</upper>
<lower id="actions_lower">
{*for $x = 1 to 35}
    <action>
        <p>action #{$x}</p>
    </action>
{/for*}
</lower>
{/block}

{block name="content"}

<upper class="editor" id="editor_upper"></upper>
<lower class="editor" id="editor_lower">
{*
<pre>{$timeline|print_r}</pre>
*}
</lower>

{/block}

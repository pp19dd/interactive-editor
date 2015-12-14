{extends file="template.tpl"}

{block name="title"}
<title>Interactives</title>
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
    <p>interactive-editor</p>
    <button>add slide</button>
    <button>preview</button>
    <button>publish</button>
</upper>
<lower>
{for $x = 1 to 75}
    <slide>
        slide #{$x}
    </slide>
{/for}
</lower>
{/block}

{block name="actions"}
<upper>
    <button>save</button>
    <button>cancel</button>
</upper>
<lower>
{for $x = 1 to 35}
    <action>
        <p>action #{$x}</p>
    </action>
{/for}
</lower>
{/block}

{block name="content"}

<upper class="editor">
    <post-field>
        <post-field-label>Title</post-field-label>
        <post-input><input name="title" type="text" /></post-input>
    </post-field>

    <post-field>
        <post-field-label>Slug</post-field-label>
        <post-input><input name="slug" type="text" /></post-input>
    </post-field>
</upper>
<lower class="editor">

<pre>{$timeline|print_r}</pre>

</lower>

{/block}

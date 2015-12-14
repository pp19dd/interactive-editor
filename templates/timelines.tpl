<!doctype html>
<html>
<head>
<title>timeline #</title>
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="{$home}/css/html5-reset.css" />
<link rel="stylesheet" type="text/css" href="{$home}/css/main.css" />
<script type="text/javascript" src="{$home}/js/jquery/jquery-1.11.3.min.js"></script>
</head>
<body>
    <content>
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

{for $x = 1 to 500}
    This is a sentence # {$x}.
{/for}

{*
        timelines:
        <table>

{foreach from=$timelines item=timeline}
            <tr class="{cycle values='odd,even'}">
                <td><pid>{$timeline->id}</pid/></td>
                <td><posted>{$timeline->created_on}</posted/></td>
                <td><headline>{$timeline->title}</headline></td>
            </tr>
{/foreach}
{/for}
        </table>
*}
        </lower>
    </content>
    <slides>
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
    </slides>
    <actions>
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
    </actions>

<script type="text/javascript">
</script>

</body>
</html>

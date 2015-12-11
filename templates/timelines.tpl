<!doctype html>
<html>
<head>
<title>timeline #</title>
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="{$home}/css/html5-reset.css" />
<style type="text/css">
body, html {
    width:100%;
    height:100%;
    margin:0;
    padding:0;
    overflow: hidden;
}
body {
    width:auto;
    display: flex;
    flex-direction: row;
    flex-wrap: nowrap;
    justify-content: space-between;
    align-items: stretch;
    height:100%;
    font-family: Helvetica,Arial,sans-serif;
}
content {
    background-color: silver;
    width:100%;
}
slides {
    order: -1;
    background-color: orange;
    xmin-width:250px;
    flex :0 0 250px;
}
slide {
    xpadding:1em;
}
actions {
    background-color: yellow;
    xin-width:250px;
    flex :0 0 250px;
}
upper {
    xborder: 3px dotted gray;
}

upper,lower {
    display: flex;
    flex-direction: column;
    flex-wrap:stretch;
    overflow-y: auto;
    justify-content: center;
    align-items: stretch;
}
slide {
    flex: 1;
}
lower {
    overflow-y: auto;
    flex:2;
}
</style>
</head>
<body>
    <content>
        <upper>
            <post-field>
                <post-field-label>Title</post-field-label>
                <post-input><input name="title" type="text" /></post-input>
            </post-field>

            <post-field>
                <post-field-label>Slug</post-field-label>
                <post-input><input name="slug" type="text" /></post-input>
            </post-field>
        </upper>
        <lower>

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
            interactive-editor
        </upper>
        <lower>
{for $x = 1 to 75}
        <slide>slide #{$x}</slide>
{/for}
        </lower>
    </slides>
    <actions>
        <upper>
            [save]<br/>
            [cancel]
        </upper>
        <lower>
{for $x = 1 to 35}
            <action>
                action #{$x}
            </action>
{/for}
        </lower>
    </actions>
</body>
</html>

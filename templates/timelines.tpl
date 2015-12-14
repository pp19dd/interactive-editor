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
    height:100%;
    display: flex;
    flex-direction: column;
}
slides {
    order: -1;
    background-color: orange;

}
slides, actions {

    display: flex;
    flex-direction: column;

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

upper,lower {
}
slide {

}
upper {
}
lower {
    overflow-y: auto;
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
            <p>interactive-editor</p>
            <p><button>save</button></p>
        </upper>
        <lower>
{for $x = 1 to 75}
        <p>slide #{$x}</p>
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
                <p>action #{$x}</p>
            </action>
{/for}
        </lower>
    </actions>
</body>
</html>

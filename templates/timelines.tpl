<!doctype html>
<html>
<head>
<title>timeline #</title>
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="{$home}/css/html5-reset.css" />
<style>

table { border-collapse: collapse; width:100% }
td { padding: 5px; padding-right: 3em; }
.odd { }
.even { background-color: rgb(230,230,230); }

.hg {
    display: flex;
    min-height:100vh;
    flex-direction: column;
}

header {
    flex: 1 0 10%;
    background-color: yellow;
    height:100px;
    position: fixed;
}

hgbody {
    display: flex;
    flex: 1;
}

hgcontents {
    flex: 1;
    background-color: gray;
}

slides {
    background-color: red;
    flex: 0 0 300px;
    order: -1;
    display: flex;
    flex-direction: column;
}

slide {
    flex: 1;

}

actions {
    background-color: silver;
    flex: 0 0 200px;
}

</style>
</head>
<body class="hg">
    <hgbody>
        <hgcontents>
ac
{*
            timelines:
            <table>
{for $x = 1 to 50}
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
        </hgcontents>
        <slides>
            <header>
                interactive-editor
            </header>
            slides

{for $x = 1 to 50}
                <slide>slide #{$x}</slide>
{/for}
        </slides>
        <actions>
            actions
        </actions>
    </hgbody>
</body>
</html>

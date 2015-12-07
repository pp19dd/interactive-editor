<!doctype html>
<html>
<head>
<title>timeline #</title>
<meta charset="utf-8" />
<style>
* { font-family: Arial; font-size:14px  }
table { border-collapse: collapse; width:100% }
td { padding: 5px; padding-right: 3em; }
.odd { }
.even { background-color: rgb(230,230,230); }
</style>
</head>
<body>
    <table>
{foreach from=$timelines item=timeline}
<tr class="{cycle values='odd,even'}">
    <td><pid>{$timeline->PID}</pid/></td>
    <td><posted>{$timeline->post_date}</posted/></td>
    <td><headline>{$timeline->post_title}</headline></td>
</tr>
{/foreach}
</table>
</body>
</html>

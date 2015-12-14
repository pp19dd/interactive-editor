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
    display: flex;
    flex-direction: column;
}

upper,lower {

}

upper {
    background-color: red;
}
lower {
    overflow-y: scroll;
}
</style>
</head>
<body>
    <content>
        <upper>
            <p>hi</p>
            <button>test</button>
        </upper>
        <lower>

{for $x = 1 to 500}
    This is a sentence # {$x}.
{/for}

        </lower>
    </content>

</body>
</html>

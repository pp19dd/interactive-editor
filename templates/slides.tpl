
{foreach from=$slides item=slide}
<slide data-order="{$slide->num_order}">
    <slide-num>#{$slide@index}</slide-num>
    <slide-slug>{$slide->slug}</slide-slug>
    <slide-title>{$slide->title}</slide-title>
    <slide-series>{$slide->series}</slide-series>
    <a href="javascript:timeline.loadSlide({$slide->id})">Edit</a>
</slide>
{/foreach}

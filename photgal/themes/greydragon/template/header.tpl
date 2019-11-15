<!DOCTYPE html>
<html lang="{$lang_info.code}" dir="{$lang_info.direction}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset={$CONTENT_ENCODING}">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
{if $greydragon.p_nogenerator !== "on"}
<meta name="generator" content="Piwigo (aka PWG), see piwigo.org">
{/if}
{if isset($meta_ref)}
{if isset($INFO_AUTHOR)}
<meta name="author" content="{$INFO_AUTHOR|@strip_tags:false|@replace:'"':' '}">
{/if}
{if isset($related_tags)}
<meta name="keywords" content="{foreach from=$related_tags item=tag name=tag_loop}{if !$smarty.foreach.tag_loop.first}, {/if}{$tag.name}{/foreach}">
{/if}
{if isset($COMMENT_IMG)}
<meta name="description" content="{$COMMENT_IMG|@strip_tags:false|@replace:'"':' '}{if isset($INFO_FILE)} - {$INFO_FILE}{/if}">
{else}
<meta name="description" content="{$PAGE_TITLE}{if isset($INFO_FILE)} - {$INFO_FILE}{/if}">
{/if}
{/if}
<title>{if $PAGE_TITLE!=l10n('Home') && $PAGE_TITLE!=$GALLERY_TITLE}{$PAGE_TITLE} | {/if}{$GALLERY_TITLE}</title>
{if $greydragon.p_favicon_ico}<link href="{$ROOT_URL}{$greydragon.p_favicon_ico}" rel="shortcut icon" type="image/x-icon">
{else}<link href="{$ROOT_URL}{$themeconf.icon_dir}/favicon.ico" rel="shortcut icon" type="image/x-icon">{/if}
{if $greydragon.p_favicon_png}<link href="{$ROOT_URL}{$greydragon.p_favicon_png}" rel="icon" type="image/png">{/if}
{if $greydragon.p_favicon_gif}<link href="{$ROOT_URL}{$greydragon.p_favicon_gif}" rel="icon" type="image/gif">{/if}
{if $greydragon.p_favicon_apple}{if $greydragon.p_favicon_noshine == "on"}<link href="{$ROOT_URL}{$greydragon.p_favicon_apple}" rel="apple-touch-icon-precomposed">
{else}<link href="{$ROOT_URL}{$greydragon.p_favicon_apple}" rel="apple-touch-icon">{/if}{/if}

<link rel="start" title="{'Home'|@translate}" href="{$U_HOME}" >
<link rel="search" title="{'Search'|@translate}" href="{$ROOT_URL}search.php" >
{if isset($first.U_IMG)   }<link rel="first" title="{'First'|@translate}" href="{$first.U_IMG}" >{/if}
{if isset($previous.U_IMG)}<link rel="prev" title="{'Previous'|@translate}" href="{$previous.U_IMG}" >{/if}
{if isset($next.U_IMG)    }<link rel="next" title="{'Next'|@translate}" href="{$next.U_IMG}" >{/if}
{if isset($last.U_IMG)    }<link rel="last" title="{'Last'|@translate}" href="{$last.U_IMG}" >{/if}
{if isset($U_UP)          }<link rel="up" title="{'Thumbnails'|@translate}" href="{$U_UP}" >{/if}
{assign var=root value="themes/greydragon/css"}
{assign var=local value="local/greydragon"}
{assign var=colorpack value=$root|cat:"/colorpack/"|cat:$greydragon.p_colorpack|cat:"/styles.css"}
{combine_css path="themes/greydragon/css/bootstrap.min.css" order=-100}
{combine_css path="themes/greydragon/css/all.min.css" order=-100}
{combine_css path="themes/greydragon/css/styles.css" order=100}
{combine_css path="$colorpack" order=101}
{if isset($greydragon.p_customcss) || $greydragon.p_lowertext == "on"}
  {if $local|cat:"/custom.css"|file_exists}
    {combine_css path="local/greydragon/custom.css" order=101}
  {/if}
{/if}
{combine_script id='greydragon.bootstrap' load='footer' require='jquery' path='themes/greydragon/js/bootstrap.min.js' order=98}
{combine_script id='greydragon.cookie' load='footer' require='jquery' path='themes/greydragon/js/jquery.cockie.js' order=99}
{if $SCRIPT_NAME|strstr:"picture.php"}
{assign var=includeMenu value="off" scope=root nocache}
{elseif $SCRIPT_NAME|strstr:"identification.php"}
{assign var=includeMenu value="off" scope=root nocache}
{elseif $SCRIPT_NAME|strstr:"profile.php"}
{assign var=includeMenu value="off" scope=root nocache}
{elseif $SCRIPT_NAME|strstr:"password.php"}
{assign var=includeMenu value="off" scope=root nocache}
{elseif $SCRIPT_NAME|strstr:"register.php"}
{assign var=includeMenu value="off" scope=root nocache}
{elseif $BODY_ID == 'theHomePage'} 
{assign var=includeMenu value="off" scope=root nocache}
{elseif $BODY_ID == 'theIdentificationPage'}
{assign var=includeMenu value="off" scope=root nocache}
{elseif $BODY_ID=='thePicturePage'}
{assign var=includeMenu value="off" scope=root nocache}
{else}
{assign var=includeMenu value="on" scope=root nocache}
{/if}
{footer_script}
  jQuery("div.infos").delay(8000).animate({ 'width': 'hide' }, 500, function(){ jQuery(this).hide(); });
  jQuery("div.warnings").delay(8000).animate({ 'width': 'hide' }, 500, function(){ jQuery(this).hide(); });
  jQuery("div.errors").click(function() { jQuery(this).animate({ 'width': 'hide' }, 500, function(){ jQuery(this).hide(); }); });
{if $includeMenu=="on"} 
  {combine_script id='greydragon.scripts' load='footer' require='jquery' path='themes/greydragon/js/theme.menu.js' order=100}
  {if ($greydragon.p_main_menu_close == "on") && (($greydragon.p_main_menu == "opened") || ($greydragon.p_main_menu == "closed"))}
  var p_main_menu = "force_hide";
  {elseif isset({$greydragon.p_main_menu})}
  var p_main_menu = "{$greydragon.p_main_menu}";
  {else}
  var p_main_menu = "hidden";
  {/if}
  var p_animated_menu = "{$greydragon.p_animated_menu}";
  var p_hideabout = "{$greydragon.p_hideabout}";
{/if}
  var p_pict_descr = "{$greydragon.p_pict_descr}";
  var p_pict_comment = "{$greydragon.p_pict_comment}";
  var p_pict_tab_anim = "{$greydragon.p_pict_tab_anim}";
  jQuery("#ato_header .parent:eq(0) ul").append('<li><a class="icon-brush" href="{$greydragon.U_SITE_ADMIN}theme&theme=greydragon">{'Theme Config'|@translate}</a></li>');
{/footer_script}
{get_combined_css}
{foreach from=$themes item=theme}
{if $theme.load_css}
{combine_css path="themes/`$theme.id`/theme.css" order=-10}
{/if}
{if !empty($theme.local_head)}{include file=$theme.local_head load_css=$theme.load_css}{/if}
{/foreach}

{if isset($U_PREFETCH)}<link rel="prefetch" href="{$U_PREFETCH}">{/if}
{if isset($U_CANONICAL)}<link rel="canonical" href="{$U_CANONICAL}">{/if}

{if not empty($page_refresh)    }<meta http-equiv="refresh" content="{$page_refresh.TIME};url={$page_refresh.U_REFRESH}">{/if}

{get_combined_scripts load='header'}

<!--[if lt IE 7]>
<script type="text/javascript" src="{$ROOT_URL}themes/default/js/pngfix.js"></script>
<![endif]-->

{combine_script id="jquery" load="footer"}

{if not empty($head_elements)}
  {foreach from=$head_elements item=elt}{$elt}
  {/foreach}
{/if}
</head>
<body id="{$BODY_ID}" class="{if $includeMenu=="on"}{$greydragon.p_main_menu}-menu{else}hide-menu{/if}{if $PAGE_BANNER}{else} no-header{/if}{if $greydragon.p_nocounter == "on"} no-b-counter{/if} theme-{$greydragon.p_colorpack}">
<div id="the_page">
{if not empty($header_msgs)}
  <div class="header_msgs">
    {foreach from=$header_msgs item=elt}
    {$elt}<br>
    {/foreach}
  </div>
{/if}
{if $PAGE_BANNER}
  <div id="theHeader">{$PAGE_BANNER}</div>
{/if}
{if isset($theSwiftHeader)}{$theSwiftHeader}{/if}
{if not empty($header_notes)}
  <div class="header_notes">
    {foreach from=$header_notes item=elt}
    <p>{$elt}</p>
    {/foreach}
  </div>
{/if}
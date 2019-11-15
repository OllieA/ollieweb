<?php
/*
Theme Name: GreyDragon
Version: 1.3.2
Description: GreyDragon Theme
Theme URI: http://piwigo.org/ext/extension_view.php?eid=775
Author: Serge Dosyukov
Author URI: http://blog.dragonsoft.us
*/

if (!defined('PHPWG_ROOT_PATH')) die('Hacking attempt!');

define('GDTHEME_ID',   basename(dirname(__FILE__)));
if (!defined('GDTHEME_PATH')):
  define('GDTHEME_PATH', PHPWG_THEMES_PATH . GDTHEME_ID . '/');
endif;
require_once( GDTHEME_PATH . 'include/greydragon.class.php');
require_once( GDTHEME_PATH . 'admin/upgrade.inc.php');

$themeCore = greyDragonCore::Instance(GDTHEME_VERSION);

$themeconf = array(
  'name'  => 'greydragon',
  'parent' => 'default',
  'colorscheme' => 'whitehawk' == $themeCore->getOption('p_colorpack') ? 'clear' : 'dark'
);

add_event_handler('init', 'greydragon_init');

if (defined('IN_ADMIN')) {
  add_event_handler('loc_after_page_header', 'greydragon_add_admin_controller');
}

// Load Theme's Parameters
function greydragon_init() {
  global $template;

  $themeCore = greyDragonCore::Instance();

  if ($themeCore->hasCustomFavicon() || $themeCore->hasOption("p_header") || $themeCore->hasOption('page_banner', TRUE)):
    add_event_handler('render_page_banner', 'greydragon_render_header');
  endif;
  if ($themeCore->getOption("p_nocounter") == "on"):
    add_event_handler('loc_end_index', 'greydragon_nobreadcrumb_counter');
  endif;
  if ($themeCore->getOption("p_pict_tab_exif") == "off"):
    pwg_set_session_var('show_metadata', 0);
  else:
    pwg_set_session_var('show_metadata', 1);
  endif;

  $template->assign('greydragon', $themeCore->getConfig());

  $template->smarty->registerPlugin("modifier", "get_x_half", "greydragon_array_getXhalf");
  $template->smarty->registerPlugin("modifier", "get_y_half", "greydragon_array_getYhalf");

  // Allow dynamic addition of metadata tabs content
  add_event_handler('loc_begin_picture', 'greydragon_picture_handler');
}

function greydragon_add_admin_controller() {
  global $template, $page, $user;

  $template->assign(array(                                               
    'GDTHEME_PATH' => GDTHEME_PATH
  ));

  $template->set_filename('gdtheme_admin_controller', realpath(GDTHEME_PATH . 'admin/admin_controller.tpl'));
  $template->parse('gdtheme_admin_controller');
}

function greydragon_array_getXhalf($array) {
  if (isset($array) && (count($array) > 0)):
    return (int)($array[0] / 2);
  else:
    return "";
  endif;
}

function greydragon_array_getYhalf($array) {
  if (isset($array) && (count($array) > 1)):
    return (int)($array[1] / 2);
  else:
    return 1000;
  endif;
}

function greydragon_picture_handler() {
  global $template;

  $template->set_prefilter('picture', 'greydragon_prepare_meta');
}

function greydragon_prepare_meta($tpl_source, &$smarty) {

  $metadata = greyDragonCore::Instance()->getPageTabs();

  $content  = $tpl_source;
  if ($metadata["icon"]):
    $pattern  = '#{\*GD_META_ICO\*}#';
    $replace  = $metadata["icon"] . "{*GD_META_ICO*}";
    $content  = preg_replace($pattern, $replace, $content, 1);
  endif;
  if ($metadata["text"]):
    $pattern  = '#{\*GD_META_TXT\*}#';
    $replace  = $metadata["text"] . "{*GD_META_TXT*}";
    $content  = preg_replace($pattern, $replace, $content, 1);
  endif;
  if ($metadata["content"]):
    $pattern  = '#{\*GD_META_CONTENT\*}#';
    $replace  = $metadata["content"] . "{*GD_META_CONTENT*}";
    $content  = preg_replace($pattern, $replace, $content, 1);
  endif;

  $pattern  = '#<div.*"theImageAndInfos".*>#';
  $replace  = '$0
    {if isset($previous.U_IMG)}<a class="gd-nav nav-prev" title="{\'Previous\'|@translate}" href="{$previous.U_IMG}"><i class="fas fa-angle-left"></i></a>{/if}
    {if isset($next.U_IMG)    }<a class="gd-nav nav-next" title="{\'Next\'|@translate}" href="{$next.U_IMG}"><i class="fas fa-angle-right"></i></a>{/if}
    {if isset($U_UP)          }<a class="gd-nav nav-up"   title="{\'Up\'|@translate}" href="{$U_UP}"><i class="fas fa-angle-up"></i></a>{/if}
{*    <a class="gd-nav nav-zoom" title="{\'Full HD\'|@translate}" href="{$U_UP}">&nbsp;</a> *}
  {html_head} 
    <style type="text/css">{strip}
      {if $current.selected_derivative}
      #theImageAndInfos .gd-nav.nav-prev {ldelim} margin-left: {if $DISPLAY_NAV_THUMB}calc(-142px - {else}-{/if}{$current.selected_derivative->get_size()|get_x_half}px{if $DISPLAY_NAV_THUMB}){/if} !important; top: {$current.selected_derivative->get_size()|get_y_half}px; {rdelim}
      #theImageAndInfos .gd-nav.nav-next {ldelim} margin-right: {if $DISPLAY_NAV_THUMB}calc(146px - {else}-{/if}{$current.selected_derivative->get_size()|get_x_half}px{if $DISPLAY_NAV_THUMB}){/if} !important; top: {$current.selected_derivative->get_size()|get_y_half}px; {rdelim}
      {if $DISPLAY_NAV_THUMB}#theImageAndInfos .gd-nav.nav-up {ldelim} margin-left: -182px; {rdelim}{/if}
      {else}
      #theImageAndInfos .gd-nav.nav-prev {ldelim} margin-left: -32% !important; top: 40%; {rdelim}
      #theImageAndInfos .gd-nav.nav-next {ldelim} margin-right: -32% !important; top: 40%; {rdelim}
      {/if}
{*      #theImageAndInfos .gd-nav.nav-zoom {ldelim} top: {$current.selected_derivative->get_size()|get_y_half}px; {rdelim} *}
    {/strip}</style>
  {/html_head}';

  $content  = preg_replace($pattern, $replace, $content, 1);

  return $content;
}

// Render custom header content
function greydragon_render_header() {
  return greyDragonCore::Instance()->getHeader();
}

function greydragon_nobreadcrumb_counter() {
  global $template;

  $titre = $template->get_template_vars('TITLE');
  $pos = strrpos($titre,"[");
  if ($pos !== false):
    $template->assign('TITLE', substr($titre, 0, $pos));
  endif;
}

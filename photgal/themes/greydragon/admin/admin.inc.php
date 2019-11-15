<?php

if (!defined('PHPWG_ROOT_PATH')) die('Hacking attempt!');

require_once( PHPWG_THEMES_PATH . 'greydragon/include/greydragon.class.php');
require_once( PHPWG_THEMES_PATH . 'greydragon/admin/upgrade.inc.php');

load_language('theme.lang', PHPWG_THEMES_PATH.'greydragon/');

$themeCore = greyDragonCore::Instance(GDTHEME_VERSION);
$themeroot = './themes/' . basename(dirname(dirname(__FILE__))) . '/';

// Store settings on Save
if ($themeCore->hasSettingFromPost('submit_greydragon')):

  if ($themeCore->getSettingFromPost('p_main_menu') == "static"):
    $_POST['p_expand_main_menu'] = "off";
  endif;

  $themeCore->saveSettingsFromPost();

  if ($themeCore->getOption('p_rootpage') == 'on'):
    global $prefixeTable, $conf;
    $ap_conf = @unserialize($conf['additional_pages']);
    if ($ap_conf['homepage']):
      $config_temp = $themeCore->getConfig();
      if ($themeCore->prepareHomePage($prefixeTable, $ap_conf['homepage'])):
        array_push($page['infos'], l10n('Home Page Content for "Additional Pages" plugin has been updated'));
      endif;
    else:
      array_push($page['infos'], l10n('Please Create Home Page in "Additional Pages" Plugin'));
    endif;
  endif;

  $config_min = $themeCore->getConfig(FALSE);
  $conf['greydragon'] = serialize($config_min);
  conf_update_param('greydragon', pwg_db_real_escape_string($conf['greydragon']));

  $themeCore->prepareCustomCSS();

  pwg_set_session_var( 'purge_template', 1 );

  array_push($page['infos'], l10n('Theme Settings are saved'));
endif;

$template->set_filenames(array('theme_admin_content' => dirname(__FILE__) . '/admin.tpl'));

foreach ($template->smarty->tpl_vars['plugin_menu_items']->value as $key => $value):
  if ($value["NAME"] == "Additional Pages"):
    $themeCore->setSetting("hasAP", "yes");
  endif;
  if ($value["NAME"] == "Extended Description"):
    $themeCore->setSetting("hasED", "yes");
  endif;
  if ($value["NAME"] == "gdThumb"):
    $themeCore->setSetting("hasGT", "yes");
  endif;
  if ($value["NAME"] == "Admin Tools"):
    $themeCore->setSetting("hasAT", "yes");
  endif;
endforeach;

$themeCore->setSetting("pwgVer", PHPWG_VERSION);
if (PHPWG_VERSION >= '2.7.0'):
  $themeCore->setSetting("hasMinVer", "yes");
endif;

$packlist = $themeCore->getColorPackList();

// Ensure default values are set
$template->assign('options', $themeCore->getConfig());
$template->assign('colorpackArr', $packlist);
$template->assign_var_from_handle('ADMIN_CONTENT', 'theme_admin_content');

?>
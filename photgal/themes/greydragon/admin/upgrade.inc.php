<?php

if (!defined('PHPWG_ROOT_PATH')) die('Hacking attempt!');

global $prefixeTable, $conf;

require_once( PHPWG_THEMES_PATH . 'greydragon/include/greydragon.class.php');

if (!isset($conf['greydragon'])):
  // Only need to ensure that there is a record in DB. Theme supports self initialization
  $conf['greydragon'] = array();
  conf_update_param('greydragon', $conf['greydragon'], true);
else:
  // Nothing to upgrade
endif;
?>
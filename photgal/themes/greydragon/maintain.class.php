<?php
defined('PHPWG_ROOT_PATH') or die('Hacking attempt!');

require_once( PHPWG_THEMES_PATH . 'greydragon/include/greydragon.class.php');

class greydragon_maintain extends PluginMaintain {

  private $themeCore;

  function __construct($plugin_id) {
    parent::__construct($plugin_id); // always call parent constructor

    $this->themeCore = greyDragonCore::Instance(GDTHEME_VERSION);
  }

  /**
   * Plugin installation
   */
  function install($plugin_version, &$errors=array()) {
    $this->themeCore->update("0.0", $plugin_version);
  }

  /**
   * Plugin (auto)update
   */
  function update($old_version, $new_version, &$errors=array()) {
    $this->themeCore->update($old_version, $new_version);
  }

  /**
   * Plugin uninstallation
   */
  function uninstall() {
    $this->themeCore->uninstall();
  }
}
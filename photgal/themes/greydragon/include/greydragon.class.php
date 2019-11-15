<?php

if (!defined('PHPWG_ROOT_PATH')) die('Hacking attempt!');

define('GDTHEME_VERSION', '1.3.2');

define("QUOTES_NONE",   FALSE);
define("QUOTES_LAZY",   1);
define("QUOTES_SINGLE", 2);
define("QUOTES_SAFE",   4);

final class greyDragonCore {

  // singleton instance 
  private static $instance;
  private static $version;
  private $themeConfig;
  private $themeConfigMin;
  private $dir;
  private $cssfile;

  public static function Instance($ver = '') {
    if (!self::$instance):
      self::$instance = new self($ver);
    endif;
    return self::$instance; 
  }

  private function __construct($ver = ''){
    $this->dir  = PHPWG_ROOT_PATH . PWG_LOCAL_DIR . 'greydragon/';

    self::loadConfig($ver);
  }

  private function getDefaults() {

    return array(
      "p_version"          => array("value" => "",           "quotes" => QUOTES_NONE),

      // General Settings
      "p_logo_path"        => array("value" => null,         "quotes" => QUOTES_NONE),
      "p_header"           => array("value" => null,         "quotes" => QUOTES_LAZY),
      "p_footer"           => array("value" => null,         "quotes" => QUOTES_LAZY),
      "p_colorpack"        => array("value" => "greydragon", "quotes" => QUOTES_NONE),

      "p_favicon_ico"      => array("value" => null,         "quotes" => QUOTES_NONE),
      "p_favicon_png"      => array("value" => "",           "quotes" => QUOTES_NONE),
      "p_favicon_gif"      => array("value" => "",           "quotes" => QUOTES_NONE),
      "p_favicon_apple"    => array("value" => "",           "quotes" => QUOTES_NONE),
      "p_favicon_noshine"  => array("value" => "off",        "quotes" => QUOTES_NONE),
    
      // Advanced Options - General
      "p_main_menu"        => array("value" => "closed",     "quotes" => QUOTES_NONE), // static, closed, opened, top, header-bottom, header-top, disabled
      "p_animated_menu"    => array("value" => "off",        "quotes" => QUOTES_NONE),
      "p_main_menu_close"  => array("value" => "off",        "quotes" => QUOTES_NONE),

      "p_lowertext"        => array("value" => "off",        "quotes" => QUOTES_NONE),
      "p_credits"          => array("value" => "off",        "quotes" => QUOTES_NONE),
      "p_nogenerator"      => array("value" => "off",        "quotes" => QUOTES_NONE),
      "p_hideabout"        => array("value" => "off",        "quotes" => QUOTES_NONE),
      "p_adminemail"       => array("value" => "off",        "quotes" => QUOTES_NONE),
      "p_nocounter"        => array("value" => "off",        "quotes" => QUOTES_NONE),

      // Advanced Options - Photo Page 
      "p_pict_tab_mode"    => array("value" => "txt-tab-open", "quotes" => QUOTES_NONE),
      "p_pict_tab_default" => array("value" => "desc",       "quotes" => QUOTES_NONE),
      "p_pict_tab_anim"    => array("value" => "off",        "quotes" => QUOTES_NONE),
      "p_pict_tab_exif"    => array("value" => "on",         "quotes" => QUOTES_NONE),

      // Advanced Options - Root Page 
      "p_rootpage"         => array("value" => "off",    "quotes" => QUOTES_NONE),
      "p_rootpage_desc"    => array("value" => null,     "quotes" => QUOTES_SAFE | QUOTES_LAZY),
      "p_rootpage_link"    => array("value" => "off",    "quotes" => QUOTES_NONE),
      "p_rootpage_src"     => array("value" => "slider", "quotes" => QUOTES_NONE),
      "p_rootpage_size"    => array("value" => "M",      "quotes" => QUOTES_NONE),
      "p_rootpage_id"      => array("value" => 1,        "quotes" => QUOTES_NONE),
      "p_rootpage_mode"    => array("value" => "fade",   "quotes" => QUOTES_NONE),
      "p_rootpage_delay"   => array("value" => 10,       "quotes" => QUOTES_NONE),
      "p_rootpage_elastic" => array("value" => "off",    "quotes" => QUOTES_NONE),
      "p_rootpage_navarr"  => array("value" => "off",    "quotes" => QUOTES_NONE),
      "p_rootpage_navctr"  => array("value" => "off",    "quotes" => QUOTES_NONE),

      'p_customcss'        => array("value" => null,     "quotes" => (QUOTES_LAZY | QUOTES_SINGLE)),
      'p_debug'            => array("value" => "off",    "quotes" => FALSE)
    );
  }

  private function loadConfig($ver = '') {
    global $conf, $pwg_loaded_plugins;

    $this->themeConfigMin = unserialize($conf['greydragon']);
    $this->themeConfigMin["version"] = $ver;
    $this->themeConfigMin["hasUserTags"] = isset($pwg_loaded_plugins['user_tags']);

    $this->themeConfig = $this->validateDefault($this->themeConfigMin);
  }

  private function validateDefault($config) {

    // Check version, perform update if necessary
    if (!isset($config["p_version"]) || ($this->themeConfigMin["version"] !== $config["p_version"])):

      if (isset($config["p_favicon_path"])):
        $config["p_favicon_ico"] = $config["p_favicon_path"];
        unset($config["p_favicon_path"]);
      endif;
    endif;

    $theme_default_settings = $this->getDefaults();

    foreach ($theme_default_settings as $key => $value):
      if (isset($value["value"])):
        if (array_key_exists($key, $config)):
        else:
          $config[$key] = $value["value"];
        endif;
      endif;
    endforeach;

    // Populate some system settings
    $url_root = get_root_url();
    $config['U_SITE_ADMIN'] = $url_root . 'admin.php?page=';

    return $config;
  }

  public function initEvents() {
  }

  public function loadCSS() {
  }

  public function getConfig($isFull = TRUE) {
    if ($isFull):
      return $this->themeConfig;
    else:
      $config = $this->themeConfigMin;
      $config['p_version'] = GDTHEME_VERSION;
      return $config;
    endif;
  }

  public function setSetting($name, $value) {
    $this->themeConfig[$name] = $value;
  }

  public function saveSettingFromPOST($name) {
    $theme_default_settings = $this->getDefaults();

    $isFound  = FALSE;
    $isStored = FALSE;

    if (array_key_exists($name, $theme_default_settings)):
      $setting    = $theme_default_settings[$name];
      $default    = $setting["value"];
      $quotes     = $setting["quotes"];

      if (isset($_POST[$name]) and !empty($_POST[$name])):
        $isFound = TRUE;
        $value   = $_POST[$name];

        if ($value != $default):
          $isStored = TRUE;

          if ($quotes):
            if (($quotes & QUOTES_LAZY) == QUOTES_LAZY):
              $value = str_replace('\"', '"', $value);
              $value = str_replace("\'", "'", $value);
            endif;
            if (($quotes & QUOTES_SINGLE) == QUOTES_SINGLE):
              $value = str_replace("'", '"', $value);
            endif;
            if (($quotes & QUOTES_SAFE) == QUOTES_SAFE):
              $value = str_replace("'", '&apos;', $value);
              $value = str_replace('"', '&quot;', $value);
            endif;

            $value = str_replace("\'", "';", $value);
          endif;
        endif;
      endif;

      if ($isFound):
        $this->themeConfig[$name] = $value;
        if ($isStored):
          $this->themeConfigMin[$name] = $value;
        endif;
      endif;
    endif;

    // Config cleanup
    if ((!$isStored) && (array_key_exists($name, $this->themeConfigMin))):
      unset($this->themeConfigMin[$name]);
    endif;
    if ((!$isFound) && (array_key_exists($name, $this->themeConfig))):
      unset($this->themeConfig[$name]);
    endif;    
   
  }

  public function saveSettingsFromPost(){
    $theme_default_settings = $this->getDefaults();

    if ((isset($_POST["p_reset"])) && ($_POST["p_reset"] == "on")):
      // Reset theme settings
      $config = array();
      conf_update_param('greydragon', pwg_db_real_escape_string(serialize($config)));
      load_conf_from_db();
      $this->loadConfig();
    else:
      foreach ($theme_default_settings as $key => $value):
        $this->saveSettingFromPOST($key);
      endforeach;
    endif;
  }

  public function hasSettingFromPost($name) {
    return (isset($_POST[$name]));
  }  

  public function getSettingFromPost($name) {
    if (isset($_POST[$name])):
      return $_POST[$name];
    else:
      return FALSE;
    endif;
  }

  public function hasOption($name, $isGlobal = FALSE) {
    global $conf;

    if ($isGlobal):
      return (array_key_exists($name, $conf) && isset($conf[$name]) && ($conf[$name]));
    else:
      return (array_key_exists($name, $this->themeConfig));
    endif;
  }

  public function deleteOption($name, $isGlobal = FALSE) {
    global $conf;

    if ($isGlobal):
      if (array_key_exists($name, $conf) && isset($conf[$name])):
        unset($conf[$name]);
      endif;
    else:
      if (array_key_exists($name, $this->themeConfig)):
        unset($this->themeConfig[$name]);
      endif;
    endif;
  }

  public function getOption($name, $isGlobal = FALSE) {
    global $conf;

    if ($isGlobal):
      if (array_key_exists($name, $conf)):
        return $conf[$name];
      else:
        return FALSE;
      endif;
    else:
      if (array_key_exists($name, $this->themeConfig)):
        return $this->themeConfig[$name];
      else:
        return FALSE;
      endif;
    endif;
  }

  public function hasCustomFavicon() {
    return ($this->hasOption("p_logo_path"));
  }

  public function update($old_version, $new_version) {
    $this->prepareCustomCSS();
  }

  public function uninstall() {
    // delete configuration
    $this->deleteCustomCSS();

    conf_delete_param('greydragon');
  }

  public function prepareHomePage($prefix, $pageId) {

    $r_desc    = $this->getOption('p_rootpage_desc');
    $r_link    = $this->getOption('p_rootpage_link');
    $r_scr     = $this->getOption('p_rootpage_src');
    $r_size    = $this->getOption('p_rootpage_size');
    $r_mode    = $this->getOption('p_rootpage_mode');
    $r_id      = $this->getOption('p_rootpage_id');
    $r_delay   = $this->getOption('p_rootpage_delay');
    $r_elastic = ($this->getOption('p_rootpage_elastic') == "on")? 'true' : 'false';
    $r_navarr  = ($this->getOption('p_rootpage_navarr') == "on")? 'true' : 'false';
    $r_navctr  = ($this->getOption('p_rootpage_navctr') == "on")? 'true' : 'false';

    $content = '<!-- GD Auto generated. Do not modify -->
<style type="text/css">
  .titrePage { display: none; }
  .content { max-width: 95%; margin: 1em 0 1em 4% !important; }
</style>
<div id="gdHomeContent">';
    if ($r_desc):
      $content .= '
  <div class="gdHomeQuote">' . l10n($r_desc) . '</div>';
    endif;
    if ($r_link):
      $content .= '
  <div class="gdHomeEnter"><a href="index.php?/categories">' . l10n('Click to Enter') . '</a></div>';
    endif;
    $content .= '
  <div class="gdHomePagePhoto">
    <a href="index.php?/categories">
      <div style="width: 800px; min-height: 500px; display: inline-block; overflow: hidden;">
';

      if ($r_scr == "photo"):
        $content .= '[photo id=' . $r_id . ' size=' . $r_size . ' html=yes link=no]';
      elseif ($r_scr == "random"):
        $content .= '[random album=' . $r_id . ' size=' . $r_size . ' html=yes link=no]';
      else:
        $content .= '[slider album=' . $r_id . ' nb_images=10 random=yes size=' . $r_size . ' speed=' . $r_delay . ' title=no effect=' . $r_mode . ' arrows=' . $r_navarr . ' control=' . $r_navctr . ' elastic=' . $r_elastic . ']';
      endif;
      $content .= '      
      </div>
    </a>
  </div>
</div>';

    $query = 'UPDATE ' . $prefix . 'additionalpages '
           . 'SET content = "' . pwg_db_real_escape_string($content) . '" '
           . ' , standalone = FALSE '
           . 'WHERE (id = ' . $pageId . ') AND (content <> "' . pwg_db_real_escape_string($content) . '");';
    pwg_query($query);
    return (pwg_db_changes() > 0);
  }

  public function getURLRoot() {
    $root_base = get_root_url();
    if ($root_base):
    else:
      $root_base = '/';
    endif;
    return $root_base;
  }

  public function getHeader() {
    global $conf;

    $content = "";
    $root_base = $this->getURLRoot();

    if ($this->hasOption('p_logo_path')):
      $content .= '<a title="Home" id="g-logo" href="' . get_gallery_home_url() . '"><img alt="Home" src="' . $root_base . $this->getOption('p_logo_path') . '"></a>';
    endif;
    if ($this->hasOption('p_header')):
      $p_header = $this->getOption('p_header');
    elseif ($this->hasOption('page_banner', TRUE)):
      $p_header = $this->getOption('page_banner', TRUE);
    else:
      $p_header = "";
    endif;
    $p_header = trim(str_replace('%gallery_title%', $conf['gallery_title'], $p_header));
    if (strlen($p_header) > 0):
      $content .= '<a title="Home" id="g-header-text" href="' . get_gallery_home_url() . '">' . $p_header . '</a>';
    endif;

    return $content;
  }

  public function prepareCustomCSS() {

    $this->cssfile = dirname(dirname(dirname(dirname(__FILE__)))) . '/' . PWG_LOCAL_DIR . 'greydragon/custom.css';

    if ($this->getOption('p_lowertext') == "on"):
      $css  = "/* Theme dynamic settings. Do not modify */\n"
            . "html, body, input, select, textarea, file { text-transform: lowercase; }\n\n";
    else:
      $css = "";
    endif;
    $temp = $this->getOption('p_customcss');
    if ($temp):
      $css .= "/* Custom CSS. Do not modify */\n" . $temp;
    endif;

    // create a local directory
    if (!file_exists($this->dir)):
      mkdir($this->dir, 0755);
    endif;

    if ($css):
      $handle = fopen($this->cssfile, "w");
      if ($handle):
        fwrite($handle, $css);
        fclose($handle);
      endif;
    else:
      @unlink($this->cssfile);
    endif;
  }

  public function deleteCustomCSS() {

    // delete local folder
    foreach (scandir($this->dir) as $file):
      if ($file == '.' or $file == '..') continue;
      unlink($this->dir . $file);
    endforeach;
    rmdir($this->dir);
  }

  public function getColorPackList() {
    $themeroot = './themes/' . basename(dirname(dirname(__FILE__))) . '/';

    $packlist = array();
    $packroot = $themeroot . 'css/colorpack/';
    foreach (scandir($packroot) as $pack_name):
      if (file_exists($packroot . "$pack_name/styles.css")):
        if ($pack_name[0] == "."):
          continue;
        endif;
        $packlist[] = $pack_name;
      endif;
    endforeach;
    return $packlist;
  }

  public function getPageTabs() {
    // metadata array
    // each tab represented by respected sub array
    // sub array need to include 
    //   "id"         = unique id of the tab
    //   "icon_class" = class to be used to render icon tabs
    //   "title"      = tab or menu block title
    //   "content"    = block content
    //   "target"     = optional, rendering target - "left", "top", "right", "bottom", not supported, reserved for future use
    //   "combine"    = combine_css or combine_js reference block
    //
    // prior to rendering, each element would be processed and converted into tab content in picture.tpl

    $metadata = array();
    $metadata = trigger_change('gd_get_metadata', $metadata);

    $meta_icon = "";
    $meta_text = "";
    $meta_content = "";

    foreach ($metadata as $item):

      $id            = $item["id"];
      $icon_class    = $item["icon_class"];
      $title         = $item["title"];
      $block_content = $item["content"];
      $combine       = $item["combine"];
      $no_overlay    = $item["no_overlay"];

      if ($no_overlay):
        $meta_icon .= '<li class="ico-btn btn-' . $id . '">' . $block_content . '</li>';
      else:
        $meta_icon .= '<li class="meta-' . $id . '{if $ico_mode=="on"} ' . $icon_class . '{/if}{if $def_tab == "' . $id . '"} active{/if}"{if $ico_mode=="on"} title="{"' . $title . '"|@translate}"{/if}>{if $ico_mode=="off"}' . $title . '{/if}</li>';
      endif;

      $meta_text .= '<li class="{if $ico_mode=="on"}' . $icon_class . '{/if}{if $def_tab == "' . $id . '"} active{/if}" rel="tab-' . $id . '"{if $ico_mode=="on"} title="{"' . $title . '"|@translate}"{/if}>{if $ico_mode=="off"}' . $title . '{/if}</li>';
      if (isset($combine)):
        $meta_content .= '{strip}' . $combine . '{strip}';
      else:
        $meta_content .= '<div id="tab-' . $id . '" class="image-metadata-tab">' . $block_content . '</div>';
      endif;
    endforeach;

    return array("icon" => $meta_icon, "text" => $meta_text, "content" => $meta_content);
  }
}

?>
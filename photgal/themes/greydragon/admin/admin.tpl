{combine_css path="themes/default/js/ui/theme/jquery.ui.button.css"}
{combine_css path="themes/default/js/plugins/colorbox/style2/colorbox.css"}
{combine_css path="themes/greydragon/css/all.min.css"}
{combine_css path="themes/greydragon/admin/css/styles.css"}
{combine_script id='jquery.colorbox' load='footer' require='jquery' path='themes/default/js/plugins/jquery.colorbox.min.js' }
{combine_script id='greydragon.admin' load='footer' require='jquery,jquery.ui.button,jquery.colorbox' path='themes/greydragon/admin/js/admin.js' }
{if $options.p_debug == "on"}
{debug}
{/if}

<div class="titrePage">
  <h2>{'GreyDragon Theme'|@translate} - {$options.version}</h2>
  <div class="left-links">
    <ul><li><a href="http://blog.dragonsoft.us/piwigo/" target="_blank">{'Blog'|@translate}</a>&nbsp;|&nbsp;</li>
      <li><a class="ajax cboxElement" href="themes/greydragon/changelog.php?version={$options.version}" >{'Changelog'|@translate}</a>&nbsp;|&nbsp;</li>
      <li><a href="http://piwigo.org/forum/viewtopic.php?pid=154192" target="_blank">{'Support'|@translate}</a>&nbsp;|&nbsp;</li>
      <li><a title="Follow me on Twitter" href="http://twitter.com/greydragon_th" target="_blank">{'Follow'|@translate}</a>&nbsp;|&nbsp;</li>
      <li><a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=GYVNZCNDMSD58" target="_blank">{'Coffee Fund'|@translate}</a>&nbsp;|&nbsp;</li>
      <li><a href="http://piwigo.org/ext/extension_view.php?eid=775" target="_blank">{'Download'|@translate}</a></li>
    </ul>
  </div>
</div>
<form method="post" class="properties" action="" ENCTYPE="multipart/form-data" name="form" class="properties">
<div id="configContent">
  <fieldset>
    <legend>{'Prerequisites'|@translate}</legend>
    <ul>
      <li>
        <label>
          <i class="gd-checkbox fas {if $options.hasMinVer=="yes"}fa-check-square success{else}fa-ban error{/if}"></i>&nbsp;
          <input name="vercheck" disabled="1" type="checkbox" checked="checked" value="1">{$pwg->sprintf({'Piwigo %s Core Installed (min required 2.7.0+)'|@translate}, {$options.pwgVer})}
        </label>
      </li>
      <li>
        <label>
          <i class="gd-checkbox fas {if $options.hasAP=="yes"}fa-check-square success{else}fa-ban error{/if}"></i>&nbsp;
          <input name="addpagescheck" disabled="1" type="checkbox" checked="checked" value="1">{'Additional Pages'|@translate} {'Installed'|@translate}
        </label>
      </li>
      <li>
        <label>
          <i class="gd-checkbox fas {if $options.hasED=="yes"}fa-check-square success{else}fa-ban error{/if}"></i>&nbsp;
          <input name="extdesccheck" disabled="1" type="checkbox" checked="checked" value="1">{'Extended Description'|@translate} {'Installed'|@translate}
        </label>
      </li>
    </ul>
  </fieldset>
  <fieldset>
    <legend>{'Suggested Modules'|@translate}</legend>
    <ul>
      <li>
        <label>
          <i class="gd-checkbox fas {if $options.hasGT=="yes"}fa-check-square success{else}fa-square error{/if}"></i>&nbsp;
          <input name="vercheck" disabled="1" type="checkbox" checked="checked" value="1"><a href="http://piwigo.org/ext/extension_view.php?eid=771" target=_blank>{'gdThumb'|@translate}</a> {'Installed'|@translate}
        </label>
      </li>
      <li>
        <label>
          <i class="gd-checkbox fas {if $options.hasAT=="yes"}fa-check-square success{else}fa-square error{/if}"></i>&nbsp;
          <input name="vercheck" disabled="1" type="checkbox" checked="checked" value="1"><a href="http://piwigo.org/ext/extension_view.php?eid=720" target=_blank>{'Admin Tools'|@translate}</a> {'Installed'|@translate}
        </label>
      </li>
    </ul>
  </fieldset>
  <fieldset>
    <legend>{'General Settings'|@translate}</legend>
    <ul>
      <li><input id="p_logo_path" name="p_logo_path" type="text" value="{$options.p_logo_path}"><label for="p_logo_path">{'Logo Image'|@translate}</label>
      <li><input id="p_header" name="p_header" type="text" value="{$options.p_header|escape:"html"}"><label for="p_header">{'Header Text'|@translate}</label>
      <li><input id="p_footer" name="p_footer" type="text" value="{$options.p_footer|escape:"html"}"><label for="p_footer">{'Footer Text'|@translate}</label>
      <li>
        <select id="p_colorpack" name="p_colorpack" adisabled="1">
        {foreach from=$colorpackArr item=name}<option {if $options.p_colorpack == $name}selected="selected"{/if} value="{$name}">{$name}</option>{/foreach}
        </select>
        <label for="p_colorpack">{'Color Pack'|@translate}</label>
      </li>
    </ul>      
  </fieldset>
  <fieldset>
    <legend>{'General Settings - All In One Favicon'|@translate}</legend>
    <ul>
      <li><input id="p_favicon_ico" name="p_favicon_ico" type="text" value="{$options.p_favicon_ico}"><label for="p_favicon_ico">{'URL to your favicon.ico'|@translate}</label>
      <li><input id="p_favicon_apple" name="p_favicon_apple" type="text" value="{$options.p_favicon_apple}"><label for="p_favicon_apple">{'URL to your Apple Touch icon (60x60)'|@translate}</label> 
      <li><label><i class="gd-checkbox fas {if $options.p_favicon_noshine=="on"}fa-check-square{else}fa-square{/if}"></i>&nbsp;<input name="p_favicon_noshine" id="p_favicon_noshine" type="checkbox" value="on" {if $options.p_favicon_noshine=="on"}checked="checked"{/if}>{'Do not add reflective shine to Apple Touch Icon'|@translate}</label></li>
    </ul>      
  </fieldset>
  <fieldset>
    <legend>{'Advanced Options - General'|@translate}</legend>
    <ul>
      <li>
        <select id="p_main_menu" name="p_main_menu">
          <option {if $options.p_main_menu=="static"}selected="selected"{/if} value="static">{'Static Menu'|@translate}</option>
          <option {if $options.p_main_menu=="header-bottom"}selected="selected"{/if} value="header-bottom">{'Static Menu - Header Bottom'|@translate}</option>
          <option {if $options.p_main_menu=="header-right"}selected="selected"{/if} value="header-right">{'Static Menu - Header Right'|@translate}</option>
          <option {if $options.p_main_menu=="opened"}selected="selected"{/if} value="opened">{'Popup Menu Opened'|@translate}</option>
          <option {if $options.p_main_menu=="closed"}selected="selected"{/if} value="closed">{'Popup Menu Closed'|@translate}</option>
{* 
          <option {if $options.p_main_menu=="top-bar"}selected="selected"{/if} value="top-bar">{'Static Menu - Top Bar'|@translate}</option>
          <option {if $options.p_main_menu=="header-top"}selected="selected"{/if} value="header-bottomleft">{'Header Top Left'|@translate}</option> 
*}
          <option {if $options.p_main_menu=="disabled"}selected="selected"{/if} value="disabled">{'Disabled'|@translate}</option>
        </select>
        <label for="p_main_menu">{'Main Menu Mode'|@translate}</label>
      </li>
      <li><label><i class="gd-checkbox fas {if $options.p_animated_menu=="on"}fa-check-square{else}fa-square{/if}"></i>&nbsp;<input name="p_animated_menu" id="p_animated_menu" type="checkbox" value="on" {if $options.p_animated_menu=="on"}checked="checked"{/if}>{'Animate Menu'|@translate}</label></li>
      <li><label><i class="gd-checkbox fas {if $options.p_main_menu_close=="on"}fa-check-square{else}fa-square{/if}"></i>&nbsp;<input name="p_main_menu_close" id="p_main_menu_close" type="checkbox" value="on" {if $options.p_main_menu_close=="on"}checked="checked"{/if}>{'Auto Close Popup Menu'|@translate}</label></li>
      <li>
        <select id="p_credits" name="p_credits">
          <option {if $options.p_credits=="on"}selected="selected"{/if} value="on">{'Show Credits (Icon)'|@translate}</option>
          <option {if $options.p_credits=="text"}selected="selected"{/if} value="text">{'Show Credits (Text)'|@translate}</option>
          <option {if $options.p_credits=="off"}selected="selected"{/if} value="off">{'Hide'|@translate}</option>
        </select>
        <label for="p_credits">{'Show Site Credits'|@translate}</label>
      </li>
      <li><label><i class="gd-checkbox fas {if $options.p_nogenerator=="on"}fa-check-square{else}fa-square{/if}"></i>&nbsp;<input name="p_nogenerator" id="p_nogenerator" type="checkbox" value="on" {if $options.p_nogenerator=="on"}checked="checked"{/if}>{'Remove Piwigo Generator Meta Tag'|@translate}</label></li>
      <li><label><i class="gd-checkbox fas {if $options.p_lowertext=="on"}fa-check-square{else}fa-square{/if}"></i>&nbsp;<input name="p_lowertext" id="p_lowertext" type="checkbox" value="on" {if $options.p_lowertext=="on"}checked="checked"{/if}>{'Use Lowercase Text'|@translate}</label></li>
      <li><label><i class="gd-checkbox fas {if $options.p_hideabout=="on"}fa-check-square{else}fa-square{/if}"></i>&nbsp;<input name="p_hideabout" id="p_hideabout" type="checkbox" value="on" {if $options.p_hideabout=="on"}checked="checked"{/if}>{'Hide About Link'|@translate}</label></li>
      <li><label><i class="gd-checkbox fas {if $options.p_adminemail=="on"}fa-check-square{else}fa-square{/if}"></i>&nbsp;<input name="p_adminemail" id="p_adminemail" type="checkbox" value="on" {if $options.p_adminemail=="on"}checked="checked"{/if}>{'Include Contact Webmaster Email in the Footer for Members'|@translate}</label></li>
      <li><label><i class="gd-checkbox fas {if $options.p_nocounter=="on"}fa-check-square{else}fa-square{/if}"></i>&nbsp;<input name="p_nocounter" id="p_nocounter" type="checkbox" value="on" {if $options.p_nocounter=="on"}checked="checked"{/if}>{'Remove photo counter in breadcrumbs and categories menu'|@translate}</label></li>
    </ul>
  </fieldset>
  <fieldset>
    <legend>{'Advanced Options - Photo Page'|@translate}</legend>
    <ul>
      <li>
        <select id="p_pict_tab_mode" name="p_pict_tab_mode">
          <option {if $options.p_pict_tab_mode=="txt-tab-open"}selected="selected"{/if} value="txt-tab-open">{'Text Tabs Expanded'|@translate}</option>
          <option {if $options.p_pict_tab_mode=="txt-tab-close"}selected="selected"{/if} value="txt-tab-close">{'Text Tabs Collapsed'|@translate}</option>
          <option {if $options.p_pict_tab_mode=="ico-tab-open"}selected="selected"{/if} value="ico-tab-open">{'Icon Tabs Expanded'|@translate}</option>
          <option {if $options.p_pict_tab_mode=="ico-tab-close"}selected="selected"{/if} value="ico-tab-close">{'Icon Tabs Collapsed'|@translate}</option>
          <option {if $options.p_pict_tab_mode=="txt-with-overlay"}selected="selected"{/if} value="txt-with-overlay">{'Text With Overlay'|@translate}</option>
          <option {if $options.p_pict_tab_mode=="ico-with-overlay"}selected="selected"{/if} value="ico-with-overlay">{'Icon With Overlay'|@translate}</option>
          <option {if $options.p_pict_tab_mode=="hide"}selected="selected"{/if} value="hide">{'Hide'|@translate}</option>
        </select>
        <label for="p_pict_tab_mode">{'Metadata Display Mode'|@translate}</label>
      </li>
      <li>
        <select id="p_pict_tab_default" name="p_pict_tab_default">
          <option {if $options.p_pict_tab_default=="desc"}selected="selected"{/if} value="desc">{'Description'|@translate}</option>
          <option {if $options.p_pict_tab_default=="info"}selected="selected"{/if} value="info">{'Info'|@translate}</option>
          <option {if $options.p_pict_tab_default=="exif"}selected="selected"{/if} value="exif">{'Exif'|@translate}</option>
          <option {if $options.p_pict_tab_default=="tags"}selected="selected"{/if} value="tags">{'Tags'|@translate}</option>
          <option {if $options.p_pict_tab_default=="comments"}selected="selected"{/if} value="comments">{'Comments'|@translate}</option>
        </select>
        <label for="p_pict_tab_default">{'Default Tab to be displayed in Tabbed Mode'|@translate}</label>
      </li>
      <li><label><i class="gd-checkbox fas {if $options.p_pict_tab_anim=="on"}fa-check-square{else}fa-square{/if}"></i>&nbsp;<input name="p_pict_tab_anim" id="p_pict_tab_anim" type="checkbox" value="on" {if $options.p_pict_tab_anim=="on"}checked="checked"{/if}>{'Animate Tabs'|@translate}</label></li>
      <li><label><i class="gd-checkbox fas {if $options.p_pict_tab_exif=="off"}fa-check-square{else}fa-square{/if}"></i>&nbsp;<input name="p_pict_tab_exif" id="p_pict_tab_exif" type="checkbox" value="off" {if $options.p_pict_tab_exif=="off"}checked="checked"{/if}>{'Hide EXIF Data'|@translate}</label></li>
    </ul>
  </fieldset>
  <fieldset>
    <legend>{'Advanced Options - Root Page'|@translate}</legend>
    <ul>
      <li><label><i class="gd-checkbox fas {if $options.p_rootpage=="on"}fa-check-square{else}fa-square{/if}"></i>&nbsp;<input name="p_rootpage" id="p_rootpage" type="checkbox" value="on" {if $options.p_rootpage=="on"}checked="checked"{/if}>{'Enable Root Page'|@translate}</label></li>
      <li>
        <label class="textarea" for="p_rootpage_desc"><span class="textarea">{'Gallery Description (with Safe Quotes)'|@translate}</span>&nbsp;</label>
        <textarea rows="4" cols="50" id="p_rootpage_desc" name="p_rootpage_desc">{$options.p_rootpage_desc|unescape:"html"}</textarea>
      </li>
      <li>
        <select id="p_rootpage_src" name="p_rootpage_src">
          <option value="photo" {if $options.p_rootpage_src=="photo"}selected="selected"{/if}>{'Static Photo'|@translate}</option>
          <option value="random" {if $options.p_rootpage_src=="random"}selected="selected"{/if}>{'Static Random Photo'|@translate}</option>
          <option value="slider" {if $options.p_rootpage_src=="slider"}selected="selected"{/if}>{'Slideshow'|@translate}</option>
        </select>
        <label for="p_rootpage_src">{'Image Source (Default: Slideshow)'|@translate}</label>
      </li>
      <li>
        <select id="p_rootpage_size" name="p_rootpage_size">
          <option value="M" {if $options.p_rootpage_size=="M"}selected="selected"{/if}>{'Medium'|@translate}</option>
          <option value="S" {if $options.p_rootpage_size=="S"}selected="selected"{/if}>{'Small'|@translate}</option>
        </select>
        <label for="p_rootpage_size">{'Image Size (Default: Medium)'|@translate}</label>
      </li>
      <li><input id="p_rootpage_id" name="p_rootpage_id" type="text" value="{$options.p_rootpage_id}"><label for="p_rootpage_id">{'Photo/Album Index'|@translate}</label>
      <li>
        <select id="p_rootpage_mode" name="p_rootpage_mode">
          <option value="sliceDown" {if $options.p_rootpage_mode=="sliceDown"}selected="selected"{/if}>{'Slice Down'|@translate}</option>
          <option value="sliceDownLeft" {if $options.p_rootpage_mode=="sliceDownLeft"}selected="selected"{/if}>{'Slice Down Left'|@translate}</option>
          <option value="sliceUp" {if $options.p_rootpage_mode=="sliceUp"}selected="selected"{/if}>{'Slice Up'|@translate}</option>
          <option value="sliceUpLeft" {if $options.p_rootpage_mode=="sliceUpLeft"}selected="selected"{/if}>{'Slice Up Left'|@translate}</option>
          <option value="sliceUpDown" {if $options.p_rootpage_mode=="sliceUpDown"}selected="selected"{/if}>{'Slice Up Down'|@translate}</option>
          <option value="sliceUpDownLeft" {if $options.p_rootpage_mode=="sliceUpDownLeft"}selected="selected"{/if}>{'Slice Up Down Left'|@translate}</option>
          <option value="fold" {if $options.p_rootpage_mode=="fold"}selected="selected"{/if}>{'Fold'|@translate}</option>
          <option value="fade" {if $options.p_rootpage_mode=="fade"}selected="selected"{/if}>{'Fade (Default)'|@translate}</option>
          <option value="random" {if $options.p_rootpage_mode=="random"}selected="selected"{/if}>{'Random'|@translate}</option>
          <option value="slideInRight" {if $options.p_rootpage_mode=="slideInRight"}selected="selected"{/if}>{'Slide In Right'|@translate}</option>
          <option value="slideInLeft" {if $options.p_rootpage_mode=="slideInLeft"}selected="selected"{/if}>{'Slide In Left'|@translate}</option>
          <option value="boxRandom" {if $options.p_rootpage_mode=="boxRandom"}selected="selected"{/if}>{'Box Random'|@translate}</option>
          <option value="boxRain" {if $options.p_rootpage_mode=="boxRain"}selected="selected"{/if}>{'Box Rain'|@translate}</option>
          <option value="boxRainReverse" {if $options.p_rootpage_mode=="boxRainReverse"}selected="selected"{/if}>{'Box Rain Reverse'|@translate}</option>
          <option value="boxRainGrow" {if $options.p_rootpage_mode=="boxRainGrow"}selected="selected"{/if}>{'Box Rain Grow'|@translate}</option>
          <option value="boxRainGrowReverse" {if $options.p_rootpage_mode=="boxRainGrowReverse"}selected="selected"{/if}>{'Box Rain Grow Reverse'|@translate}</option>
        </select>
        <label for="p_rootpage_mode">{'Cycle Effect In Slideshow (Default: Fade)'|@translate}</label>
      </li>
      <li><input id="p_rootpage_delay" name="p_rootpage_delay" type="text" value="{$options.p_rootpage_delay}"><label for="p_rootpage_delay">{'Delay In Slideshow (Default: 10)'|@translate}</label>
      <li><label><i class="gd-checkbox fas {if $options.p_rootpage_elastic == "on"}fa-check-square{else}fa-square{/if}"></i>&nbsp;<input name="p_rootpage_elastic" id="p_rootpage_elastic" type="checkbox" value="on" {if $options.p_rootpage_elastic == "on"}checked="checked"{/if}>{'Adapt slideshow size to each photo'|@translate}</label></li>
      <li><label><i class="gd-checkbox fas {if $options.p_rootpage_navarr == "on"}fa-check-square{else}fa-square{/if}"></i>&nbsp;<input name="p_rootpage_navarr" id="p_rootpage_navarr" type="checkbox" value="on" {if $options.p_rootpage_navarr == "on"}checked="checked"{/if}>{'Display navigation arrows'|@translate}</label></li>
      <li><label><i class="gd-checkbox fas {if $options.p_rootpage_navctr == "on"}fa-check-square{else}fa-square{/if}"></i>&nbsp;<input name="p_rootpage_navctr" id="p_rootpage_navctr" type="checkbox" value="on" {if $options.p_rootpage_navctr == "on"}checked="checked"{/if}>{'Display navigation controls'|@translate}</label></li>
      <li><label><i class="gd-checkbox fas {if $options.p_rootpage_link == "on"}fa-check-square{else}fa-square{/if}"></i>&nbsp;<input name="p_rootpage_link" id="p_rootpage_link" type="checkbox" value="on" {if $options.p_rootpage_link == "on"}checked="checked"{/if}>{'Include "Click to Enter" link'|@translate}</label></li>
    </ul>
  </fieldset>
  <fieldset>
    <legend>{'Advanced Options - Custom CSS'|@translate}</legend>
    <ul><li>
      <label class="textarea" for="p_customcss"><span class="textarea">{'Custom CSS'|@translate}</span></label>
      <textarea rows="4" cols="50" id="p_customcss" name="p_customcss">{$options.p_customcss|escape:"html"}</textarea>
    </li></ul>
  </fieldset>
  <fieldset>
    <legend>{'Advanced Options - Maintenance'|@translate}</legend>
    <ul>
      <li><label><i class="gd-checkbox fas {if $options.p_debug=="on"}fa-check-square{else}fa-square{/if}"></i>&nbsp;<input name="p_debug" id="p_debug" type="checkbox" value="on" {if $options.p_debug=="on"}checked="checked"{/if}>{'Enable Debug Mode'|@translate}</label></li>
      <li><label><i class="gd-checkbox fas fa-square"></i>&nbsp;<input name="p_reset" id="p_debug" type="checkbox" value="on">{'Reset Theme to a Default State'|@translate}</label></li>
    </ul>
  </fieldset>
  <input class="submit" type="submit" value="{'Save Changes'|@translate}" name="submit_greydragon" />
</div>
<div id="helpContent">
{include file='./help.inc.tpl'}
</div>



</form>
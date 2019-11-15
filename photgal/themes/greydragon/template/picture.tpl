{include file='include/colorbox.inc.tpl'}
{combine_script id='core.switchbox' load='async' require='jquery' path='themes/default/js/switchbox.js'}
{combine_script id='picture-js' load='async' require='jquery,jquery.colorbox' path='themes/greydragon/js/theme.photo.js'}
{assign var=overlay_mode value="off"}
{if $greydragon.p_pict_tab_mode == "txt-with-overlay" || $greydragon.p_pict_tab_mode == "ico-with-overlay"}{$overlay_mode="on"}{/if}
{assign var=ico_mode value="off"}
{if $greydragon.p_pict_tab_mode == "ico-tab-open" || $greydragon.p_pict_tab_mode == "ico-tab-close" || $greydragon.p_pict_tab_mode == "ico-with-overlay"}{$ico_mode="on"}{/if}
                                                                                           
{if isset($MENUBAR)}{$MENUBAR}{/if}

<div id="content"{if isset($MENUBAR)} class="contentWithMenu"{/if}>
{if isset($errors) or not empty($infos)}
{include file='infos_errors.tpl'}
{/if}

{if !empty($PLUGIN_PICTURE_BEFORE)}{$PLUGIN_PICTURE_BEFORE}{/if}

<div id="imageHeaderBar">
  <div class="browsePath">
    {$SECTION_TITLE}<span class="browsePathSeparator">{$LEVEL_SEPARATOR}</span><h2>{$current.TITLE}</h2>
  </div>
</div>

<div id="imageToolBar">
<div class="imageNumber">{$PHOTO}</div>
{include file='picture_nav_buttons.tpl'|@get_extent:'picture_nav_buttons'}

<div class="actionButtons">
{if isset($current.unique_derivatives) && count($current.unique_derivatives)>1}
{footer_script require='jquery'}{literal}
function changeImgSrc(url,typeSave,typeMap) {
  var theImg = document.getElementById("theMainImage");
  if (theImg)
  {
    theImg.removeAttribute("width");theImg.removeAttribute("height");
    theImg.src = url;
    theImg.useMap = "#map"+typeMap;
  }
  jQuery('#derivativeSwitchBox .switchCheck').css('visibility','hidden');
  jQuery('#derivativeChecked'+typeMap).css('visibility','visible');
  document.cookie = 'picture_deriv='+typeSave+';path={/literal}{$COOKIE_PATH}{literal}';
}
(SwitchBox=window.SwitchBox||[]).push("#derivativeSwitchLink", "#derivativeSwitchBox");
{/literal}{/footer_script}

{strip}<a id="derivativeSwitchLink" title="{'Photo sizes'|@translate}" class="pwg-state-default pwg-button" rel="nofollow">
  <span class="pwg-icon pwg-icon-sizes"></span><span class="pwg-button-text">{'Photo sizes'|@translate}</span>
</a>
<div id="derivativeSwitchBox" class="switchBox">
  <div class="switchBoxTitle">{'Photo sizes'|@translate}</div>
  {foreach from=$current.unique_derivatives item=derivative key=derivative_type}
  <span class="switchCheck" id="derivativeChecked{$derivative->get_type()}"{if $derivative->get_type() ne $current.selected_derivative->get_type()} style="visibility:hidden"{/if}>&#x2714; </span>
  <a href="javascript:changeImgSrc('{$derivative->get_url()|@escape:javascript}','{$derivative_type}','{$derivative->get_type()}')">
    {$derivative->get_type()|@translate}<span class="derivativeSizeDetails"> ({$derivative->get_size_hr()})</span>
  </a><br>
  {/foreach}
  {if isset($U_ORIGINAL)}
    {combine_script id='core.scripts' load='async' path='themes/default/js/scripts.js'}
  <a href="javascript:phpWGOpenWindow('{$U_ORIGINAL}','xxx','scrollbars=yes,toolbar=no,status=no,resizable=yes')" rel="nofollow">{'Original'|@translate}</a>
  {/if}
</div>
{/strip}
{/if}
{strip}{if isset($U_SLIDESHOW_START)}
  <a href="{$U_SLIDESHOW_START}" title="{'slideshow'|@translate}" class="pwg-state-default pwg-button" rel="nofollow">
    <span class="pwg-icon pwg-icon-slideshow"></span><span class="pwg-button-text">{'slideshow'|@translate}</span>
  </a>
{/if}{/strip}
{strip}{if isset($current.U_DOWNLOAD)}
  <a id="downloadSwitchLink" href="{$current.U_DOWNLOAD}" title="{'Download this file'|@translate}" class="pwg-state-default pwg-button" rel="nofollow">
    <span class="pwg-icon pwg-icon-save"></span><span class="pwg-button-text">{'Download'|@translate}</span>
  </a>
{/if}{/strip}
{if isset($PLUGIN_PICTURE_BUTTONS)}{foreach from=$PLUGIN_PICTURE_BUTTONS item=button}{$button}{/foreach}{/if}
{if isset($PLUGIN_PICTURE_ACTIONS)}{$PLUGIN_PICTURE_ACTIONS}{/if}
{strip}{if isset($favorite)}
  <a href="{$favorite.U_FAVORITE}" title="{if $favorite.IS_FAVORITE}{'delete this photo from your favorites'|@translate}{else}{'add this photo to your favorites'|@translate}{/if}" class="pwg-state-default pwg-button" rel="nofollow">
    <span class="pwg-icon pwg-icon-favorite-{if $favorite.IS_FAVORITE}del{else}add{/if}"></span><span class="pwg-button-text">{'Favorites'|@translate}</span>
  </a>
{/if}{/strip}
{strip}{if isset($U_SET_AS_REPRESENTATIVE)}
  <a id="cmdSetRepresentative" href="{$U_SET_AS_REPRESENTATIVE}" title="{'set as album representative'|@translate}" class="pwg-state-default pwg-button" rel="nofollow">
    <span class="pwg-icon pwg-icon-representative"></span><span class="pwg-button-text">{'representative'|@translate}</span>
  </a>
{/if}{/strip}
{strip}{if isset($U_PHOTO_ADMIN)}
  <a id="cmdEditPhoto" href="{$U_PHOTO_ADMIN}" title="{'Modify information'|@translate}" class="pwg-state-default pwg-button" rel="nofollow">
    <span class="pwg-icon pwg-icon-edit"></span><span class="pwg-button-text">{'Edit'|@translate}</span>
  </a>
{/if}{/strip}
{strip}{if isset($U_CADDIE)}{*caddie management BEGIN*}
{footer_script}
{literal}function addToCadie(aElement, rootUrl, id) {
  if (aElement.disabled) return;
  aElement.disabled=true;
  var y = new PwgWS(rootUrl);
  y.callService("pwg.caddie.add", {image_id: id}, { onFailure: function(num, text) { alert(num + " " + text); document.location=aElement.href; }, onSuccess: function(result) { aElement.disabled = false; }});
}{/literal}
{/footer_script}
  <a href="{$U_CADDIE}" onclick="addToCadie(this, '{$ROOT_URL}', {$current.id}); return false;" title="{'Add to caddie'|@translate}" class="pwg-state-default pwg-button" rel="nofollow">
    <span class="pwg-icon pwg-icon-caddie-add"> </span><span class="pwg-button-text">{'Caddie'|@translate}</span>
  </a>
{/if}{/strip}{*caddie management END*}
</div>
</div>{*<!-- imageToolBar -->*}

<div id="theImageAndInfos"{if $DISPLAY_NAV_THUMB} class="nav-thumb-margin"{/if}>
<div id="theImage">
{$ELEMENT_CONTENT}

{if isset($U_SLIDESHOW_STOP)}
<p>
  [ <a href="{$U_SLIDESHOW_STOP}">{'stop the slideshow'|@translate}</a> ]
</p>
{/if}

{if $DISPLAY_NAV_THUMB}
<div id="imageInfos">
  <div class="navThumbs">
    {if isset($previous)}
      <a class="navThumb" id="linkPrev" href="{$previous.U_IMG}" title="{'Previous'|@translate} : {$previous.TITLE_ESC}" rel="prev">
        <span class="thumbHover prevThumbHover"></span>
        <img src="{$previous.derivatives.square->get_url()}" alt="{$previous.TITLE_ESC}">
      </a>
    {elseif isset($U_UP)}
      <a class="navThumb" id="linkPrev" href="{$U_UP}" title="{'Thumbnails'|@translate}">
        <div class="thumbHover">{'First Page'|@translate}<br><br>{'Go back to the album'|@translate}</div>
      </a>
    {/if}
    {if isset($next)}
      <a class="navThumb" id="linkNext" href="{$next.U_IMG}" title="{'Next'|@translate} : {$next.TITLE_ESC}" rel="next">
        <span class="thumbHover nextThumbHover"></span>
        <img src="{$next.derivatives.square->get_url()}" alt="{$next.TITLE_ESC}">
      </a>
    {elseif isset($U_UP)}
      <a class="navThumb" id="linkNext"  href="{$U_UP}"  title="{'Thumbnails'|@translate}">
        <div class="thumbHover">{'Last Page'|@translate}<br><br>{'Go back to the album'|@translate}</div>
      </a>
    {/if}
  </div>
</div>
{/if}

</div>

{if $greydragon.p_pict_tab_mode !== "hide" && $overlay_mode == "on"}
<div id="image-metadata-ico">
  <ul class="image-metadata-ico"> 
    {include file='picture_tab_ico.tpl'}
    {*GD_META_ICO*}
  </ul>
</div>
{/if}

</div>

{assign var=def_tab value="{$greydragon.p_pict_tab_default}"}
{if !isset($metadata) && $def_tab == 'exif'}{$def_tab="desc"}{/if}
{if !isset($COMMENT_COUNT) && $def_tab == 'comments'}{$def_tab="desc"}{/if}
{if !isset( $COMMENT_IMG ) && $def_tab == 'desc'}{$def_tab="info"}{/if}
{if $greydragon.p_pict_tab_mode !== "hide" && $overlay_mode == "off"}
<ul class="image-metadata"> 
  {include file='picture_tab_txt.tpl'}
  {*GD_META_TXT*}
  <li id="image-metadata-toggle" class="fas {if $greydragon.p_pict_tab_mode == "txt-tab-close" || $greydragon.p_pict_tab_mode == "ico-tab-close"}fa-chevron-down{else}fa-chevron-up{/if}" ></li>
</ul>
{/if}
{if $greydragon.p_pict_tab_mode !== "hide"}
<div class="image-metadata-tabs{if $overlay_mode=="on"} overlay{/if}" {if $greydragon.p_pict_tab_mode == "txt-tab-close" || $greydragon.p_pict_tab_mode == "ico-tab-close" || $overlay_mode=="on"}style="display: none;"{/if}> 
  {include file='picture_tab_content.tpl'}
  {*GD_META_CONTENT*}
</div>
{/if}
</div>
{* if isset($greydragon.image_preload)}
<div id="image_urls" style="display:none;">
  {foreach from=$U_IMGNEXT item=u_img key=id}
    {if isset($u_img)}<div class="next{$id} preload">{$u_img}</div>{/if}
  {/foreach}
</div>
{ /if *}

{if !empty($PLUGIN_PICTURE_AFTER)}{$PLUGIN_PICTURE_AFTER}{/if}

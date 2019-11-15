  {if isset( $COMMENT_IMG )}<li class="{if $ico_mode=="on"}fas fa-eye{/if}{if $def_tab == "desc"} active{/if}" rel="tab-desc"{if $ico_mode=="on"} title="{"Description"|@translate}"{/if}>{if $ico_mode=="off"}{"Description"|@translate}{/if}</li>{/if}
  <li class="{if $ico_mode=="on"}fas fa-info-circle{/if}{if $def_tab == "info"} active{/if}" rel="tab-meta"{if $ico_mode=="on"} title="{"Info"|@translate}"{/if}>{if $ico_mode=="off"}{"Info"|@translate}{/if}</li>
  {if isset($metadata)}<li class="{if $ico_mode=="on"}fas fa-camera{/if}{if $def_tab == "exif"} active{/if}" rel="tab-exif"{if $ico_mode=="on"} title="{"Exif"|@translate}"{/if}>{if $ico_mode=="off"}{"Exif"|@translate}{/if}</li>{/if}
  {if ($display_info.tags && (isset($related_tags) || ($greydragon.hasUserTags)))}<li class="{if $ico_mode=="on"}fas fa-tags{/if}{if $def_tab == "tags"} active{/if}" rel="tab-tags"{if $ico_mode=="on"} title="{"Tags"|@translate}"{/if}>{if $ico_mode=="off"}{"Tags"|@translate}{/if}</li>{/if}
  {if isset($COMMENT_COUNT)}<li class="{if $ico_mode=="on"}fas fa-comment{/if}{if $def_tab == "comments"} active{/if}" rel="tab-comment"{if $ico_mode=="on"} title="{"Comments"|@translate}"{/if}>{if $ico_mode=="off"}{$COMMENT_COUNT|@translate_dec:'%d comment':'%d comments'}{else}&nbsp;{$COMMENT_COUNT}{/if}</li>{/if}
  {if isset($ppppp_e_mail)}<li class="{if $ico_mode=="on"}fas fa-shopping-cart{/if}{if $def_tab == "cart"} active{/if}" rel="tab-cart"{if $ico_mode=="on"} title="{"Cart"|@translate}"{/if}>{if $ico_mode=="off"}{"Cart"|@translate}{/if}</li>{/if}
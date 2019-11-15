<div data-role="footer" id="g-footer" {if isset($greydragon.p_footer)}class="expanded"{/if}>
  <ul class="g-inline g-link-list g-footer-topleft">
    {if isset($U_PROFILE)}<li class="dot">&middot;&nbsp;</li><li><a href="{$U_PROFILE}" title="{'My Profile'|@translate}" rel="nofollow">{$USERNAME}</a></li>{/if}
    {if isset($U_LOGIN)}<li class="dot">&middot;&nbsp;</li><li><a href="{$U_LOGIN}" rel="nofollow">{'Login'|@translate}</a></li>{/if}
    {if isset($U_REGISTER)}<li class="dot">&middot;&nbsp;</li><li><a href="{$U_REGISTER}" rel="nofollow">{'Register'|@translate}</a></li>{/if}
    {if isset($U_LOGOUT)}<li class="dot">&middot;&nbsp;</li><li><a href="{$U_LOGOUT}" rel="nofollow">{'Logout'|@translate}</a></li>{/if}
    {if !isset($ato)}{if isset($U_ADMIN)}<li class="dot">&middot;&nbsp;</li><li><a href="{$U_ADMIN}" rel="nofollow">{'Administration'|@translate}</a></li>{/if}{/if}
    {if ($greydragon.p_adminemail == "on" && isset($CONTACT_MAIL))}<li class="dot">&middot;&nbsp;</li><li><a href="mailto:{$CONTACT_MAIL}?subject={'A comment on your site'|@translate|@escape:url}" rel="nofollow">{'Contact'|@translate}</a></li>{/if}
    {if ($greydragon.p_hideabout == 'off')}<li class="dot">&middot;&nbsp;</li><li><a href="{$PHPWG_ROOT_PATH}/about.php">About</a></li>{/if}
  </ul>
  {if isset($greydragon.p_footer) || isset($footer_elements)}
  <div class="g-footer-bottomleft">
    {if isset($greydragon.p_footer)} {$greydragon.p_footer} {/if}
    {if isset($footer_elements)}
      {foreach from=$footer_elements item=elt}
        {$elt}
      {/foreach}
    {/if}
  </div>
  {/if}
  {if ($greydragon.p_credits !== "off")}
  <ul id="g-credits" class="g-inline g-link-list g-footer-topright{if $greydragon.p_credits == "text"} g-text-only{/if}">
    <li><span>{'Powered by'|@translate}&nbsp;</span><a title="Piwigo {$VERSION}" id="g-gallery-logo" class="Piwigo" href="{$PHPWG_URL}">Piwigo</a>{if $VERSION}<span>&nbsp;{$VERSION}</span>{/if}</li>
    <li><span>&middot;&nbsp;</span><a title="GreyDragon Theme ({$greydragon.p_colorpack})" id="g-theme-logo" href="#" target="_blank">GreyDragon</a></li>
  </ul>  
  {/if}
</div>
</div>
{get_combined_scripts load='footer'}
{if isset($U_ADMIN)}{if $greydragon.p_debug == "on"}{debug}{/if}{/if}
{if isset($debug.TIME)}
  <small>{'Page generated in'|@translate} {$debug.TIME} ({$debug.NB_QUERIES} {'SQL queries in'|@translate} {$debug.SQL_TIME})</small>
{/if}
{if isset($debug.QUERIES_LIST)}
<div id="debug">{$debug.QUERIES_LIST}</div>
{/if}
</body>
</html>
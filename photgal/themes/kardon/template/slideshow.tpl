{assign var='size' value=$current.selected_derivative->get_size()}


{combine_css path="themes/kardon/slideshow.css"}

{footer_script require="jquery"}{literal}
jQuery(document).ready(function() {
  var maxWidth = maxHeight  = margin =  0;
  var finalW = w = {/literal}{$size[0]}{literal}, finalH = h = {/literal}{$size[1]}{literal};
  if (typeof( window.innerWidth ) == 'number') {
    // Non-IE
    maxWidth = window.innerWidth;
    maxHeight = window.innerHeight;
  }
  else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) ) {
    //IE 6+ in 'standards compliant mode'
    maxWidth = document.documentElement.clientWidth;
    maxHeight = document.documentElement.clientHeight;
  }
  else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) ) {
    // IE 4 compatible
    maxWidth = document.body.clientWidth;
    maxHeight = document.body.clientHeight;
  }

  maxHeight = maxHeight-32;
  if ((h > maxHeight) || (w > maxWidth)) {
    if ((h > maxHeight) && (w > maxWidth)) {
      if (maxHeight-h < maxWidth-w) {
        finalH = maxHeight;
        finalW = w * finalH / h;
      }
      else {
        finalW = maxWidth;
        finalH = h * finalW / w;
      }
    }
    else if ((h > maxHeight) && (w < maxWidth)) {
      finalH = maxHeight;
      finalW = w * finalH / h;
    } 
    else if ((h < maxHeight) && (w > maxWidth)) {
      finalW = maxWidth;
      finalH = h * finalW / w;
    }
  }
  if ((maxHeight-finalH) > 0) {
    margin =  Math.round((maxHeight-finalH) / 2)
  }

  jQuery("#theImage").append('<img style="margin-top:'+margin+'px; width:'+finalW+'px;height:'+finalH+'px" src="{/literal}{$current.selected_derivative->get_url()}{literal}" alt="">');
});
{/literal}{/footer_script}

<div id="imageHeaderBar">
  <div class="browsePath">
    {if isset($U_SLIDESHOW_STOP) }
    [ <a href="{$U_SLIDESHOW_STOP}">{'stop the slideshow'|@translate}</a> ]
    {/if}
  </div>
  <div class="imageNumber">{$PHOTO}</div>
  {if $SHOW_PICTURE_NAME_ON_TITLE }
  <h2 class="showtitle">{$current.TITLE}</h2>
  {/if}
</div>

<div id="imageToolBar">
  {include file='picture_nav_buttons.tpl'|@get_extent:'picture_nav_buttons'}
</div>

<div id="theImage">
<noscript>
  <div>
    <img src="{$current.selected_derivative->get_url()}" {$current.selected_derivative->get_size_htm()} alt="{$ALT_IMG}">
  </div>
</noscript>
</div> <!-- theImage -->

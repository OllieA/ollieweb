  {if isset( $COMMENT_IMG )}
  <div id="tab-desc" class="image-metadata-tab"> 
    {$COMMENT_IMG}
  </div>
  {/if}

  <div id="tab-meta" class="image-metadata-tab"> 
    <dl id="standard" class="imageInfoTable dl-horizontal">
    {strip}
      {if $display_info.author and isset($INFO_AUTHOR)}
      <dt id="Author" class="imageInfo">{'Author'|@translate}</dt>
      <dd>{$INFO_AUTHOR}</dd>
      {/if}
      {if $display_info.created_on and isset($INFO_CREATION_DATE)}
      <dt id="datecreate">{'Created on'|@translate}</dt>
      <dd>{$INFO_CREATION_DATE}</dd>
      {/if}
      {if $display_info.posted_on}
      <dt id="datepost">{'Posted on'|@translate}</dt>
      <dd>{$INFO_POSTED_DATE}</dd>
      {/if}
      {if $display_info.dimensions and isset($INFO_DIMENSIONS)}
      <dt id="Dimensions">{'Dimensions'|@translate}</dt>
      <dd>{$INFO_DIMENSIONS}</dd>
      {/if}
      {if $display_info.file}
      <dt id="File">{'File'|@translate}</dt>
      <dd>{$INFO_FILE}</dd>
      {/if}
      {if $display_info.filesize and isset($INFO_FILESIZE)}
      <dt id="Filesize">{'Filesize'|@translate}</dt>
      <dd>{$INFO_FILESIZE}</dd>
      {/if}
      {if $display_info.categories and isset($related_categories)}
      <dt id="Categories">{'Albums'|@translate}</dt>
      <dd>
        <ul>
          {foreach from=$related_categories item=cat}
          <li>{$cat}</li>
          {/foreach}
        </ul>
      </dd>
      {/if}
      {if $display_info.visits}
      <dt id="Visits">{'Visits'|@translate}</dt>
      <dd>{$INFO_VISITS}</dd>
      {/if}
      {if $display_info.rating_score and isset($rate_summary)}
      <dt id="Average">{'Rating score'|@translate}</dt>
      <dd>
        {if $rate_summary.count}
        <span id="ratingScore">{$rate_summary.score}</span> <span id="ratingCount">({$rate_summary.count|@translate_dec:'%d rate':'%d rates'})</span>
        {else}
        <span id="ratingScore">{'no rate'|@translate}</span> <span id="ratingCount"></span>
        {/if}
      </dd>
      {/if}

      {if isset($rating)}
      <dt id="rating" >
        <span id="updateRate">{if isset($rating.USER_RATE)}{'Update your rating'|@translate}{else}{'Rate this photo'|@translate}{/if}</span>
      </dt>
      <dd>
        <form action="{$rating.F_ACTION}" method="post" id="rateForm" style="margin:0;">
          {foreach from=$rating.marks item=mark name=rate_loop}
            {if isset($rating.USER_RATE) && $mark==$rating.USER_RATE}
            <input type="button" name="rate" value="{$mark}" class="rateButtonSelected" title="{$mark}">
            {else}
            <input type="submit" name="rate" value="{$mark}" class="rateButton" title="{$mark}">
            {/if}
          {/foreach}
          {strip}{combine_script id='core.scripts' load='async' path='themes/default/js/scripts.js'}
            {combine_script id='rating' load='async' require='core.scripts' path='themes/default/js/rating.js'}
            {footer_script}
              var _pwgRatingAutoQueue = _pwgRatingAutoQueue||[];
              _pwgRatingAutoQueue.push( {ldelim}rootUrl: '{$ROOT_URL}', image_id: {$current.id},
                onSuccess : function(rating) {ldelim}
                  var e = document.getElementById("updateRate");
                  if (e) e.innerHTML = "{'Update your rating'|@translate|@escape:'javascript'}";
                  e = document.getElementById("ratingScore");
                  if (e) e.innerHTML = rating.score;
                  e = document.getElementById("ratingCount");
                  if (e) {ldelim}
                    if (rating.count == 1) {ldelim}
                      e.innerHTML = "({'%d rate'|@translate|@escape:'javascript'})".replace( "%d", rating.count);
                    } else {ldelim}
                      e.innerHTML = "({'%d rates'|@translate|@escape:'javascript'})".replace( "%d", rating.count);
                    }
                  {rdelim}
              {rdelim}{rdelim} );
            {/footer_script}
          {/strip}
        </form>
      </dd>
      {/if}

      {if $display_info.privacy_level and isset($available_permission_levels)}
      <dt id="Privacy">{'Who can see this photo?'|@translate}</dt>
      <dd>
        <a id="privacyLevelLink" href>{$available_permission_levels[$current.level]}</a>
{combine_script id='core.scripts' load='async' path='themes/default/js/scripts.js'}
{footer_script require='jquery'}{strip}
  function setPrivacyLevel(id, level){
    (new PwgWS('{$ROOT_URL}')).callService(
      "pwg.images.setPrivacyLevel", { image_id:id, level:level},
        {
          method: "POST",
          onFailure: function(num, text) { alert(num + " " + text); },
          onSuccess: function(result) {
          jQuery('#privacyLevelBox .switchCheck').css('visibility','hidden');
          jQuery('#switchLevel'+level).prev('.switchCheck').css('visibility','visible');
          jQuery('#privacyLevelLink').text(jQuery('#switchLevel'+level).text());
        }
      }
    );
  }
  (SwitchBox=window.SwitchBox||[]).push("#privacyLevelLink", "#privacyLevelBox");
{/strip}{/footer_script}
        <div id="privacyLevelBox" class="switchBox" style="display:none">
          {foreach from=$available_permission_levels item=label key=level}
            <span class="switchCheck"{if $level != $current.level} style="visibility:hidden"{/if}>&#x2714; </span>
            <a id="switchLevel{$level}" href="javascript:setPrivacyLevel({$current.id},{$level})">{$label}</a><br>
          {/foreach}
        </div>
      </dd>
      {/if}
    {/strip}
    </dl>
  </div>

  {if isset($metadata)}
  <div id="tab-exif" class="image-metadata-tab"> 
    <dl id="Metadata" class="imageInfoTable dl-horizontal">
    {foreach from=$metadata item=meta}
      {foreach from=$meta.lines item=value key=label}
        <dt>{$label}</dt>
        <dd>{$value}</dd>
      {/foreach}
    {/foreach}
    </dl>
  </div>
  {/if}

  {if ($display_info.tags && (isset($related_tags) || ($greydragon.hasUserTags)))}
  <div id="tab-tags" class="image-metadata-tab"> 
    {if ($greydragon.hasUserTags)}<table id="TagsTable"><tr id="Tags" ><td class="label"></td><td class="value">{/if}
    {foreach from=$related_tags item=tag name=tag_loop}{if !$smarty.foreach.tag_loop.first}, {/if}<a href="{$tag.URL}">{$tag.name}</a>{/foreach}
    {if ($greydragon.hasUserTags)}<div class="tags-edit-marker"><span class="fas fa-edit"></span> {'Edit'|@translate}</div></td></tr></table>{/if}
  </div>
  {/if}

  {if isset($COMMENT_COUNT)}
  <div id="tab-comment" class="image-metadata-tab"> 
    <div id="comments" {if (!isset($comment_add) && ($COMMENT_COUNT == 0))}class="noCommentContent"{else}class="commentContent"{/if}>
      <div id="pictureComments">
        {if isset($comment_add)}
        <div id="commentAdd">
          <h4>{'Add a comment'|@translate}</h4>
          <form method="post" action="{$comment_add.F_ACTION}" id="addComment">
            {if $comment_add.SHOW_AUTHOR}
            <p><label for="author">{'Author'|@translate}{if $comment_add.AUTHOR_MANDATORY} ({'mandatory'|@translate}){/if} :</label></p>
            <p><input type="text" name="author" id="author" value="{$comment_add.AUTHOR}"></p>
            {/if}
            {if $comment_add.SHOW_EMAIL}
            <p><label for="email">{'Email address'|@translate}{if $comment_add.EMAIL_MANDATORY} ({'mandatory'|@translate}){/if} :</label></p>
            <p><input type="text" name="email" id="email" value="{$comment_add.EMAIL}"></p>
            {/if}
            <p><label for="website_url">{'Website'|@translate} :</label></p>
            <p><input type="text" name="website_url" id="website_url" value="{$comment_add.WEBSITE_URL}"></p>
            <p><label for="contentid">{'Comment'|@translate} ({'mandatory'|@translate}) :</label></p>
            <p><textarea name="content" id="contentid" rows="5" cols="50">{$comment_add.CONTENT}</textarea></p>
            <p><input type="hidden" name="key" value="{$comment_add.KEY}">
            <input type="submit" value="{'Submit'|@translate}"></p>
          </form>
        </div>
        {else}
          {if ($COMMENT_COUNT == 0)}<p>{'No Comments Allowed'|@translate}</p>{/if}
        {/if}
        {if isset($comments)}
        <div id="pictureCommentList">
          {if (($COMMENT_COUNT > 2) || !empty($navbar))}
          <div id="pictureCommentNavBar">
            {if $COMMENT_COUNT > 2}
            <a href="{$COMMENTS_ORDER_URL}#comments" rel="nofollow" class="commentsOrder">{$COMMENTS_ORDER_TITLE}</a>
            {/if}
            {if !empty($navbar) }{include file='navigation_bar.tpl'|@get_extent:'navbar'}{/if}
          </div>
          {/if}
          {include file='comment_list.tpl'}
        </div>
        {/if}
      </div>
    </div>
  </div> 
  {/if}

  {if isset($ppppp_e_mail)}
  <div id="tab-cart" class="image-metadata-tab">
    {if isset($COMMENT_IMG)}
    {/if}
  </div>
  {/if}

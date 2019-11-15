{if !empty($blocks) }
<div id="menubar">
	{foreach from=$blocks key=id item=block name=blocks}
	<dl id="{$id}" {if $smarty.foreach.blocks.first}class="mbFirstBlock"{/if}{if $smarty.foreach.blocks.last}class="mbLastBlock"{/if}>
		{if not empty($block->template)}
		{include file=$block->template|@get_extent:$id }
		{else}
		{$block->raw_content}
		{/if}
	</dl>
	{/foreach}
</div>
{/if}
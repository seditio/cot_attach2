<!-- BEGIN: MAIN -->
<link rel="stylesheet" href="plugins/attach2/js/attach2.css">
<a href="index.php?r=attach2&amp;a=display&amp;area={ATTACH_AREA}&amp;item={ATTACH_ITEM}" class="attLink" title="{PHP.L.att_attachments}">{PHP.L.att_attach}</a>

<div id="attModal" class="jqmWindow">
	<div id="attModalTitle">
		<button id="attModalClose" class="jqmClose btn btn-danger">
			&times;
		</button>
	</div>
	<iframe id="attModalContent" src="">
	</iframe>
</div>

<script>
$(function() {
	var loadInIframeModal = function(hash) {
		var trigger = $(hash.t);
		var modal = $(hash.w);
		var url = trigger.attr('href');
		var title= trigger.attr('title');
		var modalContent = $("iframe", modal);

		modalContent.html('').attr('src', url);
		//let's use the anchor "title" attribute as modal window title
		$('#attModalTitleText').text(title);
		modal.jqmShow();
		$('#attModal').css('margin-left', '-'+($('#attModal').width()/2)+'px');
		$('#attModal').css('margin-top', '-'+($('#attModal').height()/2)+'px');
		$('#attModal').css('display','block');

		$('#attModalClose').click(function() {
			window.location.reload();
		});
	};
	// initialise jqModal
	$('#attModal').jqm({
		modal: false,
		trigger: 'a.attLink',
		target: '#attModalContent',
		onShow:  loadInIframeModal
	});
});
</script>
<!-- END: MAIN -->

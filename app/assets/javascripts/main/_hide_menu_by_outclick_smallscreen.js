function hideMenuByOutclickSmallscreen() {

	$(document).find('main').on('click', function() {
		$('#show_topmenu').attr('checked', false);
	});
}
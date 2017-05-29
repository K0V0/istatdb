function searchItemActions() {

	this.init();
	this.events();
}

searchItemActions.prototype = {
	constructor: searchItemActions,

	init: function() {

	},

	events: function() {
		$(document).onNotTooOften('input', 350, "section.search_bar > form", function() {
			$(this).append('<input type="hidden" name="page" value="1">');
		  	$(this).submit();
		});
		$(document).on('click', '#clear_search', function() {
			$(this).closest('section.search_bar').find('input[type="search"]').val('');
		});
		$(document).on('click', '#reset_search', function() {
			$(this).closest('section.search_bar').find('input:not([type="submit"]), select').val('');
		});
	}
}
function searchItemActions() {
	logger("searcher inited");
	this.events();
}

searchItemActions.prototype = {
	constructor: searchItemActions,

	events: function() {

		$(document).frequentFireLimit('input', 350, "section.search_bar > form", function(e) {
			$(this).append('<input type="hidden" name="page" value="1">');
			var inputs = $(document).find("input."+$(e.target).attr('class')+"[type=search]");
			inputs.val($(e.target).val());
		  	$(this).submit();
		});
		
		$(document).on('click', '#clear_search', function() {
			$(this).closest('section.search_bar').find('input[type="search"]').val('');
		});

		$(document).on('click', '#reset_search', function() {
			$(this).closest('section.search_bar').find('input:not([type="submit"]), select').val('');
		});

		$(document).on('click', '#search_item_on_google' , function() {
			var searched_term = $(this).closest('form').find('input[autofocus=autofocus]').first().val();
			window.open('http://google.com/search?q=' + searched_term);
		});
	}
}
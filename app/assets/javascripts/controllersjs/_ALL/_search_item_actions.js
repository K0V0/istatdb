function SearchItemActions() {
	this.init();
	this.rememberLastSearches = new RememberLastSearches();
	this.lastSearchSwitchTimer = null;
}

SearchItemActions.prototype = {
	constructor: SearchItemActions,

	init: function() {
		var T = this;

		$(document).frequentFireLimit('input', 350, "section.search_bar > form", function(e) {
			if ($(this).hasClass('paused')) {

			} else {
				$(this).append('<input type="hidden" name="page" value="1">');
				var inputs = $(document).find("input."+$(e.target).attr('class')+"[type=search]");
				inputs.val($(e.target).val());
			  	$(this).submit();
			}
		});

		//$(document).frequentFireLimit('input', 2500, "section.search_bar > form input[type=search]", function(e) {
		//	T.rememberLastSearches.add($(this));
		//});

		$(document).on('click', '#clear_search', function() {
			$(this).closest('section.search_bar').find('input[type="search"]').val('');
		});

		$(document).on('click', '#reset_search', function() {
			$(this).closest('section.search_bar').find('input:not([type="submit"]), select').val('');
		});

		$(document).on('click', '#search_item_on_google, #search_item_on_google_2' , function() {
			var searched_term = $(document).find('section.search_bar').children('form').find('input[autofocus=autofocus]').first().val();
			window.open('http://google.com/search?q=' + searched_term);
		});

		$(document).on('click', '#last_searches', function() {
			console.log("malo by pause");

			/// !!! input type BUTTON pravdepodobne submituje formular a sposobuije opakovany request

			//$(document).find("section.search_bar > form").addClass('paused');
			//window.clearTimeout(T.lastSearchSwitchTimer);
			//T.lastSearchSwitchTimer = window.setTimeout(function(){ 
			//	console.log("mohlo by ist uz");
			//	$(document).find("section.search_bar > form").removeClass('paused');
			//}, 1500);
			//$(document).find('input[type="search"]').eventPause();
		});
	}
}

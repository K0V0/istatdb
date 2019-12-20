function SearchItemActions() {
	this.init();
	//this.rememberLastSearches = new RememberLastSearches();
	//this.lastSearchSwitchTimer = null;
}

SearchItemActions.prototype = {
	constructor: SearchItemActions,

	init: function() {
		var T = this;

		$(document).frequentFireLimit('input', 350, "section.search_bar > form", function(e) {
			//console.log('fired');
			//if ($(this).hasClass('paused')) {
				//logger("imput search");
			//} else {
				if($(e.target).is('input[type=search]')) {
					T.resetLastViewed();
				}

				if (!$(e.target).hasClass('skip_events')) {
					$(this).append('<input type="hidden" name="page" value="1">');
					var inputs = $(document).find("input."+$(e.target).attr('class')+"[type=search]");
					inputs.val($(e.target).val());
				  	$(this).submit();
				}
			//}
		});

		/*$(document).frequentFireLimit('input', 2500, "section.search_bar > form input[type=search]", function(e) {
			T.rememberLastSearches.add($(this));
		});*/

		$(document).on('click', '#clear_search', function() {
			$(this).closest('section.search_bar').find('input[type="search"]').val('');
		});

		$(document).on('click', '#reset_search', function() {
			$(this).closest('section.search_bar').find('input:not([type="submit"]), select').val('');
			//$(this).closest('section.search_bar').find('div.multiselect > span').empty().text(t('goods_search.manufacturer_prompt'));
		});

		$(document).on('click', '#search_item_on_google, #search_item_on_google_2' , function() {
			var searched_term = $(document).find('section.search_bar').children('form').find('input[autofocus=autofocus]').first().val();
			window.open('http://google.com/search?q=' + searched_term);
		});

		$(document).on('click', '#back_or_search', function() {
			T.resetLastViewed();
		});

		/*$(document).on('click', '#last_searches', function() {
			$(document).find("section.search_bar > form").addClass('paused');
			window.clearTimeout(T.lastSearchSwitchTimer);
			var res = T.rememberLastSearches.rewind($(this));
			$(this).closest('section.search_bar').find('input[type="search"]').filter('[autofocus=autofocus]').val(res);
			T.lastSearchSwitchTimer = window.setTimeout(function(){ 
				$(document).find("section.search_bar > form")
				.removeClass('paused')
				.submit();
			}, 1500);
		});*/
	},

	resetLastViewed: function() {
		$(document).find('form').find('select#last_visits').val('');
	}
}

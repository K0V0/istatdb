function SearchItemActions() {
	this.autosubmit = true;
	this.autosubmit_delay = 350;
	this.enter_submit = true;
	this.init();
	//this.rememberLastSearches = new RememberLastSearches();
	//this.lastSearchSwitchTimer = null;
}

SearchItemActions.prototype = {
	constructor: SearchItemActions,

	init: function() {
		var T = this;

		if ((enter_submit = $(document).find('input#user_settings_behavior_submit_by_enter').first().val()).length != 0) {
			if (enter_submit == "1") {
				T.enter_submit = true
			} else {
				T.enter_submit = false
			}
		}

		if ((autosubmit = $(document).find('input#user_settings_behavior_autosubmit').first().val()).length != 0) {
			if (autosubmit == "1") {
				T.autosubmit = true
			} else {
				T.autosubmit = false
			}
		}

		if (T.enter_submit === true) {
			$(document).on('keypress',function(e) {
			    if(e.which == 13) {
			        e.preventDefault();
			        $(document).find("section.search_bar > form").append('<input type="hidden" name="page" value="1">');
			        $(document).find("section.search_bar > form").submit();
			    }
			});
		}

		if (T.autosubmit === true) {

			if ((autosubmit_delay = $(document).find('input#user_settings_behavior_autosubmit_delay').first().val()).length != 0) {
				T.autosubmit_delay = parseInt(autosubmit_delay);
			}

			$(document).frequentFireLimit('input', T.autosubmit_delay, "section.search_bar > form", function(e) {
				if($(e.target).is('input[type=search]')) {
					T.resetLastViewed();
				}

				if (!$(e.target).hasClass('skip_events')) {
					$(this).append('<input type="hidden" name="page" value="1">');
					var inputs = $(document).find("input."+$(e.target).attr('class')+"[type=search]");
					inputs.val($(e.target).val());
				  	$(this).submit();
				  	console.log('search submitted');
				}
			});

		}
		
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

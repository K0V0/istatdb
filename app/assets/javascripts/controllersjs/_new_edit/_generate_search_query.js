function GenerateSearchQuery () {
	this.init();
}

GenerateSearchQuery.prototype = {
	constructor: GenerateSearchQuery,

	init: function() {
		var totok = this;
		$(document).find('section.form').find('article').each(function() {
			if (typeof $(this).data('searcher-query') != 'undefined') {
				totok.attachEvent($(this));
			}
		});
	},

	attachEvent: function(ref) {
		// ref - article element (window)
		var toto = this;
		$(ref).find('input.allow_add_new').rememberUserManipulation();
		$(ref)
			.find(this.generateInputsClassesList(ref))
			.frequentFireLimit('input', 350, '', function() {
				toto.doAjax($(this));
		});
		if ($(ref).children('input[name=load-limit]').length) {
			toto.onScrollToEnd($(ref));
		}
	},

	generateInputsClassesList: function(ref) {
		// ref - article element (window)
		var elem_string = '';
		var keys = Object.keys(ref.data('searcher-query'));
		var keys_length = keys.length;
		var assoc_name = ref.data('searcher-assoc');

		for (var i=0; i<keys_length; i++) {
			elem_string += ('.' + assoc_name + '_' + keys[i].replace('translations_', ''));
			if (i < keys_length-1) { elem_string += ', '; }
		}
		return elem_string;
	},

	doAjax: function(ref, action='new_select_search') {
		// ref - input field that event occurs on
		var toto = this;
		var wndw = ref.closest('article');
		var load_limit = wndw.children('input[name=load-limit]').val();
		var loaded_page = parseInt(wndw.children('input[name=page_num]').val());

		$.ajax({
		  	method: 	"POST",
		 	url: 		'/' + wndw.data('searcher-assoc').pluralize() + '/' + action,
		  	data: {
		  		q: 					toto.generateQueryString(wndw),
		  		model: 				wndw.data('searcher-assoc'),
		  		source_controller: 	$('body').data('controller_name').singularize(),
		  		association_type: 	wndw.children('input[name=assoc-type]').val(),
		  		window_id: 			wndw.attr('id'),
		  		multiedit: 			wndw.data('searcher-multiedit'),
		  		loaded_page: 		loaded_page,
		  		per_page: 			load_limit,
		  	}
		});
	},

	generateQueryString: function(ref) {
		// ref - article element (window)
		var querystring = {};
		var ransack_scheme = ref.data('searcher-query');
		var scheme_keys = Object.keys(ransack_scheme);

		for (var i=0; i<scheme_keys.length; i++) {
			var qs_key = scheme_keys[i] + '_' + ransack_scheme[ scheme_keys[i] ];
			var qs_val = ref.find('.' + ref.data('searcher-assoc') + '_' + scheme_keys[i].replace("translations_", "")).val();
			querystring[qs_key] = qs_val;
		}

		return querystring;
	},

	onScrollToEnd: function(ref) {
		var toto = this;
		var last_y_pos = 0;
		ref.find('div.tablewrap')[0].onscroll = function(e) {
			var elem = $(e.currentTarget);
			var scroll_top;
			// reaguje len na koliesko mysi
			if ((scroll_top = elem.scrollTop()) > last_y_pos) {
			    if (elem[0].scrollHeight - scroll_top == elem.outerHeight()) {
			        var wndw = $(this).closest('article');
			        toto.doAjax(
			        	wndw.find(toto.generateInputsClassesList(wndw)),
			        	'new_select_load_items'
			        );
			    }
			}
			last_y_pos = scroll_top;
		};
	}
}

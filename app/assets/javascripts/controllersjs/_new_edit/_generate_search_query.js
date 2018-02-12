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
	},

	generateInputsClassesList: function(ref) {
		// ref - article element (window)
		var elem_string = '';
		var keys = Object.keys(ref.data('searcher-query'));
		var keys_length = keys.length;
		var assoc_name = ref.data('searcher-assoc');

		for (var i=0; i<keys_length; i++) {
			elem_string += ('.' + assoc_name + '_' + keys[i]);
			if (i < keys_length-1) { elem_string += ', '; } 
		}
		//console.log(elem_string);
		return elem_string;
	},

	doAjax: function(ref) {
		// ref - input field that event occurs on
		var toto = this;
		var wndw = ref.closest('article');

		$.ajax({
		  	method: 	"POST",
		 	url: 		'/' + wndw.data('searcher-assoc').pluralize() + '/new_select_search',
		  	data: { 
		  		q: 					toto.generateQueryString(wndw),
		  		model: 				wndw.data('searcher-assoc'),
		  		source_controller: 	$('body').data('controller_name').singularize(),
		  		association_type: 	wndw.children('input[name=assoc-type]').val(),
		  		window_id: 			wndw.attr('id')
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
			var qs_val = ref.find('.' + ref.data('searcher-assoc') + '_' + scheme_keys[i]).val();
			querystring[qs_key] = qs_val;
		}

		return querystring;
	}
}
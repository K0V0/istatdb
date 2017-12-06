function generateSearchQuery () {

	this.init();
}

generateSearchQuery.prototype = {
	constructor: generateSearchQuery,

	init: function() {
		var totok = this;
		$(document).find('section.form').find('article').each(function() {
			if (typeof $(this).data('searcher-query') != 'undefined') {
				totok.attachEvent($(this));
			}
		});
	},

	attachEvent: function(ref) {
		//var search_conditions = ref.data('searcher-query');
		//logger( this.generateInputsClassesList(ref));
		var toto = this;
		$(ref)
			.find(this.generateInputsClassesList(ref))
			.frequentFireLimit('input', 350, '', function() {
				//logger($(this));
				toto.doAjax($(this));
		});
	},

	generateInputsClassesList: function(ref) {
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

	doAjax: function() {

	}
}
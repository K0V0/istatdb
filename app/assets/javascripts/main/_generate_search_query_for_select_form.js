function generateSearchQueryForSelectForm (model_name, fields) {
	this.HELPER = new generateSearchQueryForSelectForm_helper();
	this.model_name = model_name;
	this.fields = fields;

	this.model_name_plu = '';
	this.path = '';
	//this.inputs_to_listen = ''

	this.init();
}

generateSearchQueryForSelectForm.prototype = {
	constructor: generateSearchQueryForSelectForm,

	init: function() {
		var TOTO = this;
		this.model_name_plu = this.HELPER.toPlural(this.model_name);
		this.path = '/' + this.model_name_plu + '/new_select_search';

		$(document).on('input', this.generateInputsIdsList(), function(e) {
			TOTO.removeErros(this);
		});
	},

	generateInputsIdsList: function() {
		var elem_string = '';
		var keys = Object.keys(this.fields);
		var keys_length = keys.length;
		for (var i=0; i<keys_length; i++) {
			elem_string += ('#' + this.model_name + '_' + keys[i]);
			if (i < keys_length-1) { elem_string += ', '; } 
		}
		return elem_string;
	}, 

	removeErros: function(ref) {
		$(ref).removeClass('error');
		$(ref).closest('article').find('div.form_errors').empty();
	}
}



function generateSearchQueryForSelectForm_helper () {

}

generateSearchQueryForSelectForm_helper.prototype = {
	constructor: generateSearchQueryForSelectForm_helper,

	init: function() {

	},

	toPlural(str) {
		var last_char = str.substr(str.length-1);
		if (last_char == 'y') {
			return str.substr(0, str.length-1) + 'ies';
		} else {
			return str + 's';
		}
	}
}

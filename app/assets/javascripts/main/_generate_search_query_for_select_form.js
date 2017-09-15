function generateSearchQueryForSelectForm (model_name, fields) {
	this.HELPER = new generateSearchQueryForSelectForm_helper();
	this.model_name = model_name;
	this.fields = fields;

	this.source_controller = '';
	this.model_name_plu = '';
	this.path = '';
	this.assoc_type = '';

	this.init();
}

generateSearchQueryForSelectForm.prototype = {
	constructor: generateSearchQueryForSelectForm,

	init: function() {
		console.log("generateSearchQueryForSelectForm() init()");
		var TOTO = this;
		this.model_name_plu = this.HELPER.toPlural(this.model_name);
		this.path = '/' + this.model_name_plu + '/new_select_search';
		this.source_controller = $("body").data("controller_name_singular");
		this.assoc_type = $(document).find("#" + this.model_name + "_select").children("input[name=assoc-type]").first().val();
		console.log(this.assoc_type);

		$(document).on('input', this.generateInputsIdsList(), function(e) {
			console.log("generateSearchQueryForSelectForm() onInput()");
			TOTO.removeErros(this);

			$.ajax({
			  	method: "POST",
			 	url: TOTO.path,
			  	data: { 
			  		q: TOTO.generateAjaxDataObj(),
			  		model: TOTO.model_name,
			  		source_controller: TOTO.source_controller,
			  		association_type: TOTO.assoc_type
			  	}
			});
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
		console.log(elem_string);
		return elem_string;
	},

	generateAjaxDataObj: function() {
		var request_data = {};
		var keys = Object.keys(this.fields);
		for (var i=0; i<keys.length; i++) {
			request_data[keys[i] + '_' + this.fields[keys[i]]] = $('#'+this.model_name+'_'+keys[i]).val();
		}
		return request_data;
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

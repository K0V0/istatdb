function OptionsList(elem_source_of_data) {
	this.src = elem_source_of_data;
	this.for = "";
	this.data = [];
	this.collect();
}

OptionsList.prototype = {
	constructor: OptionsList,

	contains: function(id_num) {
		var data = this.data
		for (var i in data) {
			if (id_num == data[i].id) {
				return true;
			}
		}
		return false;
	},

	collect: function() {
		var src = this.src;
		var toto = this;
		this.for = $(src).attr('id').match(/^[a-z]+/)[0];
		$(src).find("input:checked").each(function() {
			var data = {};
			if ($(this).hasClass('allow_add_new')) {
				data = {
					id: "0",
					text: t('goods.new_form_texts.uom_not_yet_created_select')
				}
			} else {
				data = {
					id: $(this).val(),
					text: $(document).find('label[for=' + $(this).attr('id') +']').text()
				}
			}
			toto.data.push(data);
		});
	}
}


function AttrsManipulator() {}

AttrsManipulator.prototype = {
	constructor: AttrsManipulator,

	generateNewUomInputAttr(elem, attr_name, index) {
		var attrs_catch_regex = /^(\D+)(\d+)(\D+)$/;
		var new_attr_val = elem.attr(attr_name).replace(attrs_catch_regex, '$1' + index + '$3');
		elem.attr(attr_name, new_attr_val);
	}
}

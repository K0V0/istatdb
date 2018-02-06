function UomDropdownHelper() {
	this.init();
}

UomDropdownHelper.prototype = {
	constructor: UomDropdownHelper,

	init: function() {

	},

	rememberChangeByUser: function(dropdown_elem) {
		$(dropdown_elem).data('user_selected', $(dropdown_elem).val());
	},

	updateDropdownLists: function(list) {
		// updates options list in uom(s) dropdowns for manufacturer and client
		// list - json-like list with new options set
		var T = this;
		$(document)
		.find('select')
		.filter(function() { 
			return this.id.match("good_uoms_attributes_[0-9]+_" + list.for + "_id");
		})
		.each (function() {
			T.clearDropdown(this, list);
			T.fillupDropdown(this, list.data);
			$(this).trigger('change');
			// beacause of uom_helper.js to decide if enable/disable buttons
		});
	},

	fillupDropdown: function(ref, list) {
		$(ref).data('data_changed', '1');
		list.forEach(function(opt) {
			var duplicate = $(ref).find('option[value='+opt.id+']');
			if(duplicate.length == 0) {
				$(ref).append('<option value="' + opt.id + '">' + opt.text + '</option>');
			}
		});
	},

	clearDropdown: function(ref, list) {
		$(ref).children('option').each(function() {
			if ($(this).val() != $(ref).data('user_selected')) {
				$(this).remove();
			} else {
				if (!list.contains($(this).val())) { $(this).data('not_in_source', '1'); }
			}
		});
	},

	decideIfEnable: function(dropdown_elem) {
		var opts = $(dropdown_elem).children('option');
		var enable = false;
		if (opts.length == 1 && opts.first().val() != "") {
			enable = true;
		} else if (opts.length > 1) {
			enable = true;
		}
		enable ? $(dropdown_elem).enable() : $(dropdown_elem).disable();
	},

	validate: function(dropdown_elem) {
		// runs in onchange event
		var opts = $(dropdown_elem).children('option');
		var valid = true;

		if (opts.length < 1) {
			this.appendSelectSthText(dropdown_elem);
			// no data there, append add something text
			if ($(dropdown_elem).data('data_changed') == '1') { 
				valid = false;
				// if dropdown was manipulated before, highlight
			}
		} else {
			opts.each(function() {
				logger($(this).data());
				if ($(this).data('not_in_source') == "1") {
					if ($(dropdown_elem).data('user_selected') == $(this).val()) {
						valid = false;
						$(this).data('not_in_source', '0');
						// if selected value is no more available for goods
					}
				}
			});
		}

		valid ? $(dropdown_elem).removeClass('error') : $(dropdown_elem).addClass('error');
		// maybe nullize value to empty string to prevent submit form if invalid
		// skusit jquery one() metodu
	},

	appendSelectSthText(dropdown_elem) {
		var rgx = /good_uoms_attributes_[0-9]+_([a-z]+)_id/;
		var missing = $(dropdown_elem).attr('id').match(rgx)[1];
		var text = t('goods.new_form_texts.uom_cannot_select_' + missing);
		$(dropdown_elem).append('<option value="">' + text + '</option>');
	}
}


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
		this.for = $(src).closest('article').attr('id').match(/^[a-z]+/)[0];
		$(src).closest('article').find("input:checked").each(function() {
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
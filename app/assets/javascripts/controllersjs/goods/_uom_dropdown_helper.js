function UomDropdownHelper() {
	
}

UomDropdownHelper.prototype = {
	constructor: UomDropdownHelper,

	rememberChangeByUser: function(dropdown_elem) {
		$(dropdown_elem).data('user_selected', $(dropdown_elem).val());
	},
	
	updateDropdowns: function(checkboxes_containers) {
		var T = this;
		$(checkboxes_containers).each(function() {
			var list = new OptionsList(this);
			T.updateDropdownLists(list);
		});
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
				//logger($(this).data());
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
function UomDropdownHelper() {
	this.AM = new AttrsManipulator();
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
			// beacause of Uom.onChange() action to decide if enable/disable buttons
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

	validate: function(dropdown_elem, force_source_compare) {
		// runs in onchange event
		var T = this;
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
				if ($(this).data('not_in_source') == "1") {
					if ($(dropdown_elem).data('user_selected') == $(this).val()) {
						valid = false;
						$(this).data('not_in_source', '0');
						T.appendRemovedFromSource(dropdown_elem);
						// if selected value is no more available for goods
					}
				}
			});
		}

		if (force_source_compare !== undefined) {
			var klass_for_source = $(dropdown_elem).attr('class').match(/uom_([a-z]+)\s*[a-z]*/)[1] + '_select';
			var list = new OptionsList($(document).find('article.'+klass_for_source));
			if (list.contains($(dropdown_elem).val()) === false) {
				valid = false;
			}
			$(dropdown_elem).children('option').each(function() {
				if (list.contains($(this).val()) === false) {
					$(this).addClass('obsolete');
				}
			});
		}

		valid ? T.removeFormError(dropdown_elem) : $(dropdown_elem).addClass('error');
	},

	appendSelectSthText: function(dropdown_elem) {
		var assoc = this.AM.getAssocFromDropdownId(dropdown_elem);
		var text = t('goods.new_form_texts.uom_cannot_select_' + assoc);
		$(dropdown_elem).append('<option value="">' + text + '</option>');
	},

	appendRemovedFromSource: function(dropdown_elem) {
		var assoc = this.AM.getAssocFromDropdownId(dropdown_elem);
		var text = t('goods.new_form_texts.uom_' + assoc + '_removed_from_source');
		this.createFormError(dropdown_elem, text);
	},

	createFormError: function(input_elem, text) {
		this.removeFormError(input_elem);
		var elem = $("<span class=\"errormessage " + $(input_elem).attr('class') + "\">" + text + "</span>");
		$(input_elem).closest('article.uoms').find('div.form_errors').append(elem);
	},

	removeFormError: function(input_elem) {
		$(input_elem).removeClass('error');
		$(input_elem)
			.closest('article.uoms')
			.find('div.form_errors')
			.find('span.' + $(input_elem).attr('class'))
			.remove();
	}
}

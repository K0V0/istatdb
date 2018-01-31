function UomDropdownHelper() {

	this.init();
}

UomDropdownHelper.prototype = {
	constructor: UomDropdownHelper,

	init: function() {

	},

	fillupDropdown: function(ref, list) {
		//console.log(list);
		list.forEach(function(opt) {
			//console.log(elem);
			$(ref).append('<option value="' + opt.id + '">' + opt.text + '</option>');
		});
	},

	clearDropdown: function(ref) {
		$(ref).children('option').each(function() {
			$(this).remove();
		});
	},

	/*rememberInitialState: function(ref) {
		//$(this).data('selected_by_hand', $(this).val());
		//console.log($(ref).val());
		var val = $(ref).val();
		if (val != '') {
			$(ref).data('initial', val);
		}
	},*/

	decideEnable(dropdown_elem, opts) {
		var enable = false;
		//logger($(dropdown_elem));
		//logger(opts.length);
		if (opts.length < 1) {
			//false
			this.appendSelectSthText(dropdown_elem);
		}
		else if (opts.length == 1) {
			//logger("1");
			if (opts.first().val() == "") {
				// if only option is not blank text informing that nothing to do
				//false
			} else {
				enable = true;
			}
		} 
		else if (opts.length > 1) {
			enable = true;
		}

		if (enable === true) {
			//logger($(dropdown_elem));
			$(dropdown_elem).removeAttr('disabled');
		} else {
			$(dropdown_elem).attr('disabled', 'disabled');
		}
	},

	decideValid(dropdown_elem) {
		return true;
	},

	appendSelectSthText(dropdown_elem) {
		var rgx = /good_uoms_attributes_[0-9]+_([a-z]+)_id/;
		var missing = $(dropdown_elem).attr('id').match(rgx)[1];
		var text = t('goods.new_form_texts.uom_cannot_select_' + missing);
		//logger(text);
		$(dropdown_elem).append('<option value="">' + text + '</option>');
	}

}
function UomDropdownHelper() {
	this.init();
}

UomDropdownHelper.prototype = {
	constructor: UomDropdownHelper,

	init: function() {

	},

	fillupDropdown: function(ref, list) {
		//console.log(list);
		var T = this;
		//logger('idee');
		$(ref).data('manipulated', '1');
		//$(ref).removeClass('error');
		//$(ref).removeClass('manipulated');
		list.forEach(function(opt) {
			//console.log(T.choosen_and_then_obsolete_option_id);
			//console.log(opt.id);
			//if (T.choosen_and_then_obsolete_option_id != opt.id) {
				//logger($(ref).data('obsolete'));
			if (/*$(ref).data('obsolete') != opt.id && */$(ref).data('user_explicitly_selected') != opt.id) {
				// user choosed option that became obsolete by user manipulation on
				// good's properties after, is not deleted, so do not add it twice
				$(ref).append('<option value="' + opt.id + '">' + opt.text + '</option>');
			}
		});
	},

	clearDropdown: function(ref, list) {
		var T = this;
		$(ref).removeClass('error');
		$(ref).children('option').each(function() {
			//logger($(this).val());
			option_explicitly_selected = $(this).val() == $(ref).data('user_explicitly_selected');
			option_selected_now = $(this).val() == $(ref).val();

			//$(ref).removeClass('error');

			//logger($(ref).data('obsolete'));

			/*if (option_selected_now == false && option_explicitly_selected == false) {
				$(this).remove();
			} else if (option_selected_now == true && option_explicitly_selected == true)  {
				// if user choosed option on dropdown but then remove it from
				// good's attributes, do not remove it, tell him what have done
				logger('obsolete');
				$(ref).data('obsolete', $(this).val());
			}*/
			if (option_explicitly_selected == false) {
				$(this).remove();
			} else if ($(this).val() == "") {
				// empty value - just text saying to select sth - delete it
				$(this).remove();
			} else {
				// if user choosed option on dropdown but then remove it from
				// good's attributes, do not remove it, tell him what have done
				//if ()
				//if (option_selected_now == true) {
					//logger($(this).val());
					//logger(list);
					//logger(list.contains($(this).val()));
					//logger('obsolete');
					//$(ref).data('obsolete', $(this).val());
					if (list.contains($(this).val())) {
						//$(this).remove();
					} else {
						logger('obsolete');
						$(ref).data('obsolete', $(this).val());
						$(ref).addClass('error');
					}
				//}
			}
			//$(ref).addClass('error');
			//$(this).remove();

		});
	},

	decideEnable(dropdown_elem) {
		var opts = $(dropdown_elem).children('option');
		var enable = false;
		//logger($(dropdown_elem));
		//logger(opts.length);
		if (opts.length < 1) {
			//false
			this.appendSelectSthText(dropdown_elem);
			if ($(dropdown_elem).data('manipulated') == '1') { 
				// if user previously selected something from good's properties
				// list and then deselect everything, inform him
				$(dropdown_elem).addClass('error');
			}
		}
		else if (opts.length == 1) {
			//logger("1");
			if (opts.first().val() == "") {
				// if only option is blank show text informing that nothing to do
				//false
			} /*else if (opts.first().val() == "0") {
				//$(dropdown_elem).addClass('error');
				//false
			}*/ else {
				enable = true;
			}
		} 
		else if (opts.length > 1) {
			enable = true;
		}

		if (enable === true) {
			//logger($(dropdown_elem));
			$(dropdown_elem).enable();
		} else {

			$(dropdown_elem).disable();
		}
	},

	appendSelectSthText(dropdown_elem) {
		var rgx = /good_uoms_attributes_[0-9]+_([a-z]+)_id/;
		var missing = $(dropdown_elem).attr('id').match(rgx)[1];
		var text = t('goods.new_form_texts.uom_cannot_select_' + missing);
		//logger(text);
		$(dropdown_elem).append('<option value="">' + text + '</option>');
	},

	appendObsoleteChoosenError(dropdown_elem) {

	}


}

function OptionsList() {
	this.for = "";
	this.data = [];
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
	}
}
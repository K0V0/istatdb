function UomDropdown() {
	this.H = new UomDropdownHelper();
	this.init();
}

UomDropdown.prototype = {
	constructor: UomDropdown,

	init: function() {

	},

	/*rememberDropdownsInitialStates: function() {
		var T = this;
		$(document)
		.find('article.uoms')
		.find('select')
		.filter(function() { 
			return this.id.match("good_uoms_attributes_[0-9]+_(impexpcompany|manufacturer){1}_id");
		})
		.each(function() {
			T.H.rememberInitialState(this);
		});
	},*/

	recollectAvailOptionsForDropdowns: function() {
		var T = this;
		// actions on change selections in impexpcompany/manufacturer section
		// that uom(s) are affected by 
		$(document)
		.find('article.impexpcompany_select, article.manufacturer_select')
		.find('input[type=checkbox]')
		.on('change', this, function(){ 
			//console.log($(this).closest('tbody').find("input:checked"));
			//impexpcompany_select_0
			var list = {
				for: $(this).closest('article').attr('id').match(/^[a-z]+/)[0],
				data: []
			};
			$(this).closest('tbody').find("input:checked").each(function() {
				//console.log($(this).val());
				//console.log($(document).find('label[for=' + $(this).attr('id') +']').text());
				list.data.push({ 
					id: $(this).val(),
					text: $(document).find('label[for=' + $(this).attr('id') +']').text()
				});
			});
			//console.log(list);
			T.updateDropdownLists(list);
		});
	},

	updateDropdownLists: function(list) {
		// list - json-like list with new options set
		var T = this;
		/*console.log(
			$(document)
			.find('select')
			.filter(function() { return this.id.match("good_uoms_attributes_[0-9]+_" + list.for + "_id"); })
		);*/
		$(document)
		.find('select')
		.filter(function() { 
			return this.id.match("good_uoms_attributes_[0-9]+_" + list.for + "_id");
		})
		.each (function() {
			//console.log(this);
			T.H.clearDropdown(this);
			T.H.fillupDropdown(this, list.data);
			T.validateDropdownList(this);
			$(this).trigger('change');
			// beacause of uom_helper.js to decide if enable/disable buttons
		});
	},

	validateDropdownList: function(dropdown_elem) {
		var valid = false;
		var opts = $(dropdown_elem).children('option');
		this.H.decideEnable(dropdown_elem, opts);
		valid = this.H.decideValid(dropdown_elem);
		return valid;
		/*if (opts.length == 1) {
			//logger("1");
			if (opts.first().val() != "") {
				// if only option is not blank text informing that nothing to do
			} else {
				$(dropdown_elem).attr('disabled', false);
			}

		} else if (opts.length > 1) {

		}*/
	},

}
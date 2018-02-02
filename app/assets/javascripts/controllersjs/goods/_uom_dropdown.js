function UomDropdown() {
	this.H = new UomDropdownHelper();
	this.init();
}

UomDropdown.prototype = {
	constructor: UomDropdown,

	init: function() {

	},

	recollectAvailOptionsForDropdowns: function() {
		// collects (choosen) data from good's client and manufacturer lists 
		var T = this;
		$(document)
		.find('article.impexpcompany_select, article.manufacturer_select')
		.find('input[type=checkbox]')
		.on('change', this, function(){ 
			// actions on change selections in impexpcompany/manufacturer section
			// that uom(s) are affected by 
			list = new OptionsList();
			list.for = $(this).closest('article').attr('id').match(/^[a-z]+/)[0];
			$(this).closest('tbody').find("input:checked").each(function() {
				list.data.push({ 
					id: $(this).val(),
					text: $(document).find('label[for=' + $(this).attr('id') +']').text()
				});
			});
			T.updateDropdownLists(list);
			// run dropdowns update with collected data
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
			T.H.clearDropdown(this, list);
			T.H.fillupDropdown(this, list.data);
			T.H.decideEnable(this);
			$(this).trigger('change');
			// beacause of uom_helper.js to decide if enable/disable buttons
		});
	}

}
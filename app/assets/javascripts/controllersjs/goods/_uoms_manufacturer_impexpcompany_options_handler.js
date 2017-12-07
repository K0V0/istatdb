// new, edit

function uomsManufacturerImpexpcompanyOptionsHandler(elem) {
	this.elem_name = elem + '_select';
	this.HELPER;
	this.DROPDOWNS;
	this.selected_data = [];

	this.init();
}

uomsManufacturerImpexpcompanyOptionsHandler.prototype = {
	constructor: uomsManufacturerImpexpcompanyOptionsHandler,

	init: function() {
		var TOTOK = this;

		this.HELPER = new uomsManufacturerImpexpcompanyOptionsHandler_helper(this.elem_name);
		this.DROPDOWNS = new uomsManufacturerImpexpcompanyOptionsDropdowns(this.elem_name);

		$(document).on('change', '#' + this.elem_name + ' > div > table > tbody > tr > td > input', function() {
			TOTOK.reload();
		});
	},

	reload: function() {
		this.selected_data = this.HELPER.getData();
		this.DROPDOWNS.reload(this.selected_data);
	}
}



function uomsManufacturerImpexpcompanyOptionsHandler_helper(elem) {
	this.elem_name = elem;
	this.selected_checkboxes;
}

uomsManufacturerImpexpcompanyOptionsHandler_helper.prototype = {
	constructor: uomsManufacturerImpexpcompanyOptionsHandler_helper,

	init: function() {

	},

	getData: function(){
		this.selected_checkboxes = $('#' + this.elem_name).find('table').find('input[type=checkbox]').filter(':checked');
		var data = [];
		this.selected_checkboxes.each(function() {
			var val = $(this).val();
			var text = $(this).parent().siblings().children('label').text();
			data.push({ value: val, text: text });
		});
		return data
	}
}
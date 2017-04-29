function uomsManufacturerImpexpcompanyOptionsDropdowns(elem) {
	this.elem_name = elem;
	this.default_text_nothing_to_select = "";
	this.HELPER;
	this.SELECTS = [];
	this.data = [];
	this.old_data_vals = [];
	this.initial_data_vals = [];

	this.init();
}

uomsManufacturerImpexpcompanyOptionsDropdowns.prototype = {
	constructor: uomsManufacturerImpexpcompanyOptionsDropdowns,

	init: function() {
		// should run only when page with forms is loaded
		this.HELPER = new uomsManufacturerImpexpcompanyOptionsDropdowns_helper(this);
		// in update form should different method to get this text must be invented
		this.getSelects();
		this.default_text_nothing_to_select = this.SELECTS.first().text();
		this.initial_data_vals = this.HELPER.getOldData();
	},

	reload: function(vals) {
		this.getSelects();
		//this.SELECTS = $(document).find('div.uoms_' + this.elem_name).children('select')/*.first()*/;
		this.old_data_vals = this.HELPER.getOldData();
		this.data = vals;
		console.log(this.data);
	},

	rerender: function() {

	}, 

	getSelects: function() {
		this.SELECTS = $(document).find('div.uoms_' + this.elem_name).children('select')/*.first()*/;
	}
}



function uomsManufacturerImpexpcompanyOptionsDropdowns_helper(parent_reference) {
	this.MAINCLASS = parent_reference;
}

uomsManufacturerImpexpcompanyOptionsDropdowns_helper.prototype = {
	constructor: uomsManufacturerImpexpcompanyOptionsDropdowns_helper,

	getOldData: function() {
		var result = [];
		this.MAINCLASS.SELECTS.each(function() {
			var key = $(this).attr('id');
			result[key] = [];
			$(this).find('option').each(function() {
				result[key].push($(this).val());
			});
		});
		return result;
	}
}
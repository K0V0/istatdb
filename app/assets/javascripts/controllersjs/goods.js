function GOODS() {
	this.uoms_calculator;
	this.search_mode_change;
	this.search_item_actions;
	//this.uoms;
}

GOODS.prototype = {
	constructor: GOODS,
		
	_index_search_show_administrative_end_administrative: {
		search_item_actions: ["on_ready"],
		search_mode_change: ["on_reload"]
	},

	show: {
		uoms_calculator: ["once"]
	},

	_new_edit: {
		//uoms: ["on_reload"]
	}
}


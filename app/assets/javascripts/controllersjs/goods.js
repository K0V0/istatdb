function GOODS() {
	this.uoms_calculator;
	this.search_mode_change;
	this.search_item_actions;
	//this.uoms;
}

GOODS.prototype = {
	constructor: GOODS,
		
	//_index_search_show_administrative_end_administrative_on_ready: function() {
		//this.search_item_actions = new SearchItemActions();
		//this.search_item_actions.init();
	//},

	_index_search_show_administrative_end_administrative: {
		//this.search_item_actions = new SearchItemActions();
		//this.search_item_actions.init();
		search_item_actions: ["on_ready"],
		search_mode_change: ["on_reload"]
	},

	_index_search_show_administrative_end_administrative_on_reload: function() {
		this.search_mode_change = new SearchModeChange();
	},

	show_once: function() {
		this.uoms_calculator = new UomsCalculator();
	},

	_new_edit_on_reload: function() {
		//this.uoms = new uoms();
	}
}


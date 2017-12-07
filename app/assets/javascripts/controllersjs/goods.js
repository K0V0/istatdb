function GOODS() {
	this.uoms_calculator;
	this.search_mode_change;
	//this.uoms;
}

GOODS.prototype = {
	constructor: GOODS,
		
	_index_search_show_administrative_end_administrative_on_ready: function() {
		this.search = new searchItemActions();
	},

	_index_search_show_administrative_end_administrative_on_reload: function() {
		this.search_mode_change = new searchModeChange();
	},

	show_once: function() {
		this.uoms_calculator = new UomsCalculator();
	},

	_new_edit_on_reload: function() {
		//this.uoms = new uoms();
	}
}


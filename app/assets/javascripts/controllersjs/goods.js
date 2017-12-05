function GOODS() {
	this.uoms_calculator;
	this.search_mode_change;
}

GOODS.prototype = {
	constructor: GOODS,

	_index_search_show_administrative_end_administrative_on_reload: function() {
		this.search_mode_change = new searchModeChange();
	},

	show_once: function() {
		this.uoms_calculator = new UomsCalculator();
	}
}

/*
function GOODS_onexclusive() {

	var UOMS = new uoms();

	var QUERY_TARICLIST = new generateSearchQueryForSelectForm ('local_taric', { kncode: 'start', description: 'cont' });

	var QUERY_MANUFACTURERSLIST = new generateSearchQueryForSelectForm ('manufacturer', { name: 'cont' });

	var QUERY_IMPEXPCOMPANIESLIST = new generateSearchQueryForSelectForm ('impexpcompany', { company_name: 'cont' });
}
*/


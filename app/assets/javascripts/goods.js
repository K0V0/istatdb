function GOODS_onready() {

	var SEARCH = new searchItemActions();
	
	var GOOGLE_SEARCH = new searchSearchedItemOnGoogle('search_good_on_google', 'q_ident_or_description_cont');

	var UOMS_CALCULATOR = new UomsCalculator();
	
	var SEARCH_MODE = new searchModeChange();
}

function GOODS_onexclusive() {

	var UOMS = new uoms();

	var QUERY_TARICLIST = new generateSearchQueryForSelectForm ('local_taric', { kncode: 'start', description: 'cont' });

	var QUERY_MANUFACTURERSLIST = new generateSearchQueryForSelectForm ('manufacturer', { name: 'cont' });

	var QUERY_IMPEXPCOMPANIESLIST = new generateSearchQueryForSelectForm ('impexpcompany', { company_name: 'cont' });
}

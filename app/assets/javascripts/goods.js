function GOODS_onready() {

	var SEARCH = new searchItemActions();
	
	var UOMS = new uoms();

	var GOOGLE_SEARCH = new searchSearchedItemOnGoogle('search_good_on_google', 'q_ident_or_description_cont');

	var QUERY_TARICLIST = new generateSearchQueryForSelectForm ('local_taric', { kncode: 'start', description: 'cont' });

	var QUERY_MANUFACTURERSLIST = new generateSearchQueryForSelectForm ('manufacturer', { name: 'cont' });

	var QUERY_IMPEXPCOMPANIESLIST = new generateSearchQueryForSelectForm ('impexpcompany', { company_name: 'cont' });

	var UOMS_CALCULATOR = new UomsCalculator();
	
	// index/search action - checkbox button to enable/disable second searchfield
	$(document).on('click', 'input#q_search_both', function() {
		var chkd = $(this).is(':checked');
		if (chkd) {
			$('#q_description_cont').removeAttr('disabled');
			$('#q_description_cont').siblings('label').removeClass('disabled');
			$('#q_ident_or_description_cont').attr('name', 'q[ident_cont]');
		} else {
			$('#q_description_cont').attr('disabled', 'disabled');
			$('#q_description_cont').siblings('label').addClass('disabled');
			$('#q_ident_or_description_cont').attr('name', 'q[ident_or_description_cont]');
		}
	});

}

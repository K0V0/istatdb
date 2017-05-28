function GOODS_onready() {

	var SEARCH = new searchItemActions();
	
	var UOMS = new uoms();

	var GOOGLE_SEARCH = new searchSearchedItemOnGoogle('search_good_on_google', 'q_ident_or_description_cont');

	var QUERY_TARICLIST = new generateSearchQueryForSelectForm ('local_taric', { kncode: 'start', description: 'cont' });

	var QUERY_MANUFACTURERSLIST = new generateSearchQueryForSelectForm ('manufacturer', { name: 'cont' });

	var QUERY_IMPEXPCOMPANIESLIST = new generateSearchQueryForSelectForm ('impexpcompany', { company_name: 'cont' });
	
	// show action - select uom type for uoms calculator
	$(document).on('click', '.good_manufacturer_uoms_list tr', function() {
		$(this).siblings().removeClass('selected');
		$(this).addClass('selected');
		UOMS_CALCULATOR.setVals(
			parseFloat($(this).children('td.good_manufacturer_uoms_list_val').first().text()),
			parseFloat($(this).children('td.good_manufacturer_uoms_list_multiplier').first().text()),
			$(this).children('td.good_manufacturer_uoms_list_type').first().text()
		);
	});

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

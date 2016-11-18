
$(document).ready(function() { 

	// goods section - search 
	$(document).on('input', "#good_search", function(e) {
		GOODS_ACTIONS.preserve_checked();
	    $("#good_search").submit();
	});

	// clear button
	$(document).on('click', "#clear_search", function(e) {
		$('#good_search').find('input[type=search]').val('');
	});

	// adding new good page - searching help tables for fast picking up criterium if exist 
	searchQuery(
		'/goodsdb/new/knnumber_search',
		{ 
			good_local_taric_kncode: "kncode_start",
			good_local_taric_description: "description_cont"
		}
	);

	searchQuery(
		'/goodsdb/new/client_search',
		{ 
			good_impexpcompany_company_name: "company_name_cont"
		}
	);

	searchQuery(
		'/goodsdb/new/manufacturer_search',
		{ 
			good_manufacturer_name: "name_cont"
		}
	);

	// handling select and deselect all option
	GOODS_ACTIONS = new ActionsHandler('goods');
});

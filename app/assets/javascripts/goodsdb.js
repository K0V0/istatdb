$(document).on('turbolinks:load', function() {

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
});

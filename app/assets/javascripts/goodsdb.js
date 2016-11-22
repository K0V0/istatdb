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

	searchQuery(
		'/goodsdb/new/edit_client_search',
		{ 
			edit_good_impexpcompany_company_name: "company_name_cont"
		},
		{
			good_id: $('#good_id').val()
		}
	);
/*
	searchQuery(
		'/manufacturersdb/new/maufacturer_search_making',
		{ 
			edit_good_manufacturer_name: "name_cont"
		},
		{
			manufacturer_id: $('#manufacturer_id').val()
		}
	);

	searchQuery(
		'/manufacturersdb/new/manufacturer_search_other',
		{ 
			edit_good_manufacturer_name: "name_cont"
		},
		{
			manufacturer_id: $('#manufacturer_id').val()
		}
	);
*/
});

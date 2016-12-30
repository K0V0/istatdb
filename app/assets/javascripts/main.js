var mainHandler = function() {

	ACTIONS = new ActionsHandler($('section.items_table').find('table').attr('id'));

	searchQuery(
		'/api/knnumber_search',
		{ 
			local_taric_kncode: "kncode_start",
			local_taric_description: "description_cont"
		},
		{
			cols_highlighted: {
				kncode: "kncode",
				description: "description"
			}
		}		
	);

	searchQuery(
		'/api/client_search',
		{ 
			impexpcompany_company_name: "company_name_cont"
		},
		{
			cols_highlighted: {
				company_name: "company_name"
			}
		}
	);

	searchQuery(
		'/api/manufacturer_search',
		{ 
			manufacturer_name: "name_cont"
		},
		{
			cols_highlighted: {
				name: "name"
			}
		}
	);
};

$(document).ready(function() { mainHandler(); });
$(document).on("page:load", mainHandler());
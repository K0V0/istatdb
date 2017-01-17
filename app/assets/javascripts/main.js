var ACTIONS_INDEX;

var mainHandler = function() {
	console.log("page full reload");

	ACTIONS_INDEX = new ActionsHandler();

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

var reloadHandler = function() {
	console.log("page changed (turbolinks reload)");

	ACTIONS_INDEX.reinit();
	searchIfExists();
}

var bothHandler = function() {

}

$(document).ready(function() { mainHandler(); bothHandler(); });

$(document).on("turbolinks:load", function() { reloadHandler(); bothHandler(); } );
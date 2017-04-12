var ACTIONS_INDEX;
var UOMS_CALCULATOR;
var CLIPBOARD;

var mainHandler = function() {
	console.log("page full reload");

	ACTIONS_INDEX = new ActionsHandler();

	UOMS_CALCULATOR = new UomsCalculator();

	// opens new tab passing searched item to google search
	$(document).on('click', '#search_good_on_google', function() {
		var q = $('#q_ident_or_description_cont').val();
		window.open('http://google.com/search?q=' + q);
	});

	// handlers for search-select windows in new/edit sections
	// for local taric 
	searchQuery(
		'/local_taric/new_select_search',
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
/*
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
	*/
};

var reloadHandler = function() {
	console.log("page changed (turbolinks reload)");

	CLIPBOARD = new Clipboard('.copy_to_clipboard');
	//console.log(CLIPBOARD);

	ACTIONS_INDEX.reinit();
	searchIfExists();
}

var bothHandler = function() {

}

$(document).ready(function() { mainHandler(); bothHandler(); });

$(document).on("turbolinks:load", function() { reloadHandler(); bothHandler(); } );
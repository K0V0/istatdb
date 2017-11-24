/*function ALL_CONTROLLERS_after_onready() {

	$(document).find('.allow_add_new').rememberUserManipulation();

	hoverSubmenu();

	hideMenuByOutclickSmallscreen();
	
}*/

function ALL() {
	logger("ALL controllers JS instantiated");
}

ALL.prototype = {
	constructor: ALL,

	all_on_ready: function() {

		// synchronise main top menu active tab and submenu ribbon color on hover
		hoverSubmenu();
		// automatically submit search while typing with delay 
		// when stop typing to prevent too many requests
		var search = new searchItemActions();

		var search_google = new searchSearchedItemOnGoogle();
	},

	index: function() {

	}
}
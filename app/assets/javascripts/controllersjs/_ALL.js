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

	all: function() {

		hoverSubmenu();
		
	},

	index: function() {

	}
}
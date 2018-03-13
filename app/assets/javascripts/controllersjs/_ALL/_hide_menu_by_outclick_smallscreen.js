function HideMenuByOutclickSmallscreen() {

	this.init();
}

HideMenuByOutclickSmallscreen.prototype = {
	constructor: HideMenuByOutclickSmallscreen,

	init: function() {
		$(document).on('click', 'main', function() {
			$(document).find('#show_topmenu, #show_paginator')
				.attr('checked', false);
		});
	}
}

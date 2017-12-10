function HideMenuByOutclickSmallscreen() {

	this.init();
}

HideMenuByOutclickSmallscreen.prototype = {
	constructor: HideMenuByOutclickSmallscreen,

	init: function() {
		$(document).find('main').on('click', function() {
			$(document).find('#show_topmenu, #show_paginator')
				.attr('checked', false);
		});
	}
}
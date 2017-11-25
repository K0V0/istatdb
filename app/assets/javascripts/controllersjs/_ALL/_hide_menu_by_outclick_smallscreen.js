function hideMenuByOutclickSmallscreen() {

	this.init();
}

hideMenuByOutclickSmallscreen.prototype = {
	constructor: hideMenuByOutclickSmallscreen,

	init: function() {
		$(document).find('main').on('click', function() {
			$('#show_topmenu, #show_paginator')
				.attr('checked', false);
		});
	}
}
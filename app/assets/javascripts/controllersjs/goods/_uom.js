function Uom() {

}

Uom.prototype = {
	constructor: Uom,

	init: function() {

	},

	attachEvents: function() {
		$('article.impexpcompany_select, article.manufacturer_select')
		.find('input[type=checkbox]');
	}

}
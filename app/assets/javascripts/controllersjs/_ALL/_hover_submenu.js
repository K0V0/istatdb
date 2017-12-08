function HoverSubmenu() {
	this.elems;
	this.init();
}

HoverSubmenu.prototype = {
	constructor: HoverSubmenu,

	init: function() {

		this.elems = 
			'body > nav > div#top_menu_container > div.sub,' +
			'body > nav > div#top_menu_container > div.main > ul.top_menu.main.has_submenu > li > a.active';

		var elems = this.elems;
		$(document).on('mouseenter', this.elems, function() {
			$(elems).css('background-color', '#AAA');
		})
		.on('mouseleave', this.elems, function() {
			$(elems).css('background-color', '#BBB');
		});
	}
}
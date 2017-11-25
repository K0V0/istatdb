function hoverSubmenu() {
	this.elems;
	this.init();
}

hoverSubmenu.prototype = {
	constructor: hoverSubmenu,

	init: function() {

		this.elems = $(document).find(
			'nav > div#top_menu_container > div.sub,' +
			'nav > div#top_menu_container > div.main > ul.top_menu.main.has_submenu > li > a.active'
		);

		var elems = this.elems;

		this.elems
			.mouseenter(function() {
				elems.css('background-color', '#AAA');
			})
			.mouseleave(function() {
				elems.css('background-color', '#BBB');
			});

	}
}
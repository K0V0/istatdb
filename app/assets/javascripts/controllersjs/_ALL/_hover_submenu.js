function HoverSubmenu() {
	this.class_name;
	//this.elems;
	this.init();
}

HoverSubmenu.prototype = {
	constructor: HoverSubmenu,

	init: function() {
		var T = this;
		// on menu item actions
		$(document)
		.find('nav.top_menu')
		.on('mouseenter', 'ul.main > div > li.has_submenu', function() {
			T.class_name = $(this).attr('class').match(/([a-z]+)$/)[0];
			T.show_submenu();
		})
		.on('mouseleave', 'ul.main > div > li.has_submenu', function() {

		});
		// on submenu actions
		$(document)
		.find('nav.top_menu')
		.on('mouseenter', 'ul.sub', function() {
			//T.class_name = $(this).attr('class').match(/([a-z]+)$/)[0];
			//T.show_submenu();
			logger('mouseenter on sub');
			if ($(this).attr('class').indexOf(this.class_name) != -1) {
				logger('is inside submenu for previously hovered main menu item');
			}
		})
		.on('mouseleave', 'ul.sub', function() {

		});
	},

	show_submenu: function() {
		var sub_menus = $(document).find('nav.top_menu').children('ul.sub');
		sub_menus.addClass('novisible');
		sub_menus.filter('.'+this.class_name).removeClass('novisible');
	},

	hide_submenu: function() {
		//var sub_menus = $(document).find('nav.top_menu').children('ul.sub');
		//sub_menus.addClass('novisible');
	}

}

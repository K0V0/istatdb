function HoverSubmenu() {
	this.class_name;
	this.timer;
	this.init();
}

HoverSubmenu.prototype = {
	constructor: HoverSubmenu,

	init: function() {
		var T = this;
		// on menu item actions
		$(document)
		.find('nav.top_menu > ul.main > div > li')
		.betterMouseover(400, function() {
			if ($(this).hasClass('has_submenu')) {
				T.show_submenu(this);
			} else {
				T.hide_submenus();
			}
		});
		// on submenu actions
		$(document)
		.find('nav.top_menu')
		.on('mouseenter', 'ul.sub', function() {
			clearTimeout(T.timer);
		})
		.on('mouseleave', 'ul.sub', function() {
			logger("mouselevae happend")
			T.timer = setTimeout(function() {
				var active_elem = $(document).find('nav.top_menu').children('ul.main').find('li.active');
				if (!active_elem.hasClass(T.class_name)) {
					if (active_elem.hasClass('has_submenu')) {
						T.show_submenu(active_elem);
					} else {
						T.hide_submenus();
					}
				}
			}, 500)
		});
	},

	show_submenu: function(ref) {
		clearTimeout(this.timer);
		this.class_name = this.getClassName(ref);
		$(ref).siblings().removeClass('hover');
		$(ref).prependClass('hover');
		var sub_menus = $(document).find('nav.top_menu').children('ul.sub');
		sub_menus.filter('.'+this.class_name).removeClass('novisible');
		sub_menus.not('.'+this.class_name).addClass('novisible');
	},

	hide_submenus: function() {
		$(document).find('nav.top_menu').children('ul.sub').addClass('novisible');
		$(document).find('nav.top_menu > ul.main > div > li').removeClass('hover');
	},

	getClassName: function(ref) {
		return $(ref).attr('class').match(/([a-z]+)$/)[0];
	}

}

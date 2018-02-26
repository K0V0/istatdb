function HoverSubmenu() {
	this.class_name;
	this.timer;
	this.timer2;
	this.init();
}

HoverSubmenu.prototype = {
	constructor: HoverSubmenu,

	init: function() {
		var T = this;
		// on menu item actions
		$(document)
			.find('nav.top_menu > ul.main > div > li.has_submenu')
			.betterMouseover(400, function() {
				if (!$(this).hasClass('active')) {
					T.show_submenu(this);
				}
			});
		$(document)
			.find('nav.top_menu > ul.main > div > li')
			.not('.has_submenu')
			.betterMouseover(400, function() {
				//if (!$(this).hasClass('active')) {
					T.hide_submenus();
				//}
			});
		// on submenu actions
		$(document)
			.find('nav.top_menu')
			.on('mouseenter', 'ul.sub', function() {
				clearTimeout(T.timer);
			})
			.on('mouseleave', 'ul.sub', function() {
				T.timer = setTimeout(function() {
					var active_elem = $(document).find('nav.top_menu').children('ul.main').find('li.active');
					if (!active_elem.hasClass(T.class_name)) {
						if (active_elem.hasClass('has_submenu')) {
							T.show_submenu(active_elem);
						} else {
							T.hide_submenus();
						}
					}
				}, 500);
			});
		// hover active fix
		$(document)
			.on('mouseenter', 'nav.top_menu > ul.sub.active, nav.top_menu > ul.main > div > li.active', function(e) {
				$(document).find(e.handleObj.selector).prependClass('hover');
				clearTimeout(T.timer2);
			})
			.on('mouseleave', 'nav.top_menu > ul.sub.active, nav.top_menu > ul.main > div > li.active', function(e) {
				T.timer2 = setTimeout(function() {
					$(document).find(e.handleObj.selector).removeClass('hover');
				}, 500);
			});
	},

	show_submenu: function(ref) {
		clearTimeout(this.timer);
		this.class_name = this.getClassName(ref);
		$(ref).siblings().removeClass('hover');
		if (!$(ref).hasClass('active')) {
			$(ref).prependClass('hover');
		}
		var sub_menus = $(document).find('nav.top_menu').children('ul.sub');
		sub_menus.filter('.'+this.class_name).removeClass('novisible');
		sub_menus.not('.'+this.class_name).prependClass('novisible');
	},

	hide_submenus: function() {
		var submenu = $(document).find('nav.top_menu').children('ul.sub');
		submenu.each(function() {
			if (!$(this).hasClass('active')) {
				$(this).addClass('novisible');
				$(document).find('nav.top_menu > ul.main > div > li').removeClass('hover');
			}
		})

	},

	getClassName: function(ref) {
		return $(ref).attr('class').match(/([a-z]+)$/)[0];
	}

}

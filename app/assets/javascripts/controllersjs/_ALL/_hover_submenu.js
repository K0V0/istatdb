function HoverSubmenu() {
	this.init();
}

HoverSubmenu.prototype = {
	constructor: HoverSubmenu,

	init: function() {
		var T = this;
		// handle behaviour baased on main menu
		$(document)
		.preventAccidentTrigger('mouseenter',
			'nav.top_menu > ul.main > div > li',
			350,
			function() { T.decideAction(this); }
		);
		// handle leave menu at all
		$(document).on('mouseleave', 'nav.top_menu', function() {
			T.hideSubmenus();
		});
		// item with active submenu cosmetic fix
		$(document)
		.on('mouseenter',
			'nav.top_menu > ul.main > div > li.active, nav.top_menu > ul.sub',
			function(e) {
				$(document).find(e.handleObj.selector).prependClass('hover');
			}
		)
		.on('mouseleave',
			'nav.top_menu > ul.main > div > li.active, nav.top_menu > ul.sub',
			function(e) {
				$(document).find(e.handleObj.selector).removeClass('hover');
			}
		);
	},

	decideAction: function(ref) {
		if ($(ref).hasClass('has_submenu')) {
			if ($(ref).hasClass('active')) {
				this.hideSubmenus();
			} else {
				this.showSubmenu(ref);
			}
		} else {
			this.hideSubmenus();
		}
	},

	showSubmenu: function(trigger_elem) {
		var submenus = $(document).find('nav.top_menu').children('ul.sub');
		var submenu = $(document)
			.find('nav.top_menu > ul.sub.'+ this.getClassName(trigger_elem));

		submenus.prependClass('novisible');
		trigger_elem.siblings().removeClass('hover');

		submenu.removeClass('novisible');
		trigger_elem.prependClass('hover');
	},

	hideSubmenus: function() {
		$(document)
			.find('nav.top_menu')
			.children('ul.sub')
			.not('.active')
			.prependClass('novisible');
		$(document)
			.find('nav.top_menu')
			.children('ul.sub.active')
			.removeClass('novisible');
		$(document)
			.find('nav.top_menu > ul.main > div > li')
			.removeClass('hover');
	},

	getClassName: function(ref) {
		// class name pairing with main menu item name is always on end
		return $(ref).attr('class').match(/([a-z]+)$/)[0];
	}
}

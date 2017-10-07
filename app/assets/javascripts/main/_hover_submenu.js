function hoverSubmenu() {
	
	var elems = $(document).find('nav.top_menu.sub, nav.top_menu.main > ul > li > a.active');

	elems
		.mouseenter(function() {
			elems.css('background-color', '#CCC');
		})
		.mouseleave(function() {
			elems.css('background-color', '#BBB');
		});

}
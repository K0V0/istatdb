function hoverSubmenu() {
	
	var elems = $(document).find(
		'nav > div.sub,' +
		'nav > div > ul.top_menu.main > li > a.active'
	);

	elems
		.mouseenter(function() {
			elems.css('background-color', '#AAA');
		})
		.mouseleave(function() {
			elems.css('background-color', '#BBB');
		});
		
}
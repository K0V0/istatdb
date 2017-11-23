function hoverSubmenu() {
	
	var elems = $(document).find(
		'nav > div#top_menu_container > div.sub,' +
		'nav > div#top_menu_container > div.main > ul.top_menu.main.has_submenu > li > a.active'
	);

	elems
		.mouseenter(function() {
			console.log("mouseenter");
			elems.css('background-color', '#AAA');
		})
		.mouseleave(function() {
			elems.css('background-color', '#BBB');
		});
		
}
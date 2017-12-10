
function ALL() {
	this.hover_submenu;
	this.hide_menu_by_outclick_smallscreen;
}

ALL.prototype = {
	constructor: ALL,

	_ALL: {
		hover_submenu: ['on_ready'],
		hide_menu_by_outclick_smallscreen: ['on_ready', 'on_reload']
	}

}
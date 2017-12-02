
function ALL() {
	this.hover_submenu;
	this.search;
	this.focus_trigger;
	this.hide_menu_on_outclick;
}

ALL.prototype = {
	constructor: ALL,

	_all_on_ready: function() {
		// synchronise main top menu active tab and submenu ribbon color on hover
		this.hover_submenu = new hoverSubmenu();
		// when on small screen, rolls back menu on click out of menu
		this.hide_menu_on_outclick = new hideMenuByOutclickSmallscreen();
	},

	_index_search_show_on_ready: function() {
		// automatically submit search while typing with delay 
		// when stop typing to prevent too many requests
		this.search = new searchItemActions();
		// set focus to default search input when switching section(s)
		this.focus_trigger = new triggerFocusOnSearchfield();
	},

	_index_search_show_on_reload: function() {
		this.focus_trigger.init();
	},

	_index_search_show_on_change: function() {
		this.focus_trigger.init();
	},

	_index_search_show_on_resize: function() {
		this.focus_trigger.init();
	}
}
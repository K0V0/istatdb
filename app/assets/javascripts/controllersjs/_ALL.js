
function ALL() {
	logger("ALL controllers JS instantiated");

	this.hover_submenu;
	this.search;
	this.focus_trigger;
}

ALL.prototype = {
	constructor: ALL,

	all_on_ready: function() {
		// synchronise main top menu active tab and submenu ribbon color on hover
		this.hover_submenu = new hoverSubmenu();
		// automatically submit search while typing with delay 
		// when stop typing to prevent too many requests
		this.search = new searchItemActions();
		// set focus to default search input when switching section(s)
		this.focus_trigger = new triggerFocusOnSearchfield();
	},

	all: function() {
		this.focus_trigger.init();
		this.hover_submenu.init();
	},

	all_on_resize: function() {
		this.focus_trigger.init();
	}
}
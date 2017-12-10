function TriggerFocusOnSearchfield() {
	this.bigscreen_mode;
	this.focus_parent;
	this.p;

	this.init();
}

TriggerFocusOnSearchfield.prototype = {
	constructor: TriggerFocusOnSearchfield,

	init: function() {
		this.p = $(document).find('section.search_bar > form').first();
		this.detectMode();
		this.triggerFocus();
	},

	detectMode: function() {
		this.bigscreen_mode = ($('.disable_on_bigscreen').css('display') == 'none');
	},

	triggerFocus: function() {
		if (this.bigscreen_mode === true) {
			this.focus_parent = this.p.children('div.searchform_fulscreen_fields').children('div.disable_on_smallscreen');
		} else {
			this.focus_parent = this.p.children('div.disable_on_bigscreen');
		}
		this.focus_parent.find('input[autofocus=autofocus]').first().trigger('focus');
	}
}
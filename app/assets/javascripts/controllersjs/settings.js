function SETTINGS() {
	this.settings_change_submit;
}

SETTINGS.prototype = {
	constructor: SETTINGS,

	index_once: function() {
		this.settings_change_submit = new submitSettingsOnChange();
	}
}
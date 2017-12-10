function SubmitSettingsOnChange() {
	this.init();
}

SubmitSettingsOnChange.prototype = {
	constructor: SubmitSettingsOnChange,

	init: function() {

		$(document).on('change', 'input.settings, select.settings', function() {
			$(document).find('article.settings > form').submit();
		});
	}
}
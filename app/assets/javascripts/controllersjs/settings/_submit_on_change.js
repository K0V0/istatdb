function submitSettingsOnChange() {
	this.init();
}

submitSettingsOnChange.prototype = {
	constructor: submitSettingsOnChange,

	init: function() {

		$(document).on('change', 'input.settings, select.settings', function() {
			$(document).find('article.settings > form').submit();
		});
	}
}
function submitOnChange() {
	this.init();
}

submitOnChange.prototype = {
	constructor: submitOnChange,

	init: function() {

		$(document).on('change', 'input.settings, select.settings', function() {
			$(document).find('article.settings > form').submit();
		});
	}
}

(function($) {
	$.fn.stripTagsInside = function () {

		return this.each(function() {
			var text = $(this).text();
			$(this).children().remove();
			$(this).text(text);
		});
	}
}(jQuery));
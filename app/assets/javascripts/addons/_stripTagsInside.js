
(function($) {
	$.fn.stripTagsInside = function () {

		return this.each(function() {
			var text = $(this).text();
			$(this).children().remove();
			$(this).text(text);
		});
	}
}(jQuery));

/*
// just escapes tags
var container = document.createElement('div');
var text = document.createTextNode($(this).html());
container.appendChild(text);
logger(container.innerHTML);
*/
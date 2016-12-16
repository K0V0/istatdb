(function($) {

	$.fn.fixHeader = function () {

		this.each(function() {
			var thead_ths = $(this).children("thead").children("tr").children('th');
			var total_width = $(this).children("tbody").children("tr").width();

			$(this).children("tbody").children("tr").first().children("td")
			.each(function(index) {
				var width = ($(this).width() / total_width) * 100;
				console.log(width);
				$(thead_ths[index]).css('width',width+'%');
			});
		});
	}
}(jQuery));
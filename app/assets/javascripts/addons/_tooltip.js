(function($) {
	$.fn.tooltip = function (show) {

		return this.each(function(e) {
			if (show === false) {
				$(this).children("sup").css("display", "none");
			} else {
				var ww = $(window).width();
				var t = $(this).children("sup");
				var w = t.width();
				var o = $(this).offset().left;
				t.css("display", "block");
				var pos = ((ww-o) > w) ? "left" : "right"
				t.css(pos, "0");
			}
		});
	}
}(jQuery));
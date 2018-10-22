(function($) {
	$.fn.tooltip = function (show) {

		return this.each(function(e) {
			if (show === false) {
				$(this).children("sup")
					.css("display", "none")
					.css("top", "")
					.css("bottom", "")
					.css("left", "")
					.css("right", "");
			} else {
				var ww = $(window).width();
				var t = $(this).children("sup");
				var w = t.width();
				var h = t.height();
				var o = $(this).offset().left;
				var o_top = $(this).offset().top;
				var o_top_table = $(this).closest('table.items, div.content').offset().top;
				t.css("display", "block");
				var pos = ((ww-o) > w) ? "left" : "right"
				t.css(pos, "0");
				var pos_h = ((o_top-o_top_table) < (h+24)) ? "top" : "bottom";
				t.css(pos_h, "100%");
			}
		});
	}
}(jQuery));
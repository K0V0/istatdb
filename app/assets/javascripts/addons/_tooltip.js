(function($) {
	$.fn.tooltip = function (show) {
		var t = $('span#tooltip');
		var gap = 16;

		return this.each(function(e) {
			if (show === false) {
					t.css({"opacity":"0", "top":"-100%", "left":"", "right":""}).text("");
			} else {
				var txt = $(this).children("sup").text();
				t.text(txt);
				var ex = $(this).offset().top; // vertikal
				var ey = $(this).offset().left;// horizontal
				var ew = $(this).outerWidth();
				var eh = $(this).outerHeight();
				var ww = $(window).width();
				var tw = t.outerWidth();
				var th = t.outerHeight();
				var hpos = 0; 
				var vpos = 0;

				if (ey+tw >= ww-gap) {
					var offgap = ww-(ey+ew);
					hpos = ww-offgap-gap/2-tw;
				} else {
					hpos = ey;
				}

				if (ex >= th+gap) {
					vpos = ex-th-gap/2;
				} else {
					vpos = ex+eh+th+gap/2;
				}

				t.css("left", hpos);
				t.css("top", vpos);
				t.css("opacity", "1");
			}
		});
	}
}(jQuery))
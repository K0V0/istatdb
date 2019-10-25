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
				var scr_x = $(window).scrollTop(); // kolko px zoscrolllovne
				var ew = $(this).outerWidth(); //sirka elementu ku ktoremu ma byt bublinka
				var eh = $(this).outerHeight(); // detto, vyska
				var ww = $(window).width(); // sirka priezoru
				var wh = $(window).height(); // vyska priezoru
				var tw = t.outerWidth(); // sirka bublinky
				var th = t.outerHeight(); //vyska bublinky
				var hpos = 0; 
				var vpos = 0;

				if (ey+tw >= ww-gap) {
					var offgap = ww-(ey+ew);
					hpos = ww-offgap-gap/2-tw;
				} else {
					hpos = ey;
				}

				if (ex-scr_x >= th+gap) {
					console.log(ex-scr_x);
					vpos = ex-th-scr_x-gap/2;
				} else {
					vpos = ex-scr_x+eh+gap/2;
				}

				t.css("left", hpos);
				t.css("top", vpos);
				t.css("opacity", "1");
			}
		});
	}
}(jQuery))
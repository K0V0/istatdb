
function Main() {
	this.H = new H();
	logger("", true);
}

Main.prototype = {
	constructor: Main,

	init: function() {
		var H = this.H;

		// runs when everyting on page loaded include images (first load/F5)
		$(window).on('load', function() {
			H.run('on_load');
			console.log("on load")
		});

		// runs when DOM is ready (first load/F5)
		$(document).ready(function(){
			H.run('on_ready');
			console.log("on ready")
			//H.run('once');
		});

		// runs when page changed (turbolinks reload)
		$(document).on("turbolinks:load", function() {
			H.run('on_reload');
			H.run('once');
			console.log("on reload")
		});

		// runs when page is resized (resize event ends/nothing happen for 0.5s)
		$(window).frequentFireLimit('resize', 500, this, function(e) {
			H.run('on_resize');
			console.log("on resize")
		});
	}
}

var JS;

JS = new Main();

JS.init();



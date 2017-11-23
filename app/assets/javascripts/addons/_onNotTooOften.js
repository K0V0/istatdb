(function($) {
	$.fn.onNotTooOften = function (event_type, delay, selector, callback) {

		return this.each(function() {

			var timed_object;
			$(document).on(event_type, selector, function() {
				var totok = this;
				clearTimeout(timed_object);
				timed_object = setTimeout(function() { $(totok).onNotTooOften_handler(callback); }, delay);
			});			
		});
	}
	$.fn.onNotTooOften_handler = function (h) { h.call(this); }
}(jQuery));
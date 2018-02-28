
(function($) {
	$.fn.frequentFireLimit = function (event_type, delay, selector, callback) {

		if (typeof selector == 'function') { callback = selector; }
		if (typeof callback == 'undefined') { console.log("no callback defined for frequentFireLimit()"); }

		return this.each(function() {

			var timed_object;
			$(this).on(event_type, selector, function(e) {
				var totok = this;
				clearTimeout(timed_object);
				timed_object = setTimeout(function() { $(totok).frequentFireLimit_handler(callback, e); }, delay);
			});
		});
	}

	$.fn.frequentFireLimit_handler = function (h, evt) { h.call(this, evt); }
}(jQuery));

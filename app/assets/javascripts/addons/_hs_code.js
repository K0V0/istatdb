(function($) {
	$.fn.hsCodeFormat = function () {

		return this.each(function() {

			$(this).on('input', function() {
				var tmp = $(this).val();
				$(this).val(tmp.toHsCode());
			});
		});
	}

	$.fn.frequentFireLimit_handler = function (h, evt) { h.call(this, evt); }
}(jQuery));
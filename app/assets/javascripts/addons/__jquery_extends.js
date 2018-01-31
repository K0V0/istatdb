(function($) {
	$.fn.disable = function () {

		return this.each(function() {
			this.disabled = true		
		});
	}
}(jQuery));

(function($) {
	$.fn.enable = function () {

		return this.each(function() {
			$(this).removeAttr('disabled')	
		});
	}
}(jQuery));
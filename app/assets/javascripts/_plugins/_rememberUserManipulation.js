(function($) {

	$.fn.rememberUserManipulation = function () {
		
		$(this).on('click', function() {
			var data = $(this).prop('checked');
			$(this).data('user-choosed', data);
		});
	}
}(jQuery));
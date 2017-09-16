(function($) {

	$.fn.rememberUserManipulation = function () {
		
		//return this.each(function() {
			//console.log($(this).attr('id'));
			$(this).on('click', function() {
				//console.log($(this).attr('id'));
				console.log($(this).prop('checked'));
				var data = $(this).prop('checked');
				$(this).data('user-choosed', data);
			});
			/*
			$("<input>").attr({
				type: 	'hidden',
				id: 	$(this).attr('id') + '_hidden',
				name: 	$(this).attr('name')
			})
			.val( $.trim( $(this).val() ) )
			.appendTo($(this).closest("form"));
			$(this).prop('disabled', true);
			*/
		//});
	}
}(jQuery));
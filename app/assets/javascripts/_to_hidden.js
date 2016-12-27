(function($) {

	$.fn.toHidden = function () {
		
		this.each(function() {
			$("<input>").attr({
				type: 	'hidden',
				id: 	$(this).attr('id') + '_hidden',
				name: 	$(this).attr('name')
			})
			.val( $.trim( $(this).val() ) )
			.appendTo($(this).closest("form"));
			$(this).prop('disabled', true);
		});
	}
}(jQuery));
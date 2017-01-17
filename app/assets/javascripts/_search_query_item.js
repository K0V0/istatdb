function searchIfExists() {

	var form = $('form').filter(function() {
        return this.id.match(/^new\_/);
    });

	form.on('input', "input.check_existence", function() {
		var field_name = $(this).attr('id');
		var model_name = $(this).closest("form").attr('id').replace(/^new\_/, "");
		var request_data = {};
		request_data[field_name+"_eq"] = $.trim($(this).val());
		
		$.ajax({
		  	method: "POST",
		 	url: '/api/' + model_name + '_search_' + field_name + '_exists',
		 	data: { 
		  		q: request_data
		  	}
		});
	});
}
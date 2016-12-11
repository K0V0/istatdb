// conds: { input_elem_id: ransack_cond } 
// conventions: 
	// id of input field: #input_field_name
	// id of related table with search result: #input_field_name_results
function searchQuery(path, conds, other_data) {

	var elem_string = "";
	var elem_string_table_row_onclick = "";
	var request_data = {};
	var conds_count = Object.keys(conds).length;

	var i = 0;
	for (var cond_key in conds) {
		elem_string += ('#' + cond_key);
		if (i < conds_count-1) { elem_string += ', ' } 
		i++;
	}

	$(document).on('input', elem_string, function(e) {

		$(this).removeClass('error');
		$(this).closest('article').find('div.form_errors').empty();

		var request_data = {};
		for (var cond_key in conds) {
			request_data[conds[cond_key]] = $('#'+cond_key).val();
		}

		var field = conds[Object.keys(conds)[0]].replace(/_[a-z]+$/, "");
		var model = Object.keys(conds)[0].replace("_"+field, "");

		$.ajax({
		  	method: "POST",
		 	url: path,
		  	data: { 
		  		q: request_data,
		  		model: model,
		  		other_data
		  	}
		});
	});

	var i = 0;
	for (var cond_key in conds) {
		elem_string_table_row_onclick += ('#' + cond_key + '_results > tbody > tr');
		if (i < conds_count-1) { elem_string_table_row_onclick += ', ' } 
		i++;
	}

	$(document).on('click', elem_string_table_row_onclick, function(e) {

		$(elem_string_table_row_onclick).removeClass();
		$(this).addClass('selected');
		
	    var i = 0;
	    for (var cond_key in conds) { 
	    	i++;
	    	var tmp = $.trim( $(this).children('td:nth-child('+i+')').text() );
	    	$('#'+cond_key).val(tmp);
	    }
	});
}
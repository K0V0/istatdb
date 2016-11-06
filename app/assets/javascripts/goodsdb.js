
$(document).ready(function() { 

	// goods section - search 
	$(document).on('input', "#good_search", function(e) {
	    $("#good_search").submit();
	});

	// goods section - adding new item - goods search when typing in input field
	$(document).on('input', "#good_kn_code, #good_kn_code_description", function(e) {
	    ajaxer('/goodsdb/new/knnumber_search', 
	    	{ 
    			q: 	{ 
    				kncode_start: $("#good_kn_code").val(),
    				description_cont: $("#good_kn_code_description").val()
    				} 
	    	}
	    );
	});

	$(document).on('input', "#good_client", function(e) {
	    ajaxer('/goodsdb/new/client_search', 
	    	{ 
    			q: 	{ 
    				company_name_cont: $("#good_client").val()
    				} 
	    	}
	    );
	});
	
	// goods section - adding new item - write kn code and description 
	// to input field when selected from list
	$(document).on('click', "#new_good_taric_search > tbody > tr", function(e) {
	    var kncode = $.trim( $(this).children('td:first-child').text() );
	    $("#good_kn_code").val(kncode);
	    var desc = $.trim( $(this).children('td:last-child').text() );
	    $("#good_kn_code_description").val(desc);
	});

	$(document).on('click', "#new_good_client_search > tbody > tr", function(e) {
	    var client = $.trim( $(this).children('td:first-child').text() );
	    $("#good_client").val(client);
	});


});

function ajaxer(url, data) {
	$.ajax({
	  method: "POST",
	  url: url,
	  data: data
	});
}


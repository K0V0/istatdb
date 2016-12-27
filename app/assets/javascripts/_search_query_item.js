function searchQueryItem() {
	$("form#new_good").on('input', "#ident, #description", function() {

		console.log("kokooo");
		
		$.ajax({
		  	method: "POST",
		 	url: '/api/good_search_exists',
		 	data: { 
		  		q: {
		  			//description_cont: $.trim($("#description").val()),
		  			ident_eq: $.trim($("#ident").val())
		  		}
		  		//model: model,
		  		//other_data
		  	}
		});
	});

}
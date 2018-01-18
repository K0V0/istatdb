(function($) {

	$.fn.watchSelectboxesState = function () {
		
		var elems = $(this);
		var elems_last_clicked_index;

		$(document).on('click', function(e) {

		 	if (elems_last_clicked_index === undefined) { 
		  		elems_last_clicked_index = $(e.target).index(); 
		  	}
		 	if (elems.is(e.target)) { 
		  		console.log('inside click');
			    if ($(e.target).index() == elems_last_clicked_index) {
			    	console.log('clicked same element');
			    } else {
			    	console.log('clicked element of same type but not same');
			    }
		  } else {
		  	console.log('outside click');
		  }
		  elems_last_clicked_index = $(e.target).index();
		});

		//$('select').on('mouseenter', function(){
			//console.log($(this));
		  //console.log('in');
		//})
		//.mouseleave(function(){
			//console.log('out');
		//});
	}
}(jQuery));
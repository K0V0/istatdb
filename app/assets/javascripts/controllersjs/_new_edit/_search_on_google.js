function SearchOnGoogle() {
	this.init();
}

SearchOnGoogle.prototype = {
	constructor: SearchOnGoogle,

	init: function() {

		$(document).on('click', 'button.search_item_on_google' , function() {
			var searched_term = $(this).prev('input[type=text]').val();
			window.open('http://google.com/search?q=' + searched_term);
		});
	}
}

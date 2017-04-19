function searchSearchedItemOnGoogle() {

	this.init();
}

searchSearchedItemOnGoogle.prototype = {
	constructor: searchSearchedItemOnGoogle,

	init: function() {
		// opens new tab passing searched item to google search
		$(document).on('click', '#search_good_on_google', function() {
			var q = $('#q_ident_or_description_cont').val();
			window.open('http://google.com/search?q=' + q);
		});
	}
}
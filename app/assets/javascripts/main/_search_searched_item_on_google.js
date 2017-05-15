function searchSearchedItemOnGoogle(button_id, field_id) {
	this.button_id = button_id;
	this.field_id = field_id;

	this.init();
}

searchSearchedItemOnGoogle.prototype = {
	constructor: searchSearchedItemOnGoogle,

	init: function() {
		// opens new tab passing searched item to google search
		var TOTO = this;
		$(document).on('click', '#'+TOTO.button_id , function() {
			var q = $('#'+TOTO.field_id).val();
			window.open('http://google.com/search?q=' + q);
		});
	}
}
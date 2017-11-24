function searchSearchedItemOnGoogle(button_id, field_id) {
	//this.button_id = button_id;
	//this.field_id = field_id;

	this.init();
}

searchSearchedItemOnGoogle.prototype = {
	constructor: searchSearchedItemOnGoogle,

	init: function() {
		// opens new tab passing searched item to google search
		

		//var TOTO = this;
		$(document).on('click', '#search_item_on_google' , function() {
			logger($(this).closest('form')/*.find('input[type=search]')*/.find('input[autofocus=autofocus]'));
			//var q = $('#'+TOTO.field_id).val();
			//window.open('http://google.com/search?q=' + q);
		});


		//logger($(document).find('span.searchform_inputfield_wrap').find('input:focus'));
	}

}
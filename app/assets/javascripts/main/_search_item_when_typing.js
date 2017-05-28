function searchItemActions() {

	this.init();
	this.events();
}

searchItemActions.prototype = {
	constructor: searchItemActions,

	init: function() {

	},

	events: function() {
		$(document).onNotTooOften('input', 350, "section.search_bar > form", function() {
			console.log('searched');
		  	$(this).submit();
		});

	}
}
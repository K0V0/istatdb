function searchModeChange() {
	this.checkbox = null;
	this.init();
}

searchModeChange.prototype = {
	constructor: searchModeChange,

	init: function() {
		var totok = this;
		this.checkbox = $(document).find("input#q_search_both");
		
		// changeInputProps probably here also or use mem and handle on server side
		this.checkbox.on('change', function() {
			totok.changeInputProps(this);
		});
	},

	changeInputProps: function(ref) {
		var is_checked = $(ref).is(':checked');

		if (is_checked === true) {
			$(document).find('#q_description_cont').removeAttr('disabled');
			$(document).find('label[for=q_description_cont]').removeClass('disabled');
		} else {
			$(document).find('#q_description_cont').attr('disabled', 'disabled');
			$(document).find('label[for=q_description_cont]').addClass('disabled');
		}
	}
}
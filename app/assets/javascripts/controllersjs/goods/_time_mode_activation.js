//index, search, show, administrative, end_administrative

function TimeModeActivation() {
	this.checkbox = null;
	this.init();
}

TimeModeActivation.prototype = {
	constructor: TimeModeActivation,

	init: function() {
		var totok = this;
		this.checkbox = $(document).find("input#q_search_datetime");

		this.checkbox.on('change', function() {
			totok.changeInputProps(this);
		});
	},

	changeInputProps: function(ref) {
		var is_checked = $(ref).is(':checked');

		if (is_checked === true) {
			$(document).find('span.datetime_select').children('select').removeAttr('disabled');
		} else {
			$(document).find('span.datetime_select').children('select').attr('disabled', 'disabled');
			
		}
		// to let remembered choice after page reload, do search to send required param "search_both=>1"
		// to server side
		//$(document).find("form#good_search").submit();
	}
}

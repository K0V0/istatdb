//index, search, show, administrative, end_administrative

function TimeModeActivation() {
	this.checkbox = null;
	this.mode_select = null;
	this.init();
}

TimeModeActivation.prototype = {
	constructor: TimeModeActivation,

	init: function() {
		var totok = this;
		this.checkbox = $(document).find("input#q_search_datetime");
		this.mode_select = $(document).find("select#timesort_method");

		this.checkbox.on('change', function() {
			totok.changeInputProps(this);
		});

		this.mode_select.on('change', function() {
			totok.changeFieldsSearchStrings(this);
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
	},

	changeFieldsSearchStrings: function(ref) {
		var totok = this;
		$(document).find('span.datetime_select').children('select:not(#timesort_method)').each(function() {
			var attribute = $(this).attr('name');
			var string_to_replace = attribute.match(/^q\[([a-z_]+)\(\d+i\)\]$/)[1];
			var replacement = totok.mode_select.val();
			var replaced = attribute.replace(string_to_replace, replacement);
			$(this).attr('name', replaced);
		});
	}
}

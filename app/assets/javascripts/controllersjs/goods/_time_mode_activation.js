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

		$(document).on('change', "input#q_search_datetime", function() {
			totok.changeInputProps(this);
			//$('form').submit();
		});

		$(document).on('change', "select#timesort_method", function() {
			totok.changeFieldsSearchStrings(this);
		});
	},

	changeInputProps: function(ref) {
		var is_checked = $(ref).is(':checked');
		var el = $(document).find('span.datetime_select');

		if (is_checked === true) {
			el.children('select').removeAttr('disabled');
			el.siblings('span').children('label').removeClass('disabled');
		} else {
			el.children('select').attr('disabled', 'disabled');
			el.siblings('span').children('label').addClass('disabled');
		}
		// to let remembered choice after page reload, do search to send required param "search_both=>1"
		// to server side
		//$(document).find("form#good_search").submit();
	},

	changeFieldsSearchStrings: function(ref) {
		var totok = this;
		var replacement = $(ref).val();
		$(document).find('span.datetime_select').children('select:not(#timesort_method)').each(function() {
			var attribute = $(this).attr('name');
			var string_to_replace = attribute.match(/^q\[([a-z_]+)\(\d+i\)\]$/)[1];
			var replaced = attribute.replace(string_to_replace, replacement);
			$(this).attr('name', replaced);
		});
	}
}

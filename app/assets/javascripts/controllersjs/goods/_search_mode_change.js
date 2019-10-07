//index, search, show, administrative, end_administrative

function SearchModeChange() {
	this.checkbox = null;
	this.init();
}

SearchModeChange.prototype = {
	constructor: SearchModeChange,

	init: function() {
		var totok = this;
		this.checkbox = $(document).find("input#q_search_both");

		this.checkbox.on('change', function() {
			totok.changeInputProps(this);
		});
	},

	changeInputProps: function(ref) {
		var is_checked = $(ref).is(':checked');

		if (is_checked === true) {
			$(document).find('#q_description_cont').removeAttr('disabled');
			$(document).find('label[for=q_description_cont]').removeClass('disabled');
			$(document).find('input.ident_searchfield').attr('name', 'q[ident_cont]');
			$(document).find('label#ident_searchfield_label')
				.text(t('activerecord.attributes.good.ident') +' '+ t('ransack.predicates.cont'))
				.attr('for', 'q_ident_cont');

		} else {
			$(document).find('#q_description_cont').attr('disabled', 'disabled');
			$(document).find('label[for=q_description_cont]').addClass('disabled');
			$(document).find('input.ident_searchfield').attr('name', 'q[ident_or_description_cont]');
			$(document).find('label#ident_searchfield_label')
				.text(t('activerecord.attributes.good.ident') +' '+ t('ransack.or') +' '+ t('activerecord.attributes.good.description') +' '+ t('ransack.predicates.cont'))
				.attr('for', 'q_ident_or_description_cont');
		}
		// to let remembered choice after page reload, do search to send required param "search_both=>1"
		// to server side
		//$(document).find("form#good_search").submit();
	}
}

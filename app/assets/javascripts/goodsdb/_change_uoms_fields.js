function changeUomsFieldsToMatchAssocs() {
	console.log("changeUomsFieldsToMatchAssocs()");

	this.HELPER = new changeUomsFieldsToMatchAssocs_helper();
	this.enabled_data = {};
	this.zero_text = {};
}

changeUomsFieldsToMatchAssocs.prototype = {
	constructor: changeUomsFieldsToMatchAssocs,

	init: function(elems) {
		var TOTOK = this;
		var elems = this.HELPER.araizeParam(elems)

		elems.forEach(function(elem_name) {
			TOTOK.get_empty_texts(elem_name);
			// if something change
			$(document).on('change', '#' + elem_name + ' > div > table > tbody > tr > td > input', function() {
				TOTOK.fillup_list_with_enabled_data(this, elem_name);
				TOTOK.update_dropdowns(elem_name);	
			});
		});
	},

	fillup_list_with_enabled_data: function(reference, elem_name) {
		var TOTOK = this;
		TOTOK.enabled_data[elem_name] = [];

		$(reference).closest('table.checkboxes_list').find('input[type=checkbox]:checked').each(function() {
			TOTOK.enabled_data[elem_name].push({
				val: $(this).val(),
				text: $(this).parent().siblings().children('label').text()
			});
		});
	},

	get_empty_texts: function(selector) {
		var txt = $(document).find("div.uoms_" + selector).first()
			.children('select').find("option[value='']").first()
			.text();
		this.zero_text[selector] = txt;
	},

	update_dropdowns: function(selector) {
		var TOTOK = this;
		var dropdowns = $(document).find("div.uoms_" + selector).children('select');
		var checked_ids = this.HELPER.getIDs(this.enabled_data[selector]);

		dropdowns.each(function() {
			var options = $(this).children('option');

			options.each(function() {
				if (checked_ids.indexOf($(this).val()) == -1) {
					// if selectbox option should not be there
					if ($(this).is(':selected')) {
						if ($(this).val() != "") {
							// if is selected but not more in source data
							//--------- give advice to user to resolve conflict
							$(this).parent().addClass('error');
							// if user decide later to resolve conflic by selecting deselected source data
							$(this).parent().data("blocked_to_removed_option", $(this).val());
							$(this).val("");
							$(this).text("Zdrojové dáta boli zmenené");
						}
					} else {
						// is not important, remove
						$(this).remove();
					}
				}
			});

		});

		// append new options that are not in dropdowns
		this.enabled_data[selector].forEach(function(data) {
			// do not duplicate
			if (dropdowns.find("option[value=" + data.val + "]").length == 0) {
				var elem = "<option value=\"" + data.val + "\">" + data.text + "</option>";
				dropdowns.append(elem);
			}
		});



		// if there are no options (everything deselected)
		dropdowns.each(function() {
			var options = $(this).children('option');
			// if there is zero options or one with empty value (error/validation text)
			//--------- give advice to user to resolve conflict
			console.log($(this).val());
			if (options.length == 0) {
				console.log('0 options');
				//$(this).removeClass('error');
			} else if (options.length == 1 && options.first().val() == "") {
				options.first().text(TOTOK.zero_text[selector]);
			} else {
				console.log('kokoooot');
				if (!$(this).hasClass('error')) {
					$(this).find("option[value=\"\"]").remove();
				}

				//$(this).find("option[value=\"\"]").remove();
			}
			/*else if (options.length >= 1 && options.first().val() == "") {
				$(this).find("option[value=\"\"]").remove();
			}*/
			/*else if (options.length >= 1 && (typeof $(this).data('blocked_to_removed_option') === 'undefined')) {
				console.log($(this).data('blocked_to_removed_option'));
				$(this).find("option[value=\"\"]").remove();
			}*/	
		});
	}
}



function changeUomsFieldsToMatchAssocs_helper() {

}

changeUomsFieldsToMatchAssocs_helper.prototype = {
	constructor: changeUomsFieldsToMatchAssocs_helper,

	araizeParam: function(params) {
		if (params.constructor !== Array) {
			params = [params];
		}
		return params;
	},

	getIDs: function(data) {
		return data.map(function(obj) { return obj.val; });
	}
}


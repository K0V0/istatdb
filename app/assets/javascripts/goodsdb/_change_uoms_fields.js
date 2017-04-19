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
				//TOTOK.remeber_selected_opts_on_dropdowns(elem_name);
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
/*
	remeber_selected_opts_on_dropdowns: function(selector) {
		$(document).find("div.uoms_" + selector).children('select').each(function() {
			$(this).data("selected", $(this).children('option:selected').val());
		});
	},
*/
	update_dropdowns: function(selector) {
		var TOTOK = this;
		var dropdowns = $(document).find("div.uoms_" + selector).children('select');
		var checked_ids = this.HELPER.getIDs(this.enabled_data[selector]);


		// if selected is in checked ids

		// remove items not in checked ids

		// add items not in dropdowns

		// if everything unchecked 

		// remove everything that is not selected
		//dropdowns.children('option').filter(':not(:selected)').remove();

		// remove selected that are obsolete after change
		//dropdowns.children('option').filter(':selected').each(function(obj) {
			//if () {

			//}
		//});

		//dropdowns.children('option').each(function() {

		//});
/*
		TOTOK.enabled_data[selector].forEach(function(obj) {
			dropdowns.each(function() {
				// if in this loop, at least one checkbox is checked
				$(this).find("option[value='']").remove();

				if ($(this).find("option[value=" + obj.val + "]").length > 0) {
					// do not add, same item found in dropdown (selected that persisted for example)
				} else {
					// add if item not found
					var elem = "<option value=\"" + obj.val + "\">" + obj.text + "</option>";
					$(this).append(elem);
				}
			});
		});

		// in case of everything deselected
		if (TOTOK.enabled_data[selector].length < 1) {
			dropdowns.empty();
			var elem = "<option value=\"\">" + TOTOK.zero_text[selector] + "</option>";
			dropdowns.append(elem);
		}
*/
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


function changeUomsFieldsToMatchAssocs(source_section_id) {
	console.log("changeUomsFieldsToMatchAssocs()");

	if (source_section_id.constructor !== Array) {
		source_section_id = [source_section_id];
	}

	source_section_id.forEach(function(elem_name) {

		// if some changes happen in data that are used as a source for dropdowns in associated section
		$(document).on('change', '#' + elem_name + ' > div > table > tbody > tr > td > input', function() {

			// stored dropdown menus
			var dropdowns = $(document).find("div.uoms_" + elem_name).children('select');
				
			// remove all options from dropdown list(s) except selected one
			dropdowns.children('option').filter(':not(:selected)').remove();

			// fillup dropdown list
			// loops throught source section to get data
			var sourceCheckboxes = $(this).closest('table.checkboxes_list').find('input[type=checkbox]:checked');

			sourceCheckboxes.each(function() {

				// value of checkbox (id of record)
				var val = $(this).val();
				// text of chexkbox's label
				var text = $(this).parent().siblings().children('label').text();
				// nothing to say
				var elem = "<option value=\"" + val + "\">" + text + "</option>";

				// loops throught each dropdown in associated section(s)
				dropdowns.each(function() {
					// do not add duplicates (if persisted because is selected for example)
					var val_not_found = true
					$(this).removeClass('error');

					$(this).children('option').each(function() {
						if (val == $(this).val()) {
							val_not_found = false;
						} 
						// if some default option without value like "please select..." text found, remove
						// it will be removed only if some source data found otherwise this dropwdowns loop
						// will not run 
						if ($(this).val() == "") {
							$(this).remove();
						}
					});

					if (val_not_found) {
						$(this).append(elem);
					}
				});
			});

			// if everything has been unchecked
			if (sourceCheckboxes.length === 0) {

				dropdowns.each(function() {

					// if unchecked value that has been selected before, remove it and give warning to user
					if ($(this).val() != "") {
						$(this).addClass('error');
						$(this).children('option').remove();
						$(this).append("<option value=\"\">Zvoľte najskôr minilálne 1</option>");
					}
				});
			} 
		});

	});
}
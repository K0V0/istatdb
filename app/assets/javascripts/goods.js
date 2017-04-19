function GOODS_onready() {
	
	// function to add/remove intrastat clients and manufacturers from
	// dropdown menus in units (uom) sections based on checked clients and manufacturers
	UOMS_DROPDOWNS_ADAPT = new changeUomsFieldsToMatchAssocs();
	UOMS_DROPDOWNS_ADAPT.init([
		"impexpcompany_select",
		"manufacturer_select"
	]);

	searchQuery(
		'/local_taric/new_select_search',
		{ 
			local_taric_kncode: "kncode_start",
			local_taric_description: "description_cont"
		},
		{
			cols_highlighted: {
				kncode: "kncode",
				description: "description"
			}
		}		
	);

	searchQuery(
		'/impexpcompanies/new_select_search',
		{ 
			impexpcompany_company_name: "company_name_cont"
		},
		{
			cols_highlighted: {
				company_name: "company_name"
			}
		}
	);

	searchQuery(
		'/manufacturers/new_select_search',
		{ 
			manufacturer_name: "name_cont"
		},
		{
			cols_highlighted: {
				name: "name"
			}
		}
	);


	// new action - adding more fields for uoms 
	/*
	$(document).on('click', 'button.add_uom', function() {
		//console.log('add uom');
		var clone = $(this).closest('article').clone();
		clone.find('.good_uoms_uom').val('');
		clone.find('.good_uoms_uom_multiplier').val('1');
		clone.insertBefore('form > article:last-child');
		var not_last = $(document).find('.new_good_uom').not(':last');
		not_last.find('button.add_uom').parent().addClass('remove_uom');
		not_last.find('button.remove_uom').parent().removeClass('remove_uom');
		if (not_last.length > 0) {
			$(document).find('.new_good_uom').last().find('button.remove_uom').parent().removeClass('remove_uom');
		}
	});
	*/

	// new action - removing uoms fields
	/*
	$(document).on('click', 'button.remove_uom', function() {
		var uoms_fields = $(document).find('.new_good_uom');
		var art = $(this).closest('article')

		if (uoms_fields.length > 1) {
			art.remove();
			uoms_fields = $(document).find('.new_good_uom');
			uoms_fields.last().find('button.add_uom').parent().removeClass('remove_uom');
		} 
		if (uoms_fields.length == 1) {
			art.find('.good_uoms_uom').val('');
			art.find('.good_uoms_uom_multiplier').val('1');
			art.find('select').children('option').removeAttr('selected');
		}
	});
	*/

	// show action - select uom type for uoms calculator
	$(document).on('click', '.good_manufacturer_uoms_list tr', function() {
		$(this).siblings().removeClass('selected');
		$(this).addClass('selected');
		UOMS_CALCULATOR.setVals(
			parseFloat($(this).children('td.good_manufacturer_uoms_list_val').first().text()),
			parseFloat($(this).children('td.good_manufacturer_uoms_list_multiplier').first().text()),
			$(this).children('td.good_manufacturer_uoms_list_type').first().text()
		);
	});

	// index/search action - checkbox button to enable/disable second searchfield
	$(document).on('click', 'input#q_search_both', function() {
		var chkd = $(this).is(':checked');
		if (chkd) {
			$('#q_description_cont').removeAttr('disabled');
			$('#q_description_cont').siblings('label').removeClass('disabled');
			$('#q_ident_or_description_cont').attr('name', 'q[ident_cont]');
		} else {
			$('#q_description_cont').attr('disabled', 'disabled');
			$('#q_description_cont').siblings('label').addClass('disabled');
			$('#q_ident_or_description_cont').attr('name', 'q[ident_or_description_cont]');
		}
	});

}

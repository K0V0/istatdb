//$(document).on('turbolinks:load', function() {
$(document).ready(function() {

	// adding new good page - searching help tables for fast picking up criterium if exist 
	searchQuery(
		'/goodsdb/new/knnumber_search',
		{ 
			good_local_taric_kncode: "kncode_start",
			good_local_taric_description: "description_cont"
		}
	);

	searchQuery(
		'/goodsdb/new/client_search',
		{ 
			good_impexpcompany_company_name: "company_name_cont"
		}
	);

	searchQuery(
		'/goodsdb/new/manufacturer_search',
		{ 
			good_manufacturer_name: "name_cont"
		}
	);

	searchQuery(
		'/goodsdb/new/edit_client_search',
		{ 
			edit_good_impexpcompany_company_name: "company_name_cont"
		},
		{
			good_id: $('#good_id').val()
		}
	);
/*
	searchQuery(
		'/manufacturersdb/new/maufacturer_search_making',
		{ 
			edit_good_manufacturer_name: "name_cont"
		},
		{
			manufacturer_id: $('#manufacturer_id').val()
		}
	);

	searchQuery(
		'/manufacturersdb/new/manufacturer_search_other',
		{ 
			edit_good_manufacturer_name: "name_cont"
		},
		{
			manufacturer_id: $('#manufacturer_id').val()
		}
	);
*/
	$(document).on('click', 'button.add_uom', function() {
		console.log('add uom');
		var clone = $(this).closest('article').clone();
		clone.find('.good_uoms_uom').val('');
		clone.find('.good_uoms_uom_multiplier').val('1');
		//clone.insertBefore('form > div:last-child');
		clone.insertBefore('form > article:last-child');
		var not_last = $(document).find('.new_good_uom').not(':last');
		not_last.find('button.add_uom').parent().addClass('remove_uom');
		not_last.find('button.remove_uom').parent().removeClass('remove_uom');
		if (not_last.length > 0) {
			$(document).find('.new_good_uom').last().find('button.remove_uom').parent().removeClass('remove_uom');
		}
	});

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

	$(document).on('input', 'input[name=uom_count]', function() {
		var val = parseFloat($('input[name=uom_value]').val());
		var multiplier = parseInt($('input[name=uom_multiplier]').val());
		var count = parseFloat($('input[name=uom_count]').val());
		var result = (val * count) / multiplier;
		$('input[name=uom_result]').val(result.toFixed(2));
	});

	$(document).on('click', '.good_manufacturer_uoms_list tr', function() {
		$(this).siblings().removeClass('selected');
		$(this).addClass('selected');

		$(this).children('td.good_manufacturer_uoms_list_val').sendValTo('input[name=uom_value]');
		$(this).children('td.good_manufacturer_uoms_list_multiplier').sendValTo('input[name=uom_multiplier]');
		$(this).children('td.good_manufacturer_uoms_list_type').sendValTo('span.uoms_calculator_uom_type');
	});

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

});

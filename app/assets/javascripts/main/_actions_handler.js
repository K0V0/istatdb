// convention: table id has controller name
// button id that fires event is: select_all_<controller name>, deselect_all_<controller name>
function ActionsHandler() {
	this.init();
	this.reinit();
}

ActionsHandler.prototype = {
	constructor: ActionsHandler,

	init: function() {
		var totok = this;
		$(document).on('change', 'table.items input[type=checkbox]', function() {
			totok.refresh();
		});
		$(document).on('click', '#select_all_items', function() {
			totok.selectAll();
		});
		$(document).on('click', '#deselect_all_items', function() {
			totok.removeAllSelected();
		});
		$(document).on('input', "section.search_bar > form", function(e) {
		    $(this).find('input#reset_to_first_page').val('true');
		    $(this).submit();
		});
		$(document).on('click', "#clear_search", function(e) {
			$('section.search_bar > form').find('input[type=search]').val('');
		});
		$(document).on('click', "#reset_search", function(e) {
			$('section.search_bar > form').find('input[type!=submit], select').val('');
		});
	},

	reinit: function() {
		this.checkboxes = [];
		this.checkboxes_checked = [];
		this.checked_ids = [];
		this.select_button = $(document).find('#select_all_items');
		this.deselect_button = $(document).find('#deselect_all_items');
		this.refresh();
	},

	removeAllSelected: function() {
		this.checkboxes.prop('checked', false);
		this.refresh();
	},

	selectAll: function() {
		this.checkboxes.prop('checked', true);
		this.refresh();
	},

	refresh: function() {
		this.checkboxes = $(document).find('table.items').find('input[type=checkbox]');
		this.checkboxes_checked = $(document).find('table.items').find('input[type=checkbox]:checked');

		var total = this.checkboxes.length;
		var chkd = this.checkboxes_checked.length;
		var nochkd = total - chkd;

		if (nochkd == total && total > 0) {
			this.disableDeselectAll();
		} else if (chkd == total && total > 0) {
			this.disableSelectAll();
		} else if (nochkd < total) {
			this.enableBothSelects();
		} else if (total == 0) {
			this.disableBothSelects();
		}	
	},

	disableSelectAll: function() {
		this.select_button.prop('disabled', true).removeClass().addClass('button disabled');
		this.deselect_button.prop('disabled', false).removeClass().addClass('button');
	},

	disableDeselectAll: function() {
		this.select_button.prop('disabled', false).removeClass().addClass('button');
		this.deselect_button.prop('disabled', true).removeClass().addClass('button disabled');
	}, 

	disableBothSelects: function() {
		this.select_button.prop('disabled', true).removeClass().addClass('button disabled');
		this.deselect_button.prop('disabled', true).removeClass().addClass('button disabled');
	},

	enableBothSelects: function() {
		this.select_button.prop('disabled', false).removeClass().addClass('button');
		this.deselect_button.prop('disabled', false).removeClass().addClass('button');
	},
	/*
	preserve_checked: function() {
		var totok = this;
		this.checkboxes_checked.each(function() {
			var id = $(this).attr('id').replace(totok.controller_name+'_', '');
			if (totok.checked_ids.indexOf(id) == -1) {
				totok.checked_ids.push(id);
			}
		});
		$('#preserve_checked').val(totok.checked_ids);
		totok.checked_ids = [];
	} 
	*/
}
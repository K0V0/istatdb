// convention: table id has controller name
// button id that fires event is: select_all_<controller name>, deselect_all_<controller name>
function ActionsHandler(controller_name) {

	this.controller_name = controller_name;

	this.select_button = $('#select_all_'+controller_name);
	this.deselect_button = $('#deselect_all_'+controller_name);
	this.checkboxes = [];
	this.checkboxes_checked = [];
	this.checked_ids = [];

	this.init();
	this.refresh();
}

ActionsHandler.prototype = {
	constructor: ActionsHandler,

	init: function() {
		var totok = this;
		$(document).on('change', '#'+this.controller_name+' input[type=checkbox]', function() {
			totok.refresh();
		});
		$(document).on('click', '#select_all_'+this.controller_name, function() {
			totok.selectAll();
			totok.refresh();
		});
		$(document).on('click', '#deselect_all_'+this.controller_name, function() {
			totok.removeAllSelected();
			totok.refresh();
		});
		$(document).on('input', "section.search_bar > form", function(e) {
			totok.preserve_checked();
		    $(this).submit();
		});
		$(document).on('click', "#clear_search", function(e) {
			$('section.search_bar > form').find('input[type=search]').val('');
		});
	},

	removeAllSelected: function() {
		this.checkboxes.prop('checked', false);
	},

	selectAll: function() {
		this.checkboxes.prop('checked', true);
	},

	refresh: function() {
		this.checkboxes = $('#'+this.controller_name).find('input[type=checkbox]');
		this.checkboxes_checked = $('#'+this.controller_name).find('input[type=checkbox]:checked');

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
}
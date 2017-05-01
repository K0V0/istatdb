function uomsManufacturerImpexpcompanyOptionsDropdowns(elem) {
	this.elem_name = elem;
	this.default_text_nothing_to_select = "";
	this.HELPER;
	this.SELECTS = [];
	this.data = [];

	this.init();
}

uomsManufacturerImpexpcompanyOptionsDropdowns.prototype = {
	constructor: uomsManufacturerImpexpcompanyOptionsDropdowns,

	init: function() {
		var TOTO = this;
		// should run only when page with forms is loaded
		this.HELPER = new uomsManufacturerImpexpcompanyOptionsDropdowns_helper(this);
		// in update form should different method to get this text must be invented
		this.getSelects();
		this.default_text_nothing_to_select = this.SELECTS.first().text();

		$(document).on('change', 'div.uoms_' + this.elem_name + ' > select', function() {
			// this handler should run only on user interaction with dropdown
			$(this).data('selected_by_hand', $(this).val());
			// if some source data were removed, then control if user selected available
			TOTO.HELPER.controlValidationReparation($(this));
		});
	},

	reload: function(vals) {
		this.getSelects();
		this.data = vals;
		this.rerender();
	},

	rerender: function() {
		var TOTO = this;
		TOTO.SELECTS.each(function() {
			var TOTO_SELECTS = $(this);

			TOTO.HELPER.removeDisabledOnSelect(TOTO_SELECTS);
			TOTO_SELECTS.removeClass('error');

			TOTO_SELECTS.children('option').each(function() {
				// cleaning dropdown menu
				if ($(this).val() != $(this).parent().data('selected_by_hand')) {
					$(this).remove();
				} else {
					// if data that no exists more are selected
					$(this).parent().parent().addClass('error');
				}
			});
			
			TOTO.data.forEach(function(data) {
				// append only if not exists
				if (TOTO_SELECTS.find("option[value=" + data.value + "]").length == 0) {
					var elem = "<option value=\"" + data.value + "\">" + data.text + "</option>";
					TOTO_SELECTS.append(elem);
				}
			});

			if (TOTO_SELECTS.children('option').length == 0) {
				// if everyting deselected, disable dropdowns
				TOTO_SELECTS.append("<option value=\"\">" + TOTO.default_text_nothing_to_select + "</option>");
				TOTO.HELPER.disableSelect(TOTO_SELECTS);
			}
		});
	}, 

	getSelects: function() {
		this.SELECTS = $(document).find('div.uoms_' + this.elem_name).children('select')/*.first()*/;
	}, 
}



function uomsManufacturerImpexpcompanyOptionsDropdowns_helper(parent_reference) {
	this.MAINCLASS = parent_reference;
}

uomsManufacturerImpexpcompanyOptionsDropdowns_helper.prototype = {
	constructor: uomsManufacturerImpexpcompanyOptionsDropdowns_helper,

	removeDisabledOnSelect: function(ref) {
		ref.removeAttr('disabled');
		ref.parent().removeClass('disabled');
	},

	disableSelect: function(ref) {
		ref.attr('disabled', true);
		ref.parent().addClass('disabled');
	},

	controlValidationReparation: function(ref) {
		this.MAINCLASS.data.some(function(data) {
			if (data.value == ref.val()) {
				ref.parent().removeClass('error');
				return true;
			}
		});
	}
}
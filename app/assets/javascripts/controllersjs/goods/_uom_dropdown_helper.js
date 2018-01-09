function UomDropdownHelper() {

	this.init();
}

UomDropdownHelper.prototype = {
	constructor: UomDropdownHelper,

	init: function() {

	},

	fillupDropdown: function(ref, list) {
		//console.log(list);
		list.forEach(function(opt) {
			//console.log(elem);
			$(ref).append('<option value="' + opt.id + '">' + opt.text + '</option>');
		});
	},

	clearDropdown: function(ref) {
		$(ref).children('option').each(function() {
			$(this).remove();
		});
	},

	rememberInitialState: function(ref) {
		//$(this).data('selected_by_hand', $(this).val());
		//console.log($(ref).val());
		var val = $(ref).val();
		if (val != '') {
			$(ref).data('preselected', val);
		}
	}


}
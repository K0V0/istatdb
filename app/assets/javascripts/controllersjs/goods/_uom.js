function Uom() {
	this.D = new UomDropdown();
	this.H = new UomHelper();
	this.init();
}

Uom.prototype = {
	constructor: Uom,

	init: function() {
		this.D.rememberDropdownsInitialStates();
		this.D.recollectAvailOptionsForDropdowns();
		this.H.onChangeUom();
		this.evts();
	},

	evts: function() {
		var T = this;
		$(document).on('click', 'button.add_uom', function() {
			T.addNext($(this).closest('article.uoms'));
		});
		$(document).on('click', 'button.remove_uom', function() {
			T.delete($(this).closest('article.uoms'));
		});
	},

	reset: function() {

	},

	delete: function(uom) {
		//var par = uom.closest('aside');
		uom.remove();
		this.H.onChangeUoms();
	},

	addNext: function(uom) {
		// uom - uom "window" object 
		newUom = uom.clone(true, true);
		$(document).find('aside').append(newUom);
		this.H.onChangeUoms();
	}

}
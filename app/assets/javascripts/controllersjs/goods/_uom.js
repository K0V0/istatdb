function Uom() {
	this.D = new UomDropdown();
	this.H = new UomHelper();
	this.init();
}

Uom.prototype = {
	constructor: Uom,

	init: function() {
		this.saveDefaults();
		this.D.init();
		this.buttonEvents();
		this.onChangeUomEvents();
		this.onChangeUomsEvents();
	},

	buttonEvents: function() {
		var T = this;
		$(document).on('click', 'button.add_uom', function() {
			T.H.addNext($(this).closest('article.uoms'));
		});
		$(document).on('click', 'button.remove_uom', function() {
			T.H.delete($(this).closest('article.uoms'));
		});
		$(document).on('click', 'button.restore_uom', function() {
			T.H.restore($(this).closest('article.uoms'));
		});
	},

	onChangeUomEvents: function() {
		// on change any input inside uom
		var T = this;
		$(document)
		.find('article.uoms')
		.find('input, select')
		.on('change', this, function() {
			logger('onChangeUomEvents');
			T.H.decideAddButtonActivation($(this).closest('article'));
			T.H.decideClearButtonActivation($(this).closest('article'));
		});
	},

	onChangeUomsEvents: function() {
		var T = this;
		$(document).find('aside').on('change', this, function() {
			T.H.decideRemoveButtonActivation($(this).find('article.uoms'));
		});
	},

	saveDefaults: function() {
		$(document).find('article.uoms').find('input, select').each(function() {
			$(this).data('initial', $(this).val());
		});
	}

}
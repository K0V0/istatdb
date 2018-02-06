function UomDropdown() {
	this.H = new UomDropdownHelper();
	this.init();
}

UomDropdown.prototype = {
	constructor: UomDropdown,

	init: function() {	
		this.evts();
	},

	evts: function() {
		this.onSourceChange();
		this.onUserChange();
		this.onChange();
	},

	onChange: function() {
		// dropdown changed
		var T = this;
		$(document)
		.find('select')
		.filter(function() { 
			return this.id.match("good_uoms_attributes_[0-9]+_(impexpcompany|manufacturer)_id");
		})
		.on('change', this, function() {
			logger('dropdown changed');
			T.H.decideIfEnable(this);
			T.H.validate(this);
		});
	},

	onUserChange: function() {
		// dropdown changed olny by explicit user manipulation
		var T = this;
		$(document)
		.find('select')
		.filter(function() { 
			return this.id.match("good_uoms_attributes_[0-9]+_(impexpcompany|manufacturer)_id");
		})
		.on('focusout', this, function() {
			logger('dropdown changed by user');
			T.H.rememberChangeByUser(this);
		});
	},

	onSourceChange: function() {
		// collects (choosen) data from good's client and manufacturer lists 
		var T = this;
		$(document)
		.find('article.impexpcompany_select, article.manufacturer_select')
		.find('input[type=checkbox]')
		.on('change', this, function(){ 
			var list = new OptionsList(this);
			T.H.updateDropdownLists(list);
			// run dropdowns update with collected data
		});
	}

}
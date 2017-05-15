function uoms() {
	this.UD_MANUFACTURER = null;
	this.UD_IMPEXPCOMPANY = null;

	this.init();
}

uoms.prototype = {
	constructor: uoms,

	init: function() {
		this.UD_MANUFACTURER = new uomsManufacturerImpexpcompanyOptionsHandler('manufacturer');
		this.UD_IMPEXPCOMPANY = new uomsManufacturerImpexpcompanyOptionsHandler('impexpcompany');
	}
}
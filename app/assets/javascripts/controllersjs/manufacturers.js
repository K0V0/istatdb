function MANUFACTURERS() {
	this.search;
}

MANUFACTURERS.prototype = {
	constructor: MANUFACTURERS,

	_index_search_show_administrative_end_administrative_on_ready: function() {
		this.search = new searchItemActions();
	},
}

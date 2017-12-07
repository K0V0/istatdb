function LOCAL_TARICS() {
	this.search;
}

LOCAL_TARICS.prototype = {
	constructor: LOCAL_TARICS,

	_index_search_show_administrative_end_administrative_on_ready: function() {
		this.search = new searchItemActions();
	},
}
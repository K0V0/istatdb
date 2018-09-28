function Tooltip() {
    this.init();
    this.clipboard = null;
}

Tooltip.prototype = {
    constructor: Tooltip,

    init: function() {
        $(document)
	        .on("mouseenter", "td", function() {
	        	$(this).has("sup").tooltip();
	        })
	        .on("mouseleave", "td", function() {
	        	$(this).has("sup").tooltip(false);
	        });
    }
}

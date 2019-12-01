function Tooltip() {
    this.init();
    this.clipboard = null;
}

Tooltip.prototype = {
    constructor: Tooltip,

    init: function() {
    	$(document).tooltip(false);
        $(document)
	        .on("mouseenter", "var, dfn", function() {
                $(this).tooltip();
	        })
	        .on("mouseleave", "var, dfn", function() {
                $(this).tooltip(false);
	        });
    }
}

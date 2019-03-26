function UncompleteHandler() {
    this.init();
}

UncompleteHandler.prototype = {
    constructor: UncompleteHandler,

    init: function() {
    	var txtarea = $(document).find('textarea#good_uncomplete_reason');

    	$(document).on('change', 'input#good_uncomplete', function() {
    		if ($(this).is(':checked')) {
    			txtarea.attr('disabled', false);
    		} else {
    			txtarea.attr('disabled', true);
    		}
    	});
    }
}

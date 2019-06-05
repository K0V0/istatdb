function CopyPaste() {
    this.init();
    this.clipboard = null;
}

CopyPaste.prototype = {
    constructor: CopyPaste,

    init: function() {
        this.clipboard = new Clipboard(
        	'b.copy_to_clipboard',
        	{
			    text: function(e) {
			    	var elem = $($(e).data('clipboard-target'));
			        return elem.text().replace(/(<([^>]+)>)/ig,""); 
			    }
			}
		);
    }
}

function CopyPaste() {
    this.init();
    this.clipboard = null;
}

CopyPaste.prototype = {
    constructor: CopyPaste,

    init: function() {
        this.clipboard = new Clipboard('b.copy_to_clipboard');
        console.log(this.clipboard);
    }
}

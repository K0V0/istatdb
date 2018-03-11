function SupressHtml5Bubbles() {
    this.init();
}

SupressHtml5Bubbles.prototype = {
    constructor: SupressHtml5Bubbles,

    init: function() {
        var T = this;
        document.addEventListener('invalid', (function(){
            return function(e) {
              e.preventDefault();
              $(e.target).addClass('error');
              T.generateValidationError(e.target)
              JS.H.run('on_change');
            };
        })(), true);
    },

    generateValidationError: function(ref) {
        var typ = $(ref).attr('type');
        var id = $(ref).attr('id');
        var msg = t('html5validations.' + typ);
        var container = $(ref).siblings('div.form_errors');

        if (container.has('span.error.'+id).length == 0) {
            // if no same error is here
            container.append("<span class=\"error " + id + "\">" + msg + "</span>");
        }
    }
}

(function($) {

    window['counter_functions_dict'] = {
        mouseenter: 'mouseleave',
        mouseleave: 'mouseenter'
    };

    $.fn.preventAccidentTrigger = function (e, t, s, f) {
        if (typeof s == 'function') { f = s; s = ""; }
        if (typeof t == 'string') { s = t; }
        if (typeof t == 'function') { f = t; }
        if (typeof t != 'number') { t = 250; }

        return this.each(function() {
            var u;
            $(this).on(e, s, function() {
                var p = this;
                u = setTimeout(function(){ $(p).hnd(f); }, t);
            })
            .on(window['counter_functions_dict'][e], s, function() {
                clearTimeout(u);
            });
        });
    }
    $.fn.hnd = function (h) { h.call(this); }
}(jQuery));

(function($) {
    $.fn.hideScrollbars = function (sw) {

        return this.each(function() {
            if (sw === false) {
                $(this).css('overflow', $(this).data('overflow-before'));
            } else if (sw === true) {
                console.log($(this).css('overflow'));
                if ($(this).css('overflow').length == 0) {
                    $(this).data('overflow-before', 'auto');
                } else {
                    $(this).data('overflow-before', $(this).css('overflow'));
                    $(this).css('overflow', 'hidden');
                }
            }
        });
    }
}(jQuery));
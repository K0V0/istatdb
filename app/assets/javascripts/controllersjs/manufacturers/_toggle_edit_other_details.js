function ToggleEditOtherDetails() {
    this.init();
}

ToggleEditOtherDetails.prototype = {
    constructor: ToggleEditOtherDetails,

    init: function() {
        var btn = $(document).find('article.edit_next');
        $(document)
        .find('body.manufacturers')
        .find('article.impexpcompany_select')
        .on('change', this, function() {
           var a = $(this).find('input:checked').length;
           if (a > 0) { btn.removeClass('novisible'); }
           else { btn.addClass('novisible'); }
        })
    }
}

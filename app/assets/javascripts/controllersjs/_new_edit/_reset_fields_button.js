function ResetFieldsButton() {
    this.init();
}

ResetFieldsButton.prototype = {
    constructor: ResetFieldsButton,

    init: function() {
        $(document)
        .find('button.button.reset')
        .on('click', function(){
            $(this)
            .closest('article')
            .find('input[type=text], input[type=search], textarea')
            .val('')
            .trigger('input'); // to run search action to refresh list after delete
        });
    }
}

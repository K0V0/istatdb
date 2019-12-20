function TextareaSizer() {
    this.init();
}

TextareaSizer.prototype = {
    constructor: TextareaSizer,

    init: function() {

        $(document).on('input', 'textarea', function() {
            var l = $(this).val().length;
            if (l > 26) {
                $(this).addClass('enlarged');
            } else if (l == 0) {
                $(this).removeClass('enlarged');
            }
        });
    }
}

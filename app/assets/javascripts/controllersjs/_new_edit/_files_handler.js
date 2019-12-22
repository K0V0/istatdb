function FilesHandler() {
    this.newFileClone;
    this.init();
}

FilesHandler.prototype = {
    constructor: FilesHandler,

    init: function() {
        var T = this;
        T.newFileClone = $('article.files > div > div.files > div.empty_file').last().clone();

        $(document).on('change', 'input[type=file]', function() {
            T.readUrl(this);
        });

        $(document).on('click', 'div.files > div > label.remove_file', function(e) {
            T.remove($(this).closest('div'));
        });

        $(document).on('click', 'article.files > div > button#add_files', function(e) {
            T.cloneNewFileButton();
        });

        $(document).on('change', 'div.files > div > input.remove_file', function(e) {
            var par = $(this).closest('div');
            if (par.hasClass('on_server')) {
                T.markForRemove($(this));
            } else {

            }
        });
    },

    readUrl: function(input) {
        var T = this;
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                //
            };
            reader.onloadend = function(e) {
                T.changeLabel(input);
            }
            reader.readAsDataURL(input.files[0]);
        }
    },

    changeLabel: function(ref) {
        $(ref).siblings('label.add_file').text(ref.files[0].name);
        $(ref).siblings('label.remove_file').removeClass('novisible');
    },

    cloneNewFileButton: function() {
        var toto = this;
        var container = $('article.files').children('div').children('div.files');
        var next_index = 0;
        container.find('input[type=file]').each(function() {
            var index = parseInt($(this).attr('name').match(/\d+/));
            if (index > next_index) { next_index = index; }
        });
        next_index++;
        var tmp_obj = this.newFileClone.clone();
        tmp_obj.find('input, label, textarea').each(function() {
            toto.cloneIds($(this), next_index);
        });
        tmp_obj.removeClass('novisible');
        tmp_obj.children('label').removeClass('novisible');
        tmp_obj.appendTo(container);
    },

    cloneIds: function(ref, next_index) {
        var attrs = ['name', 'id', 'for'];
        for (var i=0; i<attrs.length; i++) {
            var attr = ref.attr(attrs[i]);
            if (typeof attr !== typeof undefined && attr !== false) {
                ref.attr(attrs[i], attr.replace(/\d+/, next_index));
            }
        }
    },

    markForRemove: function(ref) {
        var trg = ref.closest('div');
        if (ref.is(':checked')) {
            trg.addClass('to_delete');
        } else {
            trg.removeClass('to_delete');
        }
    },

    remove: function(ref) {
        var toto = this;
        if (!ref.hasClass('on_server')) { 
            var sibl = ref.siblings('div').length;
            ref.remove();
            if (sibl == 0) { toto.cloneNewFileButton(); }
        }
    }

}

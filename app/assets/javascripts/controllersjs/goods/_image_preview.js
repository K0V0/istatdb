function ImagePreview() {
    this.newImageClone;
    this.init();
}

ImagePreview.prototype = {
    constructor: ImagePreview,

    init: function() {
        var T = this;
        T.newImageClone = $('article#good_images').children('div').children('picture').last().clone();
        $(document).on('change', 'input[type=file]', function() {
            T.readUrl(this);
        });
        /*$(document).on('click', 'label.destroy.new', function() {
            T.removeNewlyAddedImage($(this));
        });*/
    },

    readUrl: function(input) {
        var T = this;
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                //T.cloneNewImageButton();
                T.appendPreview($(input), e.target.result);
                T.cloneNewImageButton();
            }
            reader.readAsDataURL(input.files[0]);
        }
    },

    appendPreview: function(ref, src) {
        ref.siblings('img').attr('src', src);
        this.triggerChange(ref);
    },

    cloneNewImageButton: function() {
        var container = $('article#good_images').children('div.images');
        var new_upload_field_present = (container.find('img[src=""]').length > 0);

        if (!new_upload_field_present) {
            var some_empty = false
            var next_index = 0;
            container.children('picture').each(function() {
                var index = parseInt($(this).find('input[type=file]').attr('name').match(/\d+/));
                if (index > next_index) { next_index = index; }
            });
            next_index++;
            var tmp_obj = this.newImageClone.clone();
            tmp_obj.children('input').each(function() {
                var new_name = $(this).attr('name').replace(/\d+/, next_index);
                $(this).attr('name', new_name);
            });
            tmp_obj.appendTo(container);
        }
    },

    removeNewlyAddedImage: function(ref) {
        var trg = ref.closest('div.pictures');
        ref.closest('picture').remove();
        trg.trigger('content_changed');
    },

    triggerChange: function(ref) {
        ref.closest('div.pictures').trigger('content_changed');
    }

}

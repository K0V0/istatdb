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

        $(document).on('click', 'picture > div > label.remove_image', function(e) {
            var p = $(this).closest('picture');
            if (!p.hasClass('on_server')) {
                p.remove();
            }
        });

        $(document).on('change', 'picture > div > input.remove_image', function(e) {
            if ($(this).closest('picture').hasClass('on_server')) {
                T.removeUploadedImage($(this));
            }
        });
    },

    readUrl: function(input) {
        var T = this;
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                T.appendPreview($(input), e.target.result);
            }
            reader.onloadend = function(e) {
                T.cloneNewImageButton();
            }
            reader.readAsDataURL(input.files[0]);
        }
    },

    appendPreview: function(ref, src) {
        ref.parent('div').siblings('img').attr('src', src);
        ref.closest('picture').addClass('to_upload');
        this.triggerChange(ref);
    },

    cloneNewImageButton: function() {
        var toto = this;
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
            tmp_obj.find('input, label').each(function() {
                toto.cloneIds($(this), next_index);
            });
            tmp_obj.appendTo(container);
        }
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

    removeUploadedImage: function(ref) {
        var trg = ref.closest('picture');
        if (ref.is(':checked')) {
            trg.addClass('to_delete');
        } else {
            trg.removeClass('to_delete');
        }
    },

    triggerChange: function(ref) {
        ref.closest('div.pictures').trigger('content_changed');
    }

}

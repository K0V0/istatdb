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
                T.cloneNewImageButton();
                T.appendPreview($(input), e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    },

    appendPreview: function(ref, src) {
        //var lbl = ref.siblings('span').children('label')
        //var i = ref.siblings('input.identificator').val();
        //lbl.empty();
        //lbl.append('<img>');
        //lbl.children('img').attr('src', src);
        /*ref.parent()
            .append('<em>'+i+'</em>')
            .append('<label class="destroy new">X</label>');*/
        ref.siblings('img').attr('src', src);
        this.triggerChange(ref);
    },

    cloneNewImageButton: function() {
        var some_empty = false
        var next_index = 0;
        var container = $('article#good_images').children('div.images');
        container.children('picture').each(function() {
            var index = parseInt($(this).find('input[type=file]').attr('name').match(/\d+/));
            //var index = parseInt($(this).find('input.identificator').val());
            if (index > next_index) { next_index = index; }
        });
        next_index++;
        var tmp_obj = this.newImageClone.clone();
        tmp_obj.children('input').each(function() {
            var new_name = $(this).attr('name').replace(/\d+/, next_index);
            //var new_id = $(this).attr('id').replace(/\d+/, next_index);
            $(this).attr('name', new_name);
            //$(this).attr('id', new_id);
        });
        //var label_name = $(tmp_obj).children('span').children('label').attr('for').replace(/\d+/, next_index);
        //tmp_obj.children('input#post_post_images_attributes_'+next_index+'_identificator').val(next_index/*+1*/);
        //$(tmp_obj).children('span').children('label').attr('for', label_name)
        tmp_obj.appendTo(container);
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

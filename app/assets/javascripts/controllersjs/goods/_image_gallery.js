function ImageGallery() {
    this.images_list = [];
    this.init();
}

ImageGallery.prototype = {
    constructor: ImageGallery,

    init: function() {
        var totok = this;
        this.loadImagesList();

        $(document).on('click', 'div.images.gallery_set > picture', function() {
            totok.openViewer($(this));
        });

        $(document).on('click', 'div.gallery', function() {
            totok.closeViewer($(this));
        });

        $(document).on('click', 'div.gallery > div.switcher > picture', function(e) {
            e.stopPropagation();
            totok.selectImage($(this));
        });
    },

    loadImagesList: function() {
        var totok = this;
        this.images_list = [];
        $(document).find('div.images_list').children('input').each(function() {
            totok.images_list.push($(this).val());
        })
    },

    openViewer: function(pic) {
        $(document).find('div.gallery').addClass('visible');
        $(document).find('body').hideScrollbars(true);
        $(document).find('div.switcher').hideScrollbars(true);
        this.scrollHorizont($(document).find('div.switcher'));
        this.selectImage(pic);
    },

    closeViewer: function(gal) {
        gal.removeClass('visible');
        $(document).find('body').hideScrollbars(false);
    },

    selectImage: function(pic) {
        var pic_to_show = pic.children('img').attr('src').replace(/\/(preview_|thumb_)/, '/max_');
        var gallery = $(document).find('div.gallery');
        gallery.children('div.body').find('img').attr('src', pic_to_show);
        //gallery.children('div.body').children('picture').css({'background-image':'url('+pic_to_show+')'});
        this.prelightSelectedIcon(pic_to_show);
    },

    prelightSelectedIcon: function(pic_addr) {
        var pic_selected = pic_addr.replace(/\/max_/, '/thumb_');
        $('div.switcher').find('img').each(function() {
            if ($(this).attr('src') == pic_selected) {
                $(this).parent('picture').addClass('selected');
            } else {
                $(this).parent('picture').removeClass('selected');
            }
        });
    },

    scrollHorizont: function(ref) {
        ref.mousewheel(function(event, delta) {
              this.scrollLeft -= delta * 200;
              event.preventDefault();
        });
    }

}

function ImageGallery() {
    this.scrolled = 0;
    this.timer;
    this.images_list = [];

    this.scroll_speed = 250;
    this.step = 128;
    this.close_timeout = 380;

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
            this.scrolled = 0;
            $(this).children('div.switcher').scrollLeft(0);
        });

        $(document).on('click', 'div.gallery > div.switcher > picture', function(e) {
            totok.selectImage($(this));
            totok.stopEvents(e);
        });

        $(document).on('click', 'div.body > span', function(e) {
            totok.switchImage($(this));
            totok.stopEvents(e);
        });

        $(document).on('mousedown', 'div.gallery > div.switcher > span > p', function(e) {
            totok.scrollWithArrows($(this));
            totok.stopEvents(e);
        }).on('mouseup', 'div.gallery > div.switcher > span > p', function(e) {
            clearInterval(totok.timer);
            totok.stopEvents(e);
        });

        $(document).find('div.switcher').on('scroll', function() {
            totok.hideArrowsBasedOnScroll($(this));
            //logger("Iide");
        });

        this.disableImportantClicks();
    },

    loadImagesList: function() {
        var totok = this;
        this.images_list = [];
        var imgs_obj = $(document).find('div.gallery').children('body').find('img');
        //var len = imgs_obj.length;
        //var i = 0;
        imgs_obj.each(function() {
            var url = $(this).attr('src').replace('/preview_', '/max_');
            totok.images_list.push(url);
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
        setTimeout(function() {
            $(document).find('body').hideScrollbars(false);
        }, this.close_timeout);
    },

    selectImage: function(pic) {
        var pic_to_show = pic.children('img').attr('src').replace(/\/(preview_|thumb_)/, '/max_');
        var gallery = $(document).find('div.gallery');
        gallery.children('div.body').find('img').attr('src', pic_to_show);
        this.prelightSelectedIcon(pic_to_show);
    },

    switchImage: function(ref) {
        if (ref.hasClass('left')) {
            this.prevImage();
        } else if (ref.hasClass('right')) {
            this.nextImage();
        } else if (ref.hasClass('close')) {
            this.closeViewer($('div.gallery'));
        }
    },

    prevImage: function() {

    },

    nextImage: function() {

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
        var toto = this;
        ref.mousewheel(function(event, delta) {
            this.scrollLeft -= delta * toto.step;
            event.preventDefault();
            //logger("skroluje");
            this.scrolled = ref.scrollLeft();
        });
    },

    hideArrowsBasedOnScroll: function(ref) {
        //logger('scrolled');
        this.scrolled = ref.scrollLeft();
        //logger(ref.scrollLeft());
        var left_arrow = ref.children('span.left');
        var right_arrow = ref.children('span.right');
        var full_width = ref.get(0).scrollWidth;

        //logger($('div.switcher').get(0).scrollWidth);
        if (this.scrolled <= 0) {
            left_arrow.addClass('hidden');
        } else {
            left_arrow.removeClass('hidden');
        }
        if (this.scrolled + ref.width() == full_width) {
            right_arrow.addClass('hidden');
        } else {
            right_arrow.removeClass('hidden');
        }
    },

    scrollWithArrows: function(ref) {
        var toto = this;
        var direction = ref.parent().attr('class');
        var fx;

        if (direction == 'left') {
            fx = function() {
                $('div.switcher').stop().animate({ scrollLeft: toto.scrolled-toto.step }, toto.scroll_speed);
            };
        } else {
            fx = function() {
                $('div.switcher').stop().animate({ scrollLeft: toto.scrolled+toto.step }, toto.scroll_speed);
            };
        }

        this.timer = setInterval(fx, this.scroll_speed+2);
    },

    disableImportantClicks: function() {
        var totok = this;
        $(document).on('click', 'div.gallery > div.switcher', function(e) {
            totok.stopEvents(e);
        });
        $(document).on('click', 'div.body > picture > img', function(e) {
            totok.stopEvents(e);
        });
    },

    stopEvents: function(e) {
        e.preventDefault();
        e.stopPropagation();
        e.stopImmediatePropagation();
    }

}

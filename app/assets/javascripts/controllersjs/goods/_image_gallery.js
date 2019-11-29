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
        totok.loadImagesList();

        $(document).on('click', 'div.images.gallery_set > picture', function() {
            var sw = $(document).find('div.gallery').children('div.switcher');
            totok.openViewer($(this));
            totok.hideArrowsBasedOnScroll(sw);
        });

        $(document).on('click', 'div.gallery', function() {
            totok.closeViewer($(this));
            totok.scrolled = 0;
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

        $(document).on('click', 'div.gallery > div.switcher', function(e) {
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
        });

        $(document).on('click', 'div.body > picture > img', function(e) {
            totok.stopEvents(e);
        });

        $(document).on('change', 'div.switcher', function(e) {
            totok.alignScrollbar($(this));
            totok.stopEvents(e);
        });
    },

    loadImagesList: function() {
        var totok = this;
        this.images_list = [];
        var imgs_obj = $(document).find('div.gallery_set').children('picture').find('img');
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
        var pic_to_show = "";
        if (typeof(pic) == "string") {
            pic_to_show = pic;
        } else {
            pic_to_show = pic.children('img').attr('src').replace(/\/(preview_|thumb_)/, '/max_');
        }
        var gallery = $(document).find('div.gallery');
        gallery.children('div.body').find('img').attr('src', pic_to_show);
        this.prelightSelectedIcon(pic_to_show);
        $(document).find('div.switcher').trigger('change');
    },

    switchImage: function(ref) {
        var img_index = this.images_list.indexOf(
            $(document).find('div.gallery').find('img').attr('src')
        );
        if (ref.hasClass('left')) {
            this.prevImage(img_index);
        } else if (ref.hasClass('right')) {
            this.nextImage(img_index);
        } else if (ref.hasClass('close')) {
            this.closeViewer($('div.gallery'));
        }
        logger("image switched");
    },

    prevImage: function(i) {
        var prev = (i == 0) ? (this.images_list.length-1) : (i-1);
        this.selectImage(this.images_list[prev]);
    },

    nextImage: function(i) {
        var next = (i+1 < this.images_list.length) ? i+1 : 0;
        this.selectImage(this.images_list[next]);
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
            this.scrolled = ref.scrollLeft();
        });
    },

    hideArrowsBasedOnScroll: function(ref) {
        this.scrolled = ref.scrollLeft();
        var left_arrow = ref.children('span.left');
        var right_arrow = ref.children('span.right');
        var full_width = ref.get(0).scrollWidth;

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
        logger("ide");
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

    alignScrollbar: function(ref) {
        var padding = 24;
        var scrolled = ref.scrollLeft();
        var checked_element_pos = ref.children('picture.selected').position().left + scrolled;
        var checked_element_width = ref.children('picture.selected').outerWidth();
        var full_area_width = ref.get(0).scrollWidth;
        var visible_width = ref.width();
        var visible_range_start = scrolled;
        var visible_range_end = scrolled + visible_width;
        var misalign = 0;

        if (checked_element_pos + checked_element_width + padding == full_area_width) {
            misalign = full_area_width - visible_width;
        } else if (checked_element_pos == 0) {
            misalign = -scrolled;
        } else if (checked_element_pos - padding*2 <= visible_range_start) {
            misalign = -checked_element_width;
        } else if (checked_element_pos + checked_element_width + padding*2 >= visible_range_end) {
            misalign = checked_element_width;
        }

        ref.scrollLeft(scrolled + misalign);
    },

    stopEvents: function(e) {
        e.preventDefault();
        e.stopPropagation();
        e.stopImmediatePropagation();
    }

}

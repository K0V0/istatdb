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
            totok.openViewer($(this));
        });

        $(document).on('click', 'div.gallery', function() {
            totok.closeViewer($(this));
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

    loadImagePreviews: function(ref) {
        prev_elem = ref.children('span.left');
        var no_of_images = this.images_list.length;
        this.images_list.forEach(function(elem, index) {
            var url = elem.replace('/max_', '/thumb_');
            var new_elem = $('<picture><img src="'+url+'"></picture>');
            if (index == 0) { new_elem.addClass('first'); }
            if (index+1 == no_of_images) { new_elem.addClass('last'); }
            new_elem.insertAfter(prev_elem);
            prev_elem = new_elem;
        });
    },

    openViewer: function(pic) {
        this.loadImagesList();
        var sw = $(document).find('div.gallery').children('div.switcher');
        this.loadImagePreviews(sw);
        this.selectImage(pic);
        this.scrollHorizont(sw);
        this.hideArrowsBasedOnScroll(sw);
        $(document).find('body').hideScrollbars(true);
        $(document).find('div.gallery').addClass('visible');
    },

    closeViewer: function(gal) {
        var toto = this;
        var sw = gal.children('div.switcher');
        gal.removeClass('visible');
        toto.images_list = [];
        setTimeout(function() {
            $(document).find('body').hideScrollbars(false);
            sw.children('picture').remove();
            toto.scrolled = 0;
            sw.scrollLeft(0);
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
        });
    },

    hideArrowsBasedOnScroll: function(ref) {
        var left_arrow = ref.children('span.left');
        var right_arrow = ref.children('span.right');
        ref.waitForImages(function() {
            var full_width = $(this).get(0).scrollWidth;
            var scrolled = $(this).scrollLeft();
            if (scrolled <= 0) {
                left_arrow.addClass('hidden');
            } else {
                left_arrow.removeClass('hidden');
            }
            if (scrolled + $(this).width() == full_width) {
                right_arrow.addClass('hidden');
            } else {
                right_arrow.removeClass('hidden');
            }
        });
    },

    scrollWithArrows: function(ref) {
        var toto = this;
        var direction = ref.parent().attr('class');
        var sw = ref.closest('div.switcher');
        toto.scrolled = sw.scrollLeft();
        var smer;
        var fx;
        if (direction == 'left') { smer = -1; }
        else { smer = 1; }
        fx = function() {
            $('div.switcher')
                .stop()
                .animate({ scrollLeft: toto.scrolled+(toto.step*smer) }, toto.scroll_speed, function() {
                    toto.scrolled = sw.scrollLeft();
                });
        };
        this.timer = setInterval(fx, this.scroll_speed+100);
    },

    alignScrollbar: function(ref) {
        var padding = 24;
        var scrolled = ref.scrollLeft();
        var checked_element_pos = 0;
        var checked_element_width = 0;
        var selected_pic = ref.children('picture.selected');
        if (selected_pic.length > 0) {
            checked_element_pos = ref.children('picture.selected').position().left + scrolled;
            checked_element_width = ref.children('picture.selected').outerWidth();
        }
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

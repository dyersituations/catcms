
/*
Lightbox v2.51
by Lokesh Dhakar - http://www.lokeshdhakar.com

For more information, visit:
http://lokeshdhakar.com/projects/lightbox2/

Licensed under the Creative Commons Attribution 2.5 License - http://creativecommons.org/licenses/by/2.5/
- free for use in both personal and commercial projects
- attribution requires leaving author name, author link, and the license info intact

Thanks
- Scott Upton(uptonic.com), Peter-Paul Koch(quirksmode.com), and Thomas Fuchs(mir.aculo.us) for ideas, libs, and snippets.
- Artemy Tregubenko (arty.name) for cleanup and help in updating to latest proto-aculous in v2.05.


Table of Contents
=================
LightboxOptions

Lightbox
- constructor
- init
- enable
- build
- start
- changeImage
- sizeContainer
- showImage
- updateNav
- updateDetails
- preloadNeigbhoringImages
- enableKeyboardNav
- disableKeyboardNav
- keyboardAction
- end

options = new LightboxOptions
lightbox = new Lightbox options
*/

(function() {
  var $, Lightbox, LightboxOptions;

  $ = jQuery;

  LightboxOptions = (function() {

    function LightboxOptions() {
      this.fileLoadingImage = '../lightbox/loading.gif';
      this.fileCloseImage = '../lightbox/close.png';
      this.resizeDuration = 500;
      this.fadeDuration = 500;
      this.labelImage = "Image";
      this.labelOf = "of";
    }

    return LightboxOptions;

  })();

  Lightbox = (function() {

    function Lightbox(options) {
      this.options = options;
      this.album = [];
      this.currentImageIndex = void 0;
      this.init();
    }

    Lightbox.prototype.init = function() {
      this.enable();
      return this.build();
    };

    Lightbox.prototype.enable = function() {
      var _this = this;
      return $('body').on('click', 'a[rel^=lightbox], area[rel^=lightbox]', function(e) {
        _this.start($(e.currentTarget));
        return false;
      });
    };

    Lightbox.prototype.build = function() {
      var _this = this;

      var $lightbox = $('<div id="lightbox">').appendTo('body');
      var $wrapper = $('<div id="lb-wrapper">').appendTo($lightbox);

      $('<div id="lb-imgContainer">')
          .append(
              $('<img class="lb-image">'),
              $('<div class="lb-nav">')
                  .append(
                      $('<a class="lb-prev">'),
                      $('<a class="lb-next">')),
              $('<div class="lb-loader">')
                  .append($('<img>', { src: this.options.fileLoadingImage })))
          .appendTo($wrapper);

      $('<div class="lb-dataContainer">')
          .append(
              $('<div class="lb-numAndClose">')
                  .append(
                      $('<span class="lb-number">'),
                      $('<a class="lb-close">')
                          .append($('<img>', { src: this.options.fileCloseImage }))),
              $('<div id="lb-caption">')
                  .append(
                      $('<div id="lb-captionTitle">'),
                      $('<div id="lb-captionContent">')))
          .appendTo($wrapper);

      // Add overlay
      $('<div id="lightboxOverlay">')
        .appendTo("body")
        .hide().on('click', function(e) {
          _this.end();
          return false;
        });

      $lightbox = $('#lightbox').hide();
      $lightbox.find('#lb-imgContainer').on('click', function(e) {
        if ($(e.target).attr('id') === 'lightbox') _this.end();
        return false;
      });
      $lightbox.find('.lb-prev').on('click', function(e) {
        _this.changeImage(_this.currentImageIndex - 1);
        return false;
      });
      $lightbox.find('.lb-next').on('click', function(e) {
        _this.changeImage(_this.currentImageIndex + 1);
        return false;
      });
      $lightbox.find('.lb-loader, .lb-close').on('click', function(e) {
        _this.end();
        return false;
      });
    };

    Lightbox.prototype.start = function($link) {
      var $lightbox, $window, a, i, imageNumber, left, top, _len, _ref;
      $(window).on("resize", this.sizeOverlay);
      $('select, object, embed').css({
        visibility: "hidden"
      });
      $('#lightboxOverlay').width($(document).width()).height($(document).height()).fadeIn(this.options.fadeDuration);
      this.album = [];
      imageNumber = 0;
      if ($link.attr('rel') === 'lightbox') {
        this.album.push({
          link: $link.attr('href'),
          title: $link.attr('data-title'),
          caption: $link.attr('data-caption')
        });
      } else {
        _ref = $($link.prop("tagName") + '[rel="' + $link.attr('rel') + '"]');
        for (i = 0, _len = _ref.length; i < _len; i++) {
          a = _ref[i];
          this.album.push({
            link: $(a).attr('href'),
            title: $(a).attr('data-title'),
            caption: $(a).attr('data-caption')
          });
          if ($(a).attr('href') === $link.attr('href')) imageNumber = i;
        }
      }
      $window = $(window);
      top = $window.scrollTop() + $window.height() / 10;
      left = $window.scrollLeft();
      $lightbox = $('#lightbox');
      $lightbox.css({
        top: top + 'px',
        left: left + 'px'
      }).fadeIn(this.options.fadeDuration);
      this.changeImage(imageNumber);
    };

    Lightbox.prototype.changeImage = function(imageNumber) {
      var $image, $lightbox, preloader,
        _this = this;
      this.disableKeyboardNav();
      $lightbox = $('#lightbox');
      $image = $lightbox.find('.lb-image');
      this.sizeOverlay();
      $('#lightboxOverlay').fadeIn(this.options.fadeDuration);
      $lightbox.find('.lb-image, .lb-nav, .lb-prev, .lb-next, .lb-dataContainer, .lb-numbers, #lb-caption').hide();
      $lightbox.find('.lb-loader').show();
      $lightbox.find('#lb-imgContainer').addClass('animating');
      preloader = new Image;
      preloader.onload = function() {
        $image.attr('src', _this.album[imageNumber].link);
        $image.width = preloader.width;
        $image.height = preloader.height;
        return _this.sizeContainer(preloader.width, preloader.height);
      };
      preloader.src = this.album[imageNumber].link;
      this.currentImageIndex = imageNumber;
    };

    Lightbox.prototype.sizeOverlay = function() {
      return $('#lightboxOverlay').width($(document).width()).height($(document).height());
    };

    Lightbox.prototype.sizeContainer = function(imageWidth, imageHeight) {
      var _this = this;
      var $lightbox = $('#lightbox');
      var $wrapper = $lightbox.find('#lb-wrapper');
      var $container = $wrapper.find('#lb-imgContainer');
      var $data = $wrapper.find('.lb-dataContainer');

      var containerDirectionPadding = parseInt($container.find('img').css('padding-top'), 10) * 2;
      var oldImgContWidth = $container.width() + containerDirectionPadding;
      var oldImgContHeight = $container.height() + containerDirectionPadding;

      var newImgContWidth = imageWidth + containerDirectionPadding;
      var newImgContHeight = imageHeight + containerDirectionPadding;
      var newDataHeight = $data.height();
      var newWrapWidth = newImgContWidth + $data.width() + (parseInt($data.css('padding-left'), 10) * 2);
      var newWrapHeight = newImgContHeight > newDataHeight ? newImgContHeight : newDataHeight;

      if (newImgContWidth !== oldImgContWidth && newImgContHeight !== oldImgContHeight) {
        $container.animate({
          width: newImgContWidth,
          height: newImgContHeight
        }, this.options.resizeDuration, 'swing');
        $wrapper.animate({
          width: newWrapWidth,
          height: newWrapHeight
        }, this.options.resizeDuration, 'swing');
      }
      else if (newImgContWidth !== oldImgContWidth) {
        $container.animate({
          width: newImgContWidth
        }, this.options.resizeDuration, 'swing');
        $wrapper.animate({
          width: newWrapWidth
        }, this.options.resizeDuration, 'swing');
      }
      else if (newImgContHeight !== oldImgContHeight) {
        $container.animate({
          height: newImgContHeight
        }, this.options.resizeDuration, 'swing');
        $wrapper.animate({
          height: newWrapHeight
        }, this.options.resizeDuration, 'swing');
      }

      setTimeout(function() {
        $lightbox.find('.lb-prevLink').height(newImgContHeight);
        $lightbox.find('.lb-nextLink').height(newImgContHeight);
        _this.showImage();
      }, this.options.resizeDuration);
    };

    Lightbox.prototype.showImage = function() {
      var $lightbox;
      $lightbox = $('#lightbox');
      $lightbox.find('.lb-loader').hide();
      $lightbox.find('.lb-image').fadeIn('slow');
      this.updateNav();
      this.updateDetails();
      this.preloadNeighboringImages();
      this.enableKeyboardNav();
    };

    Lightbox.prototype.updateNav = function() {
      var $lightbox;
      $lightbox = $('#lightbox');
      $lightbox.find('.lb-nav').show();
      if (this.currentImageIndex > 0) $lightbox.find('.lb-prev').show();
      if (this.currentImageIndex < this.album.length - 1) {
        $lightbox.find('.lb-next').show();
      }
    };

    Lightbox.prototype.updateDetails = function() {
      var $lightbox,
        _this = this;
      $lightbox = $('#lightbox');
      var $caption = $lightbox.find('#lb-caption');
      if (this.album[this.currentImageIndex].title)
        $caption.find('#lb-captionTitle').text(this.album[this.currentImageIndex].title);
      if (this.album[this.currentImageIndex].caption)
        $caption.find('#lb-captionContent').html(this.album[this.currentImageIndex].caption);
      if (this.album[this.currentImageIndex].title || this.album[this.currentImageIndex].title)
        $caption.fadeIn('fast');
      if (this.album.length > 1) {
        $lightbox.find('.lb-number').html(this.options.labelImage + ' ' + (this.currentImageIndex + 1) + ' ' + this.options.labelOf + '  ' + this.album.length).fadeIn('fast');
      } else {
        $lightbox.find('.lb-number').hide();
      }
      $lightbox.find('#lb-imgContainer').removeClass('animating');
      $lightbox.find('.lb-dataContainer').fadeIn(this.resizeDuration, function() {
        return _this.sizeOverlay();
      });
    };

    Lightbox.prototype.preloadNeighboringImages = function() {
      var preloadNext, preloadPrev;
      if (this.album.length > this.currentImageIndex + 1) {
        preloadNext = new Image;
        preloadNext.src = this.album[this.currentImageIndex + 1].link;
      }
      if (this.currentImageIndex > 0) {
        preloadPrev = new Image;
        preloadPrev.src = this.album[this.currentImageIndex - 1].link;
      }
    };

    Lightbox.prototype.enableKeyboardNav = function() {
      $(document).on('keyup.keyboard', $.proxy(this.keyboardAction, this));
    };

    Lightbox.prototype.disableKeyboardNav = function() {
      $(document).off('.keyboard');
    };

    Lightbox.prototype.keyboardAction = function(event) {
      var KEYCODE_ESC, KEYCODE_LEFTARROW, KEYCODE_RIGHTARROW, key, keycode;
      KEYCODE_ESC = 27;
      KEYCODE_LEFTARROW = 37;
      KEYCODE_RIGHTARROW = 39;
      keycode = event.keyCode;
      key = String.fromCharCode(keycode).toLowerCase();
      if (keycode === KEYCODE_ESC || key.match(/x|o|c/)) {
        this.end();
      } else if (key === 'p' || keycode === KEYCODE_LEFTARROW) {
        if (this.currentImageIndex !== 0) {
          this.changeImage(this.currentImageIndex - 1);
        }
      } else if (key === 'n' || keycode === KEYCODE_RIGHTARROW) {
        if (this.currentImageIndex !== this.album.length - 1) {
          this.changeImage(this.currentImageIndex + 1);
        }
      }
    };

    Lightbox.prototype.end = function() {
      this.disableKeyboardNav();
      $(window).off("resize", this.sizeOverlay);
      $('#lightbox').fadeOut(this.options.fadeDuration);
      $('#lightboxOverlay').fadeOut(this.options.fadeDuration);
      return $('select, object, embed').css({
        visibility: "visible"
      });
    };

    return Lightbox;

  })();

  $(function() {
    var lightbox, options;
    options = new LightboxOptions;
    return lightbox = new Lightbox(options);
  });

}).call(this);
// ==UserScript==
// @name           4chan x
// @version        2.38.5
// @namespace      aeosynth
// @description    Adds various features.
// @copyright      2009-2011 James Campos <james.r.campos@gmail.com>
// @copyright      2012 Nicolas Stepien <stepien.nicolas@gmail.com>
// @license        MIT; http://en.wikipedia.org/wiki/Mit_license
// @include        http://boards.4chan.org/*
// @include        https://boards.4chan.org/*
// @include        http://images.4chan.org/*
// @include        https://images.4chan.org/*
// @include        http://sys.4chan.org/*
// @include        https://sys.4chan.org/*
// @grant          GM_getValue
// @grant          GM_setValue
// @grant          GM_deleteValue
// @grant          GM_openInTab
// @run-at         document-start
// @updateURL      https://github.com/ihavenoface/4chan-x/raw/stable/4chan_x.user.js
// @downloadURL    https://github.com/ihavenoface/4chan-x/raw/stable/4chan_x.user.js
// @icon           data:image/gif;base64,R0lGODlhEAAQAKECAAAAAGbMM////////yH5BAEKAAIALAAAAAAQABAAAAIxlI+pq+D9DAgUoFkPDlbs7lGiI2bSVnKglnJMOL6omczxVZK3dH/41AG6Lh7i6qUoAAA7
// ==/UserScript==

/* LICENSE
 *
 * Copyright (c) 2009-2011 James Campos <james.r.campos@gmail.com>
 * Copyright (c) 2012-2013 Nicolas Stepien <stepien.nicolas@gmail.com>
 * http://mayhemydg.github.com/4chan-x/
 * 4chan X 2.38.5
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 *
 * HACKING
 *
 * 4chan X is written in CoffeeScript[1], and developed on GitHub[2].
 *
 * [1]: http://coffeescript.org/
 * [2]: https://github.com/MayhemYDG/4chan-x
 *
 * CONTRIBUTORS
 *
 * noface - bloat
 * desuwa - Firefox filename upload fix
 * seaweed - bottom padding for image hover
 * e000 - cooldown sanity check
 * ahodesuka - scroll back when unexpanding images, file info formatting
 * Shou- - pentadactyl fixes
 * ferongr - new favicons
 * xat- - new favicons
 * Zixaphir - fix qr textarea - captcha-image gap
 * Ongpot - sfw favicon
 * thisisanon - nsfw + 404 favicons
 * Anonymous - empty favicon
 * Seiba - chrome quick reply focusing
 * herpaderpderp - recaptcha fixes
 * WakiMiko - recaptcha tab order http://userscripts.org/scripts/show/82657
 * btmcsweeney - allow users to specify text for sauce links
 *
 * All the people who've taken the time to write bug reports.
 *
 * Thank you.
 */

(function() {
  var $, $$, Anonymize, ArchiveLink, BanChecker, Build, CatalogLinks, Conf, Config, DeleteLink, DownloadLink, EmbedLink, ExpandComment, ExpandThread, Favicon, FileInfo, Filter, Get, IDColor, ImageExpand, ImageHover, ImageReplace, Keybinds, Linkify, Main, Markdown, Menu, Nav, Options, Prefetch, QR, QuoteBacklink, QuoteCT, QuoteInline, QuoteOP, QuotePreview, QuoteYou, Quotify, Redirect, RelativeDates, RemoveSpoilers, ReplyHiding, ReportLink, RevealSpoilers, Sauce, StrikethroughQuotes, ThreadHiding, ThreadStats, Time, TitlePost, UI, Unread, Updater, Watcher, d, g, _base,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  Config = {
    main: {
      Enhancing: {
        'Disable 4chan\'s extension': [true, 'Avoid conflicts between 4chan X and 4chan\'s inline extension'],
        'Catalog Links': [true, 'Turn Navigation links into links to each board\'s catalog'],
        '404 Redirect': [true, 'Redirect dead threads and images'],
        'Keybinds': [true, 'Binds actions to keys'],
        'Time Formatting': [true, 'Arbitrarily formatted timestamps, using your local time'],
        'Relative Post Dates': [false, 'Display dates as "3 minutes ago" f.e., tooltip shows the timestamp'],
        'File Info Formatting': [true, 'Reformats the file information'],
        'Comment Expansion': [true, 'Expand too long comments'],
        'Thread Expansion': [true, 'View all replies'],
        'Index Navigation': [true, 'Navigate to previous / next thread'],
        'Reply Navigation': [false, 'Navigate to top / bottom of thread'],
        'Check for Updates': [true, 'Check for updated versions of 4chan X'],
        'Check for Bans': [false, 'Obtain ban status and prepend it to the top of the page'],
        'Check for Bans constantly': [false, 'Obtain ban status on every refresh. Note that this will cause delay on getting the result']
      },
      Linkification: {
        'Linkify': [true, 'Convert text into links where applicable'],
        'Embed': [true, 'Add a link to supported linkified video and audio links'],
        'Youtube': [true, 'Replace youtube links with its title'],
        'Vimeo': [true, 'Replace vimeo links'],
        'Soundcloud': [true, 'Replace soundcloud links'],
        'Show FavIcons': [true, 'Prepend the site\'s favicon to a replaced title']
      },
      Filtering: {
        'Anonymize': [false, 'Make everybody anonymous'],
        'Filter': [true, 'Self-moderation placebo'],
        'Recursive Filtering': [true, 'Filter replies of filtered posts, recursively'],
        'Reply Hiding': [true, 'Hide single replies'],
        'Thread Hiding': [true, 'Hide entire threads'],
        'Show Stubs': [false, 'Of hidden threads / replies']
      },
      Imaging: {
        'Image Expansion': [true, 'Expand images'],
        'Image Hover': [true, 'Show full image on mouseover'],
        'Sauce': [true, 'Add sauce to images'],
        'Reveal Spoilers': [false, 'Replace spoiler thumbnails by the original thumbnail'],
        'Don\'t Expand Spoilers': [true, 'Don\'t expand spoilers when using ImageExpand'],
        'Expand From Current': [false, 'Expand images from current position to thread end'],
        'Prefetch': [false, 'Prefetch images'],
        'Replace GIF': [false, 'Replace thumbnail of gifs with its actual image'],
        'Replace PNG': [false, 'Replace pngs'],
        'Replace JPG': [false, 'Replace jpgs']
      },
      Menu: {
        'Menu': [true, 'Add a drop-down menu in posts'],
        'Report Link': [true, 'Add a report link to the menu'],
        'Delete Link': [true, 'Add post and image deletion links to the menu'],
        'Download Link': [true, 'Add a download with original filename link to the menu. Chrome-only currently'],
        'Archive Link': [true, 'Add an archive link to the menu'],
        'Embed Link': [true, 'Add an embed link to the menu to embed all supported formats in a post']
      },
      Monitoring: {
        'Thread Updater': [true, 'Update threads. Has more options in its own dialog.'],
        'Optional Increase': [false, 'Increase value of Updater over time.'],
        'Interval per board': [false, 'Change the intervals of updates on a board-by-board basis.'],
        'Unread Count': [true, 'Show unread post count in tab title'],
        'Unread Favicon': [true, 'Show a different favicon when there are unread posts'],
        'Post in Title': [true, 'Show the op\'s post in the tab title'],
        'Thread Stats': [true, 'Display reply and image count'],
        'Thread Watcher': [false, 'Bookmark threads'],
        'Auto Watch': [false, 'Automatically watch threads that you start'],
        'Auto Watch Reply': [false, 'Automatically watch threads that you reply to'],
        'Color user IDs': [true, 'Assign unique colors to user IDs on boards that use them'],
        'Remove Spoilers': [false, 'Remove all spoilers in text']
      },
      Posting: {
        'Quick Reply': [true, 'Reply without leaving the page'],
        'Focus on Alert': [true, 'Switch to tab if an error occurs'],
        'Cooldown': [true, 'Prevent "flood detected" errors'],
        'Validate CAPTCHA': [true, 'Validate cached CAPTCHAs'],
        'Persistent QR': [false, 'The Quick reply won\'t disappear after posting'],
        'Auto Hide QR': [false, 'Automatically hide the quick reply when posting'],
        'Open Reply in New Tab': [false, 'Open replies in a new tab that are made from the main board'],
        'Per Board Persona': [false, 'Remember Name, Email, Subject, etc per board instead of globally'],
        'Remember QR size': [false, 'Remember the size of the Quick reply (Firefox only)'],
        'Remember Subject': [false, 'Remember the subject field, instead of resetting after posting'],
        'Remember Spoiler': [false, 'Remember the spoiler state, instead of resetting after posting'],
        'Remember Sage': [false, 'Remember email even if it contains sage'],
        'Hide Original Post Form': [true, 'Replace the normal post form with a shortcut to open the QR'],
        'Markdown': [false, 'Code, italic, bold, italic bold, double struck - `, *, **, ***, ||, respectively. _ can be used instead of *']
      },
      Quoting: {
        'Quote Backlinks': [true, 'Add quote backlinks'],
        'OP Backlinks': [true, 'Add backlinks to the OP'],
        'Quote Highlighting': [true, 'Highlight the previewed post'],
        'Quote Inline': [true, 'Show quoted post inline on quote click'],
        'QI only on index': [false, 'Only activate Quote Inline on board index'],
        'Quote Preview': [true, 'Show quote content on hover'],
        'Resurrect Quotes': [true, 'Linkify dead quotes to archives'],
        'Indicate OP quote': [true, 'Add \'(OP)\' to OP quotes'],
        'Indicate Quotes of You': [true, 'Add \'(You)\' to your quotes'],
        'Indicate Cross-thread Quotes': [true, 'Add \'(Cross-thread)\' to cross-threads quotes'],
        'Forward Hiding': [true, 'Hide original posts of inlined backlinks']
      }
    },
    filter: {
      name: "# Filter any namefags:\n#/^(?!Anonymous$)/",
      uniqueid: "# Filter a specific ID:\n#/Txhvk1Tl/",
      tripcode: "# Filter any tripfags\n#/^!/",
      mod: "# Set a custom class for mods:\n#/Mod$/;highlight:mod;op:yes\n# Set a custom class for moot:\n#/Admin$/;highlight:moot;op:yes",
      email: "# Filter any e-mails that are not `sage` on /a/ and /jp/:\n#/^(?!sage$)/;boards:a,jp",
      subject: "# Filter Generals on /v/:\n#/general/i;boards:v;op:only'",
      comment: "# Filter Stallman copypasta on /g/:\n#/what you\'re refer+ing to as linux/i;boards:g",
      country: '',
      filename: '',
      dimensions: "# Highlight potential wallpapers:\n#/1920x1080/;op:yes;highlight;top:no;boards:w,wg",
      filesize: '',
      md5: ''
    },
    sauces: "http://iqdb.org/?url=$1\nhttp://www.google.com/searchbyimage?image_url=$1\n#http://tineye.com/search?url=$1\n#http://saucenao.com/search.php?db=999&url=$1\n#http://3d.iqdb.org/?url=$1\n#http://regex.info/exif.cgi?imgurl=$2\n# uploaders:\n#http://imgur.com/upload?url=$2;text:Upload to imgur\n#http://omploader.org/upload?url1=$2;text:Upload to omploader\n# \"View Same\" in archives:\n#http://archive.foolz.us/_/search/image/$3/;text:View same on foolz\n#http://archive.foolz.us/$4/search/image/$3/;text:View same on foolz /$4/\n#https://archive.installgentoo.net/$4/image/$3;text:View same on installgentoo /$4/",
    time: '%m/%d/%y(%a)%H:%M',
    backlink: '>>%id',
    fileInfo: '%L (%p%s, %r)',
    favicon: 'ferongr',
    updateIncrease: '5,10,15,20,30,60,90,120,240,300',
    updateIncreaseB: '5,10,15,20,30,60,90,120,240,300',
    hotkeys: {
      openQR: ['i', 'Open QR with post number inserted'],
      openEmptyQR: ['I', 'Open QR without post number inserted'],
      openOptions: ['ctrl+o', 'Open Options'],
      close: ['Esc', 'Close Options or QR'],
      spoiler: ['ctrl+s', 'Quick spoiler tags'],
      math: ['ctrl+m', 'Quick math tags'],
      eqn: ['ctrl+e', 'Quick eqn tags'],
      code: ['alt+c', 'Quick code tags'],
      sageru: ['alt+n', 'Sage keybind'],
      submit: ['alt+s', 'Submit post'],
      hideQR: ['alt+h', 'Toggle hide status of QR'],
      toggleCatalog: ['alt+t', 'Toggle links in nav bar'],
      watch: ['w', 'Watch thread'],
      update: ['u', 'Update now'],
      unreadCountTo0: ['z', 'Reset unread status'],
      expandImage: ['m', 'Expand selected image'],
      expandAllImages: ['M', 'Expand all images'],
      zero: ['0', 'Jump to page 0'],
      nextPage: ['L', 'Jump to the next page'],
      previousPage: ['H', 'Jump to the previous page'],
      nextThread: ['n', 'See next thread'],
      previousThread: ['p', 'See previous thread'],
      expandThread: ['e', 'Expand thread'],
      openThreadTab: ['o', 'Open thread in new tab'],
      openThread: ['O', 'Open thread in current tab'],
      nextReply: ['J', 'Select next reply'],
      previousReply: ['K', 'Select previous reply'],
      hide: ['x', 'Hide thread']
    },
    updater: {
      checkbox: {
        'Beep': [false, 'Beep on new post to completely read thread'],
        'Scrolling': [false, 'Scroll updated posts into view. Only enabled at bottom of page.'],
        'Scroll BG': [false, 'Scroll background tabs'],
        'Verbose': [true, 'Show countdown timer, new post count'],
        'Auto Update': [true, 'Automatically fetch new posts']
      },
      'Interval': 30,
      'BGInterval': 60
    },
    embedWidth: 640,
    embedHeight: 390
  };

  Conf = {};

  d = document;

  g = {};

  UI = {
    dialog: function(id, position, html) {
      var el;
      el = d.createElement('div');
      el.className = 'reply dialog';
      el.innerHTML = html;
      el.id = id;
      el.style.cssText = localStorage.getItem("" + Main.namespace + id + ".position") || position;
      el.querySelector('.move').addEventListener('mousedown', UI.dragstart, false);
      return el;
    },
    dragstart: function(e) {
      var el, rect;
      e.preventDefault();
      UI.el = el = this.parentNode;
      d.addEventListener('mousemove', UI.drag, false);
      d.addEventListener('mouseup', UI.dragend, false);
      rect = el.getBoundingClientRect();
      UI.dx = e.clientX - rect.left;
      UI.dy = e.clientY - rect.top;
      UI.width = d.documentElement.clientWidth - rect.width;
      return UI.height = d.documentElement.clientHeight - rect.height;
    },
    drag: function(e) {
      var left, style, top;
      left = e.clientX - UI.dx;
      top = e.clientY - UI.dy;
      left = left < 10 ? '0px' : UI.width - left < 10 ? null : left + 'px';
      top = top < 10 ? '0px' : UI.height - top < 10 ? null : top + 'px';
      style = UI.el.style;
      style.left = left;
      style.top = top;
      style.right = left === null ? '0px' : null;
      return style.bottom = top === null ? '0px' : null;
    },
    dragend: function() {
      localStorage.setItem("" + Main.namespace + UI.el.id + ".position", UI.el.style.cssText);
      d.removeEventListener('mousemove', UI.drag, false);
      d.removeEventListener('mouseup', UI.dragend, false);
      return delete UI.el;
    },
    hover: function(e) {
      var clientHeight, clientWidth, clientX, clientY, height, style, top, _ref;
      clientX = e.clientX, clientY = e.clientY;
      style = UI.el.style;
      _ref = d.documentElement, clientHeight = _ref.clientHeight, clientWidth = _ref.clientWidth;
      height = UI.el.offsetHeight;
      top = clientY - 120;
      style.top = clientHeight <= height || top <= 0 ? '0px' : top + height >= clientHeight ? clientHeight - height + 'px' : top + 'px';
      if (clientX <= clientWidth - 400) {
        style.left = clientX + 45 + 'px';
        return style.right = null;
      } else {
        style.left = null;
        return style.right = clientWidth - clientX + 45 + 'px';
      }
    },
    hoverend: function() {
      $.rm(UI.el);
      return delete UI.el;
    }
  };

  /*
  loosely follows the jquery api:
  http://api.jquery.com/
  not chainable
  */


  $ = function(selector, root) {
    if (root == null) {
      root = d.body;
    }
    return root.querySelector(selector);
  };

  $.extend = function(object, properties) {
    var key, val;
    for (key in properties) {
      val = properties[key];
      object[key] = val;
    }
  };

  $.extend($, {
    SECOND: 1000,
    MINUTE: 1000 * 60,
    HOUR: 1000 * 60 * 60,
    DAY: 1000 * 60 * 60 * 24,
    engine: /WebKit|Presto|Gecko/.exec(navigator.userAgent)[0].toLowerCase(),
    log: typeof (_base = console.log).bind === "function" ? _base.bind(console) : void 0,
    ready: function(fc) {
      var cb;
      if (/interactive|complete/.test(d.readyState)) {
        return setTimeout(fc);
      }
      cb = function() {
        $.off(d, 'DOMContentLoaded', cb);
        return fc();
      };
      return $.on(d, 'DOMContentLoaded', cb);
    },
    sync: function(key, cb) {
      key = Main.namespace + key;
      return $.on(window, 'storage', function(e) {
        if (e.key === key) {
          return cb(JSON.parse(e.newValue));
        }
      });
    },
    id: function(id) {
      return d.getElementById(id);
    },
    formData: function(arg) {
      var fd, key, val;
      if (arg instanceof HTMLFormElement) {
        fd = new FormData(arg);
      } else {
        fd = new FormData();
        for (key in arg) {
          val = arg[key];
          if (val) {
            fd.append(key, val);
          }
        }
      }
      return fd;
    },
    ajax: function(url, callbacks, opts) {
      var form, headers, key, r, type, upCallbacks, val;
      if (opts == null) {
        opts = {};
      }
      type = opts.type, headers = opts.headers, upCallbacks = opts.upCallbacks, form = opts.form;
      r = new XMLHttpRequest();
      if ($.engine !== 'webkit') {
        r.overrideMimeType('text/html');
      }
      type || (type = form && 'post' || 'get');
      r.open(type, url, true);
      for (key in headers) {
        val = headers[key];
        r.setRequestHeader(key, val);
      }
      $.extend(r, callbacks);
      $.extend(r.upload, upCallbacks);
      if (type === 'post') {
        r.withCredentials = true;
      }
      r.send(form);
      return r;
    },
    crossAjax: function(url, callbacks, opts) {
      var gmopts, newonload;
      if (opts == null) {
        opts = {};
      }
      if (typeof GM_xmlhttpRequest !== 'undefined') {
        gmopts = {
          url: url,
          data: opts.form,
          method: opts.form ? 'POST' : 'GET',
          onload: callbacks.onload,
          onabort: callbacks.onabort,
          onerror: callbacks.onerror,
          headers: {
            Accept: 'text/html'
          }
        };
        return GM_xmlhttpRequest(gmopts);
      } else {
        if (callbacks.onload) {
          newonload = function() {
            return callbacks.onload({
              readyState: this.readyState,
              responseText: this.responseText,
              status: this.status,
              statusText: this.statusText
            });
          };
          callbacks.onload = newonload;
        }
        return $.ajax(url, callbacks, opts);
      }
    },
    cache: function(url, cb) {
      var req;
      if (req = $.cache.requests[url]) {
        if (req.readyState === 4) {
          return cb.call(req);
        } else {
          return req.callbacks.push(cb);
        }
      } else {
        req = $.ajax(url, {
          onload: function() {
            var _i, _len, _ref, _results;
            _ref = this.callbacks;
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              cb = _ref[_i];
              _results.push(cb.call(this));
            }
            return _results;
          },
          onabort: function() {
            return delete $.cache.requests[url];
          },
          onerror: function() {
            return delete $.cache.requests[url];
          }
        });
        req.callbacks = [cb];
        return $.cache.requests[url] = req;
      }
    },
    cb: {
      checked: function() {
        $.set(this.name, this.checked);
        return Conf[this.name] = this.checked;
      },
      value: function() {
        $.set(this.name, this.value.trim());
        return Conf[this.name] = this.value;
      }
    },
    addStyle: function(css) {
      var f, style;
      style = $.el('style', {
        textContent: css
      });
      f = function() {
        var root;
        if (root = d.head || d.documentElement) {
          return $.add(root, style);
        } else {
          return setTimeout(f, 20);
        }
      };
      f();
      return style;
    },
    x: function(path, root) {
      if (root == null) {
        root = d.body;
      }
      return d.evaluate(path, root, null, 8, null).singleNodeValue;
    },
    addClass: function(el, className) {
      return el.classList.add(className);
    },
    rmClass: function(el, className) {
      return el.classList.remove(className);
    },
    rm: function(el) {
      return el.parentNode.removeChild(el);
    },
    tn: function(s) {
      return d.createTextNode(s);
    },
    nodes: function(nodes) {
      var frag, node, _i, _len;
      if (!(nodes instanceof Array)) {
        return nodes;
      }
      frag = d.createDocumentFragment();
      for (_i = 0, _len = nodes.length; _i < _len; _i++) {
        node = nodes[_i];
        frag.appendChild(node);
      }
      return frag;
    },
    add: function(parent, children) {
      return parent.appendChild($.nodes(children));
    },
    prepend: function(parent, children) {
      return parent.insertBefore($.nodes(children), parent.firstChild);
    },
    after: function(root, el) {
      return root.parentNode.insertBefore($.nodes(el), root.nextSibling);
    },
    before: function(root, el) {
      return root.parentNode.insertBefore($.nodes(el), root);
    },
    replace: function(root, el) {
      return root.parentNode.replaceChild($.nodes(el), root);
    },
    el: function(tag, properties) {
      var el;
      el = d.createElement(tag);
      if (properties) {
        $.extend(el, properties);
      }
      return el;
    },
    on: function(el, events, handler) {
      var event, _i, _len, _ref;
      _ref = events.split(' ');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        event = _ref[_i];
        el.addEventListener(event, handler, false);
      }
    },
    off: function(el, events, handler) {
      var event, _i, _len, _ref;
      _ref = events.split(' ');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        event = _ref[_i];
        el.removeEventListener(event, handler, false);
      }
    },
    open: function(url) {
      return (GM_openInTab || window.open)(location.protocol + url, '_blank');
    },
    event: function(el, e) {
      return el.dispatchEvent(e);
    },
    globalEval: function(code) {
      var script;
      script = $.el('script', {
        textContent: code
      });
      $.add(d.head, script);
      return $.rm(script);
    },
    bytesToString: function(size) {
      var unit;
      unit = 0;
      while (size >= 1024) {
        size /= 1024;
        unit++;
      }
      size = unit > 1 ? Math.round(size * 100) / 100 : Math.round(size);
      return "" + size + " " + ['B', 'KB', 'MB', 'GB'][unit];
    },
    debounce: function(wait, fn) {
      var timeout;
      timeout = null;
      return function() {
        if (timeout) {
          clearTimeout(timeout);
        } else {
          fn.apply(this, arguments);
        }
        return timeout = setTimeout((function() {
          return timeout = null;
        }), wait);
      };
    }
  });

  $.cache.requests = {};

  $.extend($, typeof GM_deleteValue !== "undefined" && GM_deleteValue !== null ? {
    "delete": function(name) {
      name = Main.namespace + name;
      return GM_deleteValue(name);
    },
    get: function(name, defaultValue) {
      var value;
      name = Main.namespace + name;
      if (value = GM_getValue(name)) {
        return JSON.parse(value);
      } else {
        return defaultValue;
      }
    },
    set: function(name, value) {
      name = Main.namespace + name;
      localStorage.setItem(name, JSON.stringify(value));
      return GM_setValue(name, JSON.stringify(value));
    }
  } : {
    "delete": function(name) {
      return localStorage.removeItem(Main.namespace + name);
    },
    get: function(name, defaultValue) {
      var value;
      if (value = localStorage.getItem(Main.namespace + name)) {
        return JSON.parse(value);
      } else {
        return defaultValue;
      }
    },
    set: function(name, value) {
      return localStorage.setItem(Main.namespace + name, JSON.stringify(value));
    }
  });

  $$ = function(selector, root) {
    if (root == null) {
      root = d.body;
    }
    return Array.prototype.slice.call(root.querySelectorAll(selector));
  };

  Markdown = {
    format: function(text) {
      var pattern, tag, tag_patterns;
      tag_patterns = {
        bi: /(\*\*\*|___)(?=\S)([^\r\n]*?\S)\1/g,
        b: /(\*\*|__)(?=\S)([^\r\n]*?\S)\1/g,
        i: /(\*|_)(?=\S)([^\r\n]*?\S)\1/g,
        code: /(`)(?=\S)([^\r\n]*?\S)\1/g,
        ds: /(\|\||__)(?=\S)([^\r\n]*?\S)\1/g
      };
      for (tag in tag_patterns) {
        pattern = tag_patterns[tag];
        text = text ? text.replace(pattern, Markdown.unicode_convert) : '\u0020';
      }
      return text;
    },
    unicode_convert: function(str, tag, inner) {
      var c, charcode, charcodes, codepoints, codes, fmt, i, unicode_text;
      fmt = tag === '_' || tag === '*' ? 'i' : tag === '__' || tag === '**' ? 'b' : tag === '___' || tag === '***' ? 'bi' : tag === '||' ? 'ds' : tag === '`' || tag === '```' ? 'code' : void 0;
      codepoints = {
        b: [0x1D7CE, 0x1D400, 0x1D41A],
        i: [0x1D7F6, 0x1D434, 0x1D44E],
        bi: [0x1D7CE, 0x1D468, 0x1D482],
        code: [0x1D7F6, 0x1D670, 0x1D68A],
        ds: [0x1D7D8, 0x1D538, 0x1D552]
      };
      charcodes = (function() {
        var _i, _len, _results;
        _results = [];
        for (i = _i = 0, _len = inner.length; _i < _len; i = ++_i) {
          c = inner[i];
          _results.push(inner.charCodeAt(i));
        }
        return _results;
      })();
      codes = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = charcodes.length; _i < _len; _i++) {
          charcode = charcodes[_i];
          if (charcode >= 48 && charcode <= 57) {
            _results.push(charcode - 48 + codepoints[fmt][0]);
          } else if (charcode >= 65 && charcode <= 90) {
            _results.push(charcode - 65 + codepoints[fmt][1]);
          } else if (charcode >= 97 && charcode <= 122) {
            if (charcode === 104 && tag === 'i') {
              _results.push(0x210E);
            } else {
              _results.push(charcode - 97 + codepoints[fmt][2]);
            }
          } else {
            _results.push(charcode);
          }
        }
        return _results;
      })();
      unicode_text = codes.map(Markdown.ucs2_encode).join('');
      if (tag === 'code') {
        unicode_text = unicode_text.replace(/\x20/g, '\xA0');
      }
      return unicode_text;
    },
    ucs2_encode: function(value) {
      /*
      From Punycode.js: https://github.com/bestiejs/punycode.js
      
      Copyright Mathias Bynens <http://mathiasbynens.be/>
      
      Permission is hereby granted, free of charge, to any person obtaining
      a copy of this software and associated documentation files (the
      "Software"), to deal in the Software without restriction, including
      without limitation the rights to use, copy, modify, merge, publish,
      distribute, sublicense, and/or sell copies of the Software, and to
      permit persons to whom the Software is furnished to do so, subject to
      the following conditions:
      
      The above copyright notice and this permission notice shall be
      included in all copies or substantial portions of the Software.
      
      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
      EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF`
      MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
      NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
      LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
      OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
      WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
      */

      var output;
      output = '';
      if (value > 0xFFFF) {
        value -= 0x10000;
        output += String.fromCharCode(value >>> 10 & 0x3FF | 0xD800);
        value = 0xDC00 | value & 0x3FF;
      }
      return output += String.fromCharCode(value);
    }
  };

  Filter = {
    filters: {},
    init: function() {
      var boards, filter, hl, key, op, regexp, stub, top, _i, _len, _ref, _ref1, _ref2, _ref3, _ref4;
      for (key in Config.filter) {
        this.filters[key] = [];
        _ref = Conf[key].split('\n');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          filter = _ref[_i];
          if (filter[0] === '#') {
            continue;
          }
          if (!(regexp = filter.match(/\/(.+)\/(\w*)/))) {
            continue;
          }
          filter = filter.replace(regexp[0], '');
          boards = ((_ref1 = filter.match(/boards:([^;]+)/)) != null ? _ref1[1].toLowerCase() : void 0) || 'global';
          if (boards !== 'global' && boards.split(',').indexOf(g.BOARD) === -1) {
            continue;
          }
          if (key === 'md5') {
            regexp = regexp[1];
          } else {
            try {
              regexp = RegExp(regexp[1], regexp[2]);
            } catch (err) {
              alert(err.message);
              continue;
            }
          }
          op = ((_ref2 = filter.match(/[^t]op:(yes|no|only)/)) != null ? _ref2[1] : void 0) || 'no';
          stub = (function() {
            var _ref3;
            switch ((_ref3 = filter.match(/stub:(yes|no)/)) != null ? _ref3[1] : void 0) {
              case 'yes':
                return true;
              case 'no':
                return false;
              default:
                return Conf['Show Stubs'];
            }
          })();
          if (hl = /highlight/.test(filter)) {
            hl = ((_ref3 = filter.match(/highlight:(\w+)/)) != null ? _ref3[1] : void 0) || 'filter_highlight';
            top = ((_ref4 = filter.match(/top:(yes|no)/)) != null ? _ref4[1] : void 0) || 'yes';
            top = top === 'yes';
          }
          this.filters[key].push(this.createFilter(regexp, op, stub, hl, top));
        }
        if (!this.filters[key].length) {
          delete this.filters[key];
        }
      }
      if (Object.keys(this.filters).length) {
        return Main.callbacks.push(this.node);
      }
    },
    createFilter: function(regexp, op, stub, hl, top) {
      var settings, test;
      test = typeof regexp === 'string' ? function(value) {
        return regexp === value;
      } : function(value) {
        return regexp.test(value);
      };
      settings = {
        hide: !hl,
        stub: stub,
        "class": hl,
        top: top
      };
      return function(value, isOP) {
        if (isOP && op === 'no' || !isOP && op === 'only') {
          return false;
        }
        if (!test(value)) {
          return false;
        }
        return settings;
      };
    },
    node: function(post) {
      var filter, firstThread, isOP, key, result, root, thisThread, value, _i, _len, _ref;
      if (post.isInlined) {
        return;
      }
      isOP = post.ID === post.threadID;
      root = post.root;
      for (key in Filter.filters) {
        value = Filter[key](post);
        if (value === false) {
          continue;
        }
        _ref = Filter.filters[key];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          filter = _ref[_i];
          if (!(result = filter(value, isOP))) {
            continue;
          }
          if (result.hide) {
            if (isOP) {
              if (!g.REPLY) {
                ThreadHiding.hide(root.parentNode, result.stub);
              } else {
                continue;
              }
            } else {
              ReplyHiding.hide(root, result.stub);
            }
            return;
          }
          $.addClass(root, result["class"]);
          if (isOP && result.top && !g.REPLY) {
            thisThread = root.parentNode;
            if (firstThread = $('div[class="postContainer opContainer"]')) {
              if (firstThread !== root) {
                $.before(firstThread.parentNode, [thisThread, thisThread.nextElementSibling]);
              }
            }
          }
        }
      }
    },
    name: function(post) {
      return $('.name', post.el).textContent;
    },
    uniqueid: function(post) {
      var uid;
      if (uid = $('.posteruid', post.el)) {
        return uid.textContent.slice(5, -1);
      }
      return false;
    },
    tripcode: function(post) {
      var trip;
      if (trip = $('.postertrip', post.el)) {
        return trip.textContent;
      }
      return false;
    },
    mod: function(post) {
      var mod;
      if (mod = $('.capcode', post.el)) {
        return mod.textContent;
      }
      return false;
    },
    email: function(post) {
      var mail;
      if (mail = $('.useremail', post.el)) {
        return decodeURIComponent(mail.href.slice(7));
      }
      return false;
    },
    subject: function(post) {
      var subject;
      if (subject = $('.postInfo .subject', post.el)) {
        return subject.textContent;
      }
      return false;
    },
    comment: function(post) {
      var data, i, nodes, text, _i, _ref;
      text = [];
      nodes = d.evaluate('.//br|.//text()', post.blockquote, null, 7, null);
      for (i = _i = 0, _ref = nodes.snapshotLength; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        text.push((data = nodes.snapshotItem(i).data) ? data : '\n');
      }
      return text.join('');
    },
    country: function(post) {
      var flag;
      if (flag = $('.countryFlag', post.el)) {
        return flag.title;
      }
      return false;
    },
    filename: function(post) {
      var file, fileInfo;
      fileInfo = post.fileInfo;
      if (fileInfo) {
        if (file = $('.fileText > span', fileInfo)) {
          return file.title;
        } else {
          return fileInfo.firstElementChild.dataset.filename;
        }
      }
      return false;
    },
    dimensions: function(post) {
      var fileInfo, match;
      fileInfo = post.fileInfo;
      if (fileInfo && (match = fileInfo.textContent.match(/\d+x\d+/))) {
        return match[0];
      }
      return false;
    },
    filesize: function(post) {
      var img;
      img = post.img;
      if (img) {
        return img.alt.replace('Spoiler Image, ', '');
      }
      return false;
    },
    md5: function(post) {
      var img;
      img = post.img;
      if (img) {
        return img.dataset.md5;
      }
      return false;
    },
    menuInit: function() {
      var div, entry, type, _i, _len, _ref;
      div = $.el('div', {
        textContent: 'Filter'
      });
      entry = {
        el: div,
        open: function() {
          return true;
        },
        children: []
      };
      _ref = [['Name', 'name'], ['Unique ID', 'uniqueid'], ['Tripcode', 'tripcode'], ['Admin/Mod', 'mod'], ['E-mail', 'email'], ['Subject', 'subject'], ['Comment', 'comment'], ['Country', 'country'], ['Filename', 'filename'], ['Image dimensions', 'dimensions'], ['Filesize', 'filesize'], ['Image MD5', 'md5']];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        type = _ref[_i];
        entry.children.push(Filter.createSubEntry(type[0], type[1]));
      }
      return Menu.addEntry(entry);
    },
    createSubEntry: function(text, type) {
      var el, onclick, open;
      el = $.el('a', {
        href: 'javascript:;',
        textContent: text
      });
      onclick = null;
      open = function(post) {
        var value;
        value = Filter[type](post);
        if (value === false) {
          return false;
        }
        $.off(el, 'click', onclick);
        onclick = function() {
          var re, save, select, ta, tl;
          re = type === 'md5' ? value : value.replace(/\/|\\|\^|\$|\n|\.|\(|\)|\{|\}|\[|\]|\?|\*|\+|\|/g, function(c) {
            if (c === '\n') {
              return '\\n';
            } else if (c === '\\') {
              return '\\\\';
            } else {
              return "\\" + c;
            }
          });
          re = type === 'md5' ? "/" + value + "/" : "/^" + re + "$/";
          if (/\bop\b/.test(post["class"])) {
            re += ';op:yes';
          }
          save = (save = $.get(type, '')) ? "" + save + "\n" + re : re;
          $.set(type, save);
          Options.dialog();
          select = $('select[name=filter]', $.id('options'));
          select.value = type;
          $.event(select, new Event('change'));
          $.id('filter_tab').checked = true;
          ta = select.nextElementSibling;
          tl = ta.textLength;
          ta.setSelectionRange(tl, tl);
          return ta.focus();
        };
        $.on(el, 'click', onclick);
        return true;
      };
      return {
        el: el,
        open: open
      };
    }
  };

  StrikethroughQuotes = {
    init: function() {
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var el, quote, show_stub, _i, _len, _ref;
      if (post.isInlined) {
        return;
      }
      _ref = post.quotes;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        quote = _ref[_i];
        if (!((el = $.id(quote.hash.slice(1))) && quote.hostname === 'boards.4chan.org' && !/catalog$/.test(quote.pathname) && el.hidden)) {
          continue;
        }
        $.addClass(quote, 'filtered');
        if (Conf['Recursive Filtering'] && post.ID !== post.threadID) {
          show_stub = !!$.x('preceding-sibling::div[contains(@class,"stub")]', el);
          ReplyHiding.hide(post.root, show_stub);
        }
      }
    }
  };

  ExpandComment = {
    init: function() {
      var a, _i, _len, _ref;
      _ref = $$('.abbr');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        a = _ref[_i];
        $.on(a.firstElementChild, 'click', ExpandComment.expand);
      }
    },
    expand: function(e) {
      var a, replyID, threadID, _, _ref;
      e.preventDefault();
      _ref = this.href.match(/(\d+)#p(\d+)/), _ = _ref[0], threadID = _ref[1], replyID = _ref[2];
      this.textContent = "Loading No." + replyID + "...";
      a = this;
      return $.cache("//api.4chan.org" + this.pathname + ".json", function() {
        return ExpandComment.parse(this, a, threadID, replyID);
      });
    },
    parse: function(req, a, threadID, replyID) {
      var bq, clone, href, post, posts, quote, quotes, spoilerRange, _i, _j, _len, _len1;
      if (req.status !== 200) {
        a.textContent = "" + req.status + " " + req.statusText;
        return;
      }
      posts = JSON.parse(req.response).posts;
      if (spoilerRange = posts[0].custom_spoiler) {
        Build.spoilerRange[g.BOARD] = spoilerRange;
      }
      replyID = +replyID;
      for (_i = 0, _len = posts.length; _i < _len; _i++) {
        post = posts[_i];
        if (post.no === replyID) {
          break;
        }
      }
      if (post.no !== replyID) {
        a.textContent = 'No.#{replyID} not found.';
        return;
      }
      bq = $.id("m" + replyID);
      clone = bq.cloneNode(false);
      clone.innerHTML = post.com;
      quotes = clone.getElementsByClassName('quotelink');
      for (_j = 0, _len1 = quotes.length; _j < _len1; _j++) {
        quote = quotes[_j];
        href = quote.getAttribute('href');
        if (href[0] === '/') {
          continue;
        }
        quote.href = "res/" + href;
      }
      post = {
        blockquote: clone,
        threadID: threadID,
        quotes: quotes,
        backlinks: []
      };
      if (Conf['Linkify']) {
        Linkify.node(post);
      }
      if (Conf['Resurrect Quotes']) {
        Quotify.node(post);
      }
      if (Conf['Quote Preview']) {
        QuotePreview.node(post);
      }
      if (Conf['Quote Inline']) {
        QuoteInline.node(post);
      }
      if (Conf['Indicate OP quote']) {
        QuoteOP.node(post);
      }
      if (Conf['Indicate Quotes of You']) {
        QuoteYou.node(post);
      }
      if (Conf['Indicate Cross-thread Quotes']) {
        QuoteCT.node(post);
      }
      $.replace(bq, clone);
      return Main.prettify(clone);
    }
  };

  ExpandThread = {
    init: function() {
      var a, span, _i, _len, _ref, _results;
      _ref = $$('.summary');
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        span = _ref[_i];
        a = $.el('a', {
          textContent: "+ " + span.textContent,
          className: 'summary desktop',
          href: 'javascript:;'
        });
        $.on(a, 'click', function() {
          return ExpandThread.toggle(this.parentNode);
        });
        _results.push($.replace(span, a));
      }
      return _results;
    },
    toggle: function(thread) {
      var a, num, replies, reply, url, _i, _len;
      url = "//api.4chan.org/" + g.BOARD + "/res/" + thread.id.slice(1) + ".json";
      a = $('.summary', thread);
      switch (a.textContent[0]) {
        case '+':
          a.textContent = a.textContent.replace('+', '× Loading...');
          $.cache(url, function() {
            return ExpandThread.parse(this, thread, a);
          });
          break;
        case '×':
          a.textContent = a.textContent.replace('× Loading...', '+');
          $.cache.requests[url].abort();
          break;
        case '-':
          a.textContent = a.textContent.replace('-', '+');
          num = (function() {
            switch (g.BOARD) {
              case 'b':
              case 'vg':
              case 'q':
                return 3;
              case 't':
                return 1;
              default:
                return 5;
            }
          })();
          replies = $$('.replyContainer', thread);
          replies.splice(replies.length - num, num);
          for (_i = 0, _len = replies.length; _i < _len; _i++) {
            reply = replies[_i];
            $.rm(reply);
          }
      }
    },
    parse: function(req, thread, a) {
      var backlink, id, link, nodes, post, posts, replies, reply, spoilerRange, threadID, _i, _j, _k, _len, _len1, _len2, _ref, _ref1;
      if (req.status !== 200) {
        a.textContent = "" + req.status + " " + req.statusText;
        $.off(a, 'click', ExpandThread.cb.toggle);
        return;
      }
      a.textContent = a.textContent.replace('× Loading...', '-');
      posts = JSON.parse(req.response).posts;
      if (spoilerRange = posts[0].custom_spoiler) {
        Build.spoilerRange[g.BOARD] = spoilerRange;
      }
      replies = posts.slice(1);
      threadID = thread.id.slice(1);
      nodes = [];
      for (_i = 0, _len = replies.length; _i < _len; _i++) {
        reply = replies[_i];
        post = Build.postFromObject(reply, g.BOARD);
        id = reply.no;
        link = $('a[title="Highlight this post"]', post);
        link.href = "res/" + threadID + "#p" + id;
        link.nextSibling.href = "res/" + threadID + "#q" + id;
        nodes.push(post);
      }
      _ref = $$('.summary ~ .replyContainer', a.parentNode);
      for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
        post = _ref[_j];
        $.rm(post);
      }
      _ref1 = $$('.backlink', a.previousElementSibling);
      for (_k = 0, _len2 = _ref1.length; _k < _len2; _k++) {
        backlink = _ref1[_k];
        if (!$.id(backlink.hash.slice(1))) {
          $.rm(backlink);
        }
      }
      return $.after(a, nodes);
    }
  };

  ThreadHiding = {
    init: function() {
      var a, hiddenThreads, thread, _i, _len, _ref;
      hiddenThreads = ThreadHiding.sync();
      if (g.CATALOG) {
        return;
      }
      _ref = $$('.thread');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        thread = _ref[_i];
        a = $.el('a', {
          className: 'hide_thread_button',
          innerHTML: '<span>[ - ]</span>',
          href: 'javascript:;'
        });
        $.on(a, 'click', ThreadHiding.cb);
        $.prepend(thread, a);
        if (thread.id.slice(1) in hiddenThreads) {
          ThreadHiding.hide(thread);
        }
      }
    },
    sync: function() {
      var hiddenThreads, hiddenThreadsCatalog, id;
      hiddenThreads = $.get("hiddenThreads/" + g.BOARD + "/", {});
      hiddenThreadsCatalog = JSON.parse(localStorage.getItem("4chan-hide-t-" + g.BOARD)) || {};
      if (g.CATALOG) {
        for (id in hiddenThreads) {
          hiddenThreadsCatalog[id] = true;
        }
        localStorage.setItem("4chan-hide-t-" + g.BOARD, JSON.stringify(hiddenThreadsCatalog));
      } else {
        for (id in hiddenThreadsCatalog) {
          if (!(id in hiddenThreads)) {
            hiddenThreads[id] = Date.now();
          }
        }
        $.set("hiddenThreads/" + g.BOARD + "/", hiddenThreads);
      }
      return hiddenThreads;
    },
    cb: function() {
      return ThreadHiding.toggle($.x('ancestor::div[parent::div[@class="board"]]', this));
    },
    toggle: function(thread) {
      var hiddenThreads, id;
      hiddenThreads = $.get("hiddenThreads/" + g.BOARD + "/", {});
      id = thread.id.slice(1);
      if (thread.hidden || /\bhidden_thread\b/.test(thread.firstChild.className)) {
        ThreadHiding.show(thread);
        delete hiddenThreads[id];
      } else {
        ThreadHiding.hide(thread);
        hiddenThreads[id] = Date.now();
      }
      return $.set("hiddenThreads/" + g.BOARD + "/", hiddenThreads);
    },
    hide: function(thread, show_stub) {
      var a, menuButton, num, opInfo, span, stub, text;
      if (show_stub == null) {
        show_stub = Conf['Show Stubs'];
      }
      if (!show_stub) {
        thread.hidden = true;
        thread.nextElementSibling.hidden = true;
        return;
      }
      if (/\bhidden_thread\b/.test(thread.firstChild.className)) {
        return;
      }
      num = 0;
      if (span = $('.summary', thread)) {
        num = Number(span.textContent.match(/\d+/));
      }
      num += $$('.opContainer ~ .replyContainer', thread).length;
      text = num === 1 ? '1 reply' : "" + num + " replies";
      opInfo = $('.desktop > .nameBlock', thread).textContent;
      stub = $.el('div', {
        className: 'hide_thread_button hidden_thread',
        innerHTML: '<a href="javascript:;"><span>[ + ]</span> </a>'
      });
      a = stub.firstChild;
      $.on(a, 'click', ThreadHiding.cb);
      $.add(a, $.tn("" + opInfo + " (" + text + ")"));
      if (Conf['Menu']) {
        menuButton = Menu.a.cloneNode(true);
        $.on(menuButton, 'click', Menu.toggle);
        $.add(stub, [$.tn(' '), menuButton]);
      }
      return $.prepend(thread, stub);
    },
    show: function(thread) {
      var stub;
      if (stub = $('.hidden_thread', thread)) {
        $.rm(stub);
      }
      thread.hidden = false;
      return thread.nextElementSibling.hidden = false;
    }
  };

  ReplyHiding = {
    init: function() {
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var side;
      if (post.isInlined || post.ID === post.threadID) {
        return;
      }
      side = $('.sideArrows', post.root);
      $.addClass(side, 'hide_reply_button');
      side.innerHTML = '<a href="javascript:;"><span>[ - ]</span></a>';
      $.on(side.firstChild, 'click', ReplyHiding.toggle);
      if (post.ID in g.hiddenReplies) {
        return ReplyHiding.hide(post.root);
      }
    },
    toggle: function() {
      var button, id, quote, quotes, root, _i, _j, _len, _len1;
      button = this.parentNode;
      root = button.parentNode;
      id = root.id.slice(2);
      quotes = $$(".quotelink[href$='#p" + id + "'], .backlink[href$='#p" + id + "']");
      if (/\bstub\b/.test(button.className)) {
        ReplyHiding.show(root);
        $.rmClass(root, 'hidden');
        for (_i = 0, _len = quotes.length; _i < _len; _i++) {
          quote = quotes[_i];
          $.rmClass(quote, 'filtered');
        }
        delete g.hiddenReplies[id];
      } else {
        ReplyHiding.hide(root);
        for (_j = 0, _len1 = quotes.length; _j < _len1; _j++) {
          quote = quotes[_j];
          $.addClass(quote, 'filtered');
        }
        g.hiddenReplies[id] = Date.now();
      }
      return $.set("hiddenReplies/" + g.BOARD + "/", g.hiddenReplies);
    },
    hide: function(root, show_stub) {
      var a, el, menuButton, side, stub;
      if (show_stub == null) {
        show_stub = Conf['Show Stubs'];
      }
      side = $('.sideArrows', root);
      $.addClass(side.parentNode, 'hidden');
      if (side.hidden) {
        return;
      }
      side.hidden = true;
      el = side.nextElementSibling;
      el.hidden = true;
      if (!show_stub) {
        return;
      }
      stub = $.el('div', {
        className: 'hide_reply_button stub',
        innerHTML: '<a href="javascript:;"><span>[ + ]</span> </a>'
      });
      a = stub.firstChild;
      $.on(a, 'click', ReplyHiding.toggle);
      $.add(a, $.tn(Conf['Anonymize'] ? 'Anonymous' : $('.desktop > .nameBlock', el).textContent));
      if (Conf['Menu']) {
        menuButton = Menu.a.cloneNode(true);
        $.on(menuButton, 'click', Menu.toggle);
        $.add(stub, [$.tn(' '), menuButton]);
      }
      return $.prepend(root, stub);
    },
    show: function(root) {
      var stub;
      if (stub = $('.stub', root)) {
        $.rm(stub);
      }
      $('.sideArrows', root).hidden = false;
      return $('.post', root).hidden = false;
    }
  };

  Menu = {
    entries: [],
    init: function() {
      this.a = $.el('a', {
        className: 'menu_button',
        href: 'javascript:;',
        innerHTML: '[<span></span>]'
      });
      this.el = $.el('div', {
        className: 'reply dialog',
        id: 'menu',
        tabIndex: 0
      });
      $.on(this.el, 'click', function(e) {
        return e.stopPropagation();
      });
      $.on(this.el, 'keydown', this.keybinds);
      $.on(d, 'AddMenuEntry', function(e) {
        return Menu.addEntry(e.detail);
      });
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var a;
      if (post.isInlined && !post.isCrosspost) {
        a = $('.menu_button', post.el);
      } else {
        a = Menu.a.cloneNode(true);
        $.add($('.postInfo', post.el), [$.tn('\u00A0'), a]);
      }
      return $.on(a, 'click', Menu.toggle);
    },
    toggle: function(e) {
      var lastOpener, post;
      e.preventDefault();
      e.stopPropagation();
      if (Menu.el.parentNode) {
        lastOpener = Menu.lastOpener;
        Menu.close();
        if (lastOpener === this) {
          return;
        }
      }
      Menu.lastOpener = this;
      post = /\bhidden_thread\b/.test(this.parentNode.className) ? $.x('ancestor::div[parent::div[@class="board"]]/child::div[contains(@class,"opContainer")]', this) : $.x('ancestor::div[contains(@class,"postContainer")][1]', this);
      return Menu.open(this, Main.preParse(post));
    },
    open: function(button, post) {
      var bLeft, bRect, bTop, el, entry, funk, mRect, _i, _len, _ref;
      el = Menu.el;
      el.setAttribute('data-id', post.ID);
      el.setAttribute('data-rootid', post.root.id);
      funk = function(entry, parent) {
        var child, children, subMenu, _i, _len;
        children = entry.children;
        if (!entry.open(post)) {
          return;
        }
        $.add(parent, entry.el);
        if (!children) {
          return;
        }
        if (subMenu = $('.subMenu', entry.el)) {
          $.rm(subMenu);
        }
        subMenu = $.el('div', {
          className: 'reply dialog subMenu'
        });
        $.add(entry.el, subMenu);
        for (_i = 0, _len = children.length; _i < _len; _i++) {
          child = children[_i];
          funk(child, subMenu);
        }
      };
      _ref = Menu.entries;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        entry = _ref[_i];
        funk(entry, el);
      }
      Menu.focus($('.entry', Menu.el));
      $.on(d, 'click', Menu.close);
      $.add(d.body, el);
      mRect = el.getBoundingClientRect();
      bRect = button.getBoundingClientRect();
      bTop = d.documentElement.scrollTop + d.body.scrollTop + bRect.top;
      bLeft = d.documentElement.scrollLeft + d.body.scrollLeft + bRect.left;
      el.style.top = bRect.top + bRect.height + mRect.height < d.documentElement.clientHeight ? bTop + bRect.height + 2 + 'px' : bTop - mRect.height - 2 + 'px';
      el.style.left = bRect.left + mRect.width < d.documentElement.clientWidth ? bLeft + 'px' : bLeft + bRect.width - mRect.width + 'px';
      return el.focus();
    },
    close: function() {
      var el, focused, _i, _len, _ref;
      el = Menu.el;
      $.rm(el);
      _ref = $$('.focused.entry', el);
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        focused = _ref[_i];
        $.rmClass(focused, 'focused');
      }
      el.innerHTML = null;
      el.removeAttribute('style');
      delete Menu.lastOpener;
      delete Menu.focusedEntry;
      return $.off(d, 'click', Menu.close);
    },
    keybinds: function(e) {
      var el, next, subMenu;
      el = Menu.focusedEntry;
      switch (Keybinds.keyCode(e) || e.keyCode) {
        case 'Esc':
          Menu.lastOpener.focus();
          Menu.close();
          break;
        case 13:
        case 32:
          el.click();
          break;
        case 'Up':
          if (next = el.previousElementSibling) {
            Menu.focus(next);
          }
          break;
        case 'Down':
          if (next = el.nextElementSibling) {
            Menu.focus(next);
          }
          break;
        case 'Right':
          if ((subMenu = $('.subMenu', el)) && (next = subMenu.firstElementChild)) {
            Menu.focus(next);
          }
          break;
        case 'Left':
          if (next = $.x('parent::*[contains(@class,"subMenu")]/parent::*', el)) {
            Menu.focus(next);
          }
          break;
        default:
          return;
      }
      e.preventDefault();
      return e.stopPropagation();
    },
    focus: function(el) {
      var focused, _i, _len, _ref;
      if (focused = $.x('parent::*/child::*[contains(@class,"focused")]', el)) {
        $.rmClass(focused, 'focused');
      }
      _ref = $$('.focused', el);
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        focused = _ref[_i];
        $.rmClass(focused, 'focused');
      }
      Menu.focusedEntry = el;
      return $.addClass(el, 'focused');
    },
    addEntry: function(entry) {
      var funk;
      funk = function(entry) {
        var child, children, el, _i, _len;
        el = entry.el, children = entry.children;
        $.addClass(el, 'entry');
        $.on(el, 'focus mouseover', function(e) {
          e.stopPropagation();
          return Menu.focus(this);
        });
        if (!children) {
          return;
        }
        $.addClass(el, 'hasSubMenu');
        for (_i = 0, _len = children.length; _i < _len; _i++) {
          child = children[_i];
          funk(child);
        }
      };
      funk(entry);
      return Menu.entries.push(entry);
    }
  };

  Keybinds = {
    init: function() {
      var node, _i, _len, _ref;
      _ref = $$('[accesskey]');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        node = _ref[_i];
        node.removeAttribute('accesskey');
      }
      return $.on(d, 'keydown', Keybinds.keydown);
    },
    keydown: function(e) {
      var form, key, o, target, thread;
      if (!(key = Keybinds.keyCode(e))) {
        return;
      }
      target = e.target;
      if (/TEXTAREA|INPUT/.test(target.nodeName)) {
        if (!((key === 'Esc') || (/\+/.test(key)))) {
          return;
        }
      }
      thread = Nav.getThread();
      switch (key) {
        case Conf.openQR:
          Keybinds.qr(thread, true);
          break;
        case Conf.openEmptyQR:
          Keybinds.qr(thread);
          break;
        case Conf.openOptions:
          if (!$.id('overlay')) {
            Options.dialog();
          }
          break;
        case Conf.close:
          if (o = $.id('overlay')) {
            Options.close.call(o);
          } else if (QR.el) {
            if (Conf['Persistent QR']) {
              if (!($('#autohide', QR.el)).checked) {
                QR.hide();
              } else {
                QR.unhide();
              }
            } else {
              QR.close();
            }
          }
          break;
        case Conf.submit:
          if (QR.el && !QR.status()) {
            QR.submit();
          }
          break;
        case Conf.hideQR:
          if (!($('#autohide', QR.el)).checked) {
            QR.hide();
          } else {
            QR.unhide();
          }
          break;
        case Conf.toggleCatalog:
          CatalogLinks.toggle();
          break;
        case Conf.spoiler:
          if (!(($('[name=spoiler]')) && target.nodeName === 'TEXTAREA')) {
            return;
          }
          Keybinds.tags('spoiler', target);
          break;
        case Conf.math:
          if (!((!!$('script[src^="//boards.4chan.org/jsMath/"]', d.head)) && target.nodeName === 'TEXTAREA')) {
            return;
          }
          Keybinds.tags('math', target);
          break;
        case Conf.eqn:
          if (!((!!$('script[src^="//boards.4chan.org/jsMath/"]', d.head)) && target.nodeName === 'TEXTAREA')) {
            return;
          }
          Keybinds.tags('eqn', target);
          break;
        case Conf.code:
          if (!(Main.hasCodeTags && target.nodeName === 'TEXTAREA')) {
            return;
          }
          Keybinds.tags('code', target);
          break;
        case Conf.sageru:
          $("[name=email]", QR.el).value = "sage";
          QR.selected.email = "sage";
          break;
        case Conf.watch:
          Watcher.toggle(thread);
          break;
        case Conf.update:
          Updater.update();
          break;
        case Conf.unreadCountTo0:
          Unread.replies = [];
          Unread.update(true);
          break;
        case Conf.expandImage:
          Keybinds.img(thread);
          break;
        case Conf.expandAllImages:
          Keybinds.img(thread, true);
          break;
        case Conf.zero:
          window.location = "/" + g.BOARD + "/0#delform";
          break;
        case Conf.nextPage:
          if (form = $('.next form')) {
            window.location = form.action;
          }
          break;
        case Conf.previousPage:
          if (form = $('.prev form')) {
            window.location = form.action;
          }
          break;
        case Conf.nextThread:
          if (g.REPLY) {
            return;
          }
          Nav.scroll(+1);
          break;
        case Conf.previousThread:
          if (g.REPLY) {
            return;
          }
          Nav.scroll(-1);
          break;
        case Conf.expandThread:
          ExpandThread.toggle(thread);
          break;
        case Conf.openThread:
          Keybinds.open(thread);
          break;
        case Conf.openThreadTab:
          Keybinds.open(thread, true);
          break;
        case Conf.nextReply:
          Keybinds.hl(+1, thread);
          break;
        case Conf.previousReply:
          Keybinds.hl(-1, thread);
          break;
        case Conf.hide:
          if (/\bthread\b/.test(thread.className)) {
            ThreadHiding.toggle(thread);
          }
          break;
        default:
          return;
      }
      return e.preventDefault();
    },
    keyCode: function(e) {
      var c, kc, key;
      key = (function() {
        switch (kc = e.keyCode) {
          case 8:
            return '';
          case 13:
            return 'Enter';
          case 27:
            return 'Esc';
          case 37:
            return 'Left';
          case 38:
            return 'Up';
          case 39:
            return 'Right';
          case 40:
            return 'Down';
          case 48:
          case 49:
          case 50:
          case 51:
          case 52:
          case 53:
          case 54:
          case 55:
          case 56:
          case 57:
          case 65:
          case 66:
          case 67:
          case 68:
          case 69:
          case 70:
          case 71:
          case 72:
          case 73:
          case 74:
          case 75:
          case 76:
          case 77:
          case 78:
          case 79:
          case 80:
          case 81:
          case 82:
          case 83:
          case 84:
          case 85:
          case 86:
          case 87:
          case 88:
          case 89:
          case 90:
            c = String.fromCharCode(kc);
            if (e.shiftKey) {
              return c;
            } else {
              return c.toLowerCase();
            }
            break;
          default:
            return null;
        }
      })();
      if (key) {
        if (e.altKey) {
          key = 'alt+' + key;
        }
        if (e.ctrlKey) {
          key = 'ctrl+' + key;
        }
        if (e.metaKey) {
          key = 'meta+' + key;
        }
      }
      return key;
    },
    tags: function(tag, ta) {
      var range, selEnd, selStart, value;
      value = ta.value;
      selStart = ta.selectionStart;
      selEnd = ta.selectionEnd;
      ta.value = value.slice(0, selStart) + ("[" + tag + "]") + value.slice(selStart, selEnd) + ("[/" + tag + "]") + value.slice(selEnd);
      range = ("[" + tag + "]").length + selEnd;
      ta.setSelectionRange(range, range);
      return $.event(ta, new Event('input'));
    },
    img: function(thread, all) {
      var thumb;
      if (all) {
        return $.id('imageExpand').click();
      } else {
        thumb = $('img[data-md5]', $('.post.highlight', thread) || thread);
        return ImageExpand.toggle(thumb.parentNode);
      }
    },
    qr: function(thread, quote) {
      if (quote) {
        QR.quote.call($('a[title="Quote this post"]', $('.post.highlight', thread) || thread));
      } else {
        QR.open();
      }
      return $('textarea', QR.el).focus();
    },
    open: function(thread, tab) {
      var id, url;
      if (g.REPLY) {
        return;
      }
      id = thread.id.slice(1);
      url = "//boards.4chan.org/" + g.BOARD + "/res/" + id;
      if (tab) {
        return $.open(url);
      } else {
        return location.href = url;
      }
    },
    hl: function(delta, thread) {
      var next, post, rect, replies, reply, _i, _len;
      if (post = $('.reply.highlight', thread)) {
        $.rmClass(post, 'highlight');
        post.removeAttribute('tabindex');
        rect = post.getBoundingClientRect();
        if (rect.bottom >= 0 && rect.top <= d.documentElement.clientHeight) {
          next = $.x('child::div[contains(@class,"post reply")]', delta === +1 ? post.parentNode.nextElementSibling : post.parentNode.previousElementSibling);
          if (!next) {
            this.focus(post);
            return;
          }
          if (!(g.REPLY || $.x('ancestor::div[parent::div[@class="board"]]', next) === thread)) {
            return;
          }
          rect = next.getBoundingClientRect();
          if (rect.top < 0 || rect.bottom > d.documentElement.clientHeight) {
            next.scrollIntoView(delta === -1);
          }
          this.focus(next);
          return;
        }
      }
      replies = $$('.reply', thread);
      if (delta === -1) {
        replies.reverse();
      }
      for (_i = 0, _len = replies.length; _i < _len; _i++) {
        reply = replies[_i];
        rect = reply.getBoundingClientRect();
        if (delta === +1 && rect.top >= 0 || delta === -1 && rect.bottom <= d.documentElement.clientHeight) {
          this.focus(reply);
          return;
        }
      }
    },
    focus: function(post) {
      $.addClass(post, 'highlight');
      post.tabIndex = 0;
      return post.focus();
    }
  };

  Nav = {
    init: function() {
      var next, prev, span;
      span = $.el('span', {
        id: 'navlinks'
      });
      prev = $.el('a', {
        textContent: '▲',
        href: 'javascript:;'
      });
      next = $.el('a', {
        textContent: '▼',
        href: 'javascript:;'
      });
      $.on(prev, 'click', this.prev);
      $.on(next, 'click', this.next);
      $.add(span, [prev, $.tn(' '), next]);
      return $.add(d.body, span);
    },
    prev: function() {
      if (g.REPLY) {
        return window.scrollTo(0, 0);
      } else {
        return Nav.scroll(-1);
      }
    },
    next: function() {
      if (g.REPLY) {
        return window.scrollTo(0, d.body.scrollHeight);
      } else {
        return Nav.scroll(+1);
      }
    },
    getThread: function(full) {
      var bottom, i, rect, thread, _i, _len, _ref;
      Nav.threads = $$('.thread:not([hidden])');
      _ref = Nav.threads;
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        thread = _ref[i];
        rect = thread.getBoundingClientRect();
        bottom = rect.bottom;
        if (bottom > 0) {
          if (full) {
            return [thread, i, rect];
          }
          return thread;
        }
      }
      return $('.board');
    },
    scroll: function(delta) {
      var i, rect, thread, top, _ref, _ref1;
      _ref = Nav.getThread(true), thread = _ref[0], i = _ref[1], rect = _ref[2];
      top = rect.top;
      if (!((delta === -1 && Math.ceil(top) < 0) || (delta === +1 && top > 1))) {
        i += delta;
      }
      top = (_ref1 = Nav.threads[i]) != null ? _ref1.getBoundingClientRect().top : void 0;
      return window.scrollBy(0, top);
    }
  };

  BanChecker = {
    init: function() {
      this.now = Date.now();
      if (!Conf['Check for Bans constantly'] && $.get('isBanned')) {
        return this.prepend();
      } else if (Conf['Check for Bans constantly'] || $.get('lastBanCheck', 0) < this.now - 6 * $.HOUR) {
        return this.load();
      }
    },
    load: function() {
      this.url = 'https://www.4chan.org/banned';
      return $.ajax(this.url, {
        onloadend: function() {
          var doc, msg;
          if (this.status === 200 || 304) {
            if (!Conf['Check for Bans constantly']) {
              $.set('lastBanCheck', BanChecker.now);
            }
            doc = d.implementation.createHTMLDocument('');
            doc.documentElement.innerHTML = this.response;
            if (/no entry in our database/i.test((msg = $('.boxcontent', doc).textContent.trim()))) {
              $["delete"]('isBanned');
              return $.rm($.id('banChecker'));
            }
            $.set('isBanned', /This ban will not expire/i.test(msg) ? 'You are banned, forever! ;_;' : 'You are banned! ;_;');
            return BanChecker.prepend();
          }
        }
      });
    },
    prepend: function() {
      var el, h1, h2, text, _i, _len, _ref;
      this.text = $.get('isBanned');
      el = $.el('h2', {
        innerHTML: "<span>" + (this.text.match(/^.*(?=banned)/)) + "</span><a href=" + BanChecker.url + " title='Click to find out why.' target=_blank>banned</a><span>" + (this.text.match(/banned.*$/).toString().replace(/^banned/, '')) + "</span>",
        title: 'Click to recheck.',
        id: 'banChecker'
      });
      _ref = [el.firstChild, el.lastChild];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        text = _ref[_i];
        $.on(text, 'click', function() {
          if (!Conf['Check for Bans constantly']) {
            $["delete"]('lastBanCheck');
          }
          $["delete"]('isBanned');
          this.parentNode.style.opacity = '.5';
          return BanChecker.load();
        });
      }
      if (h2 = $.id('banChecker')) {
        return $.replace(h2, el);
      } else if (h1 = $('h1')) {
        return $.after(h1, el);
      } else {
        return $.before($.id('postForm'), el);
      }
    }
  };

  QR = {
    init: function() {
      if (!$.id('postForm')) {
        return;
      }
      Main.callbacks.push(this.node);
      return setTimeout(this.asyncInit);
    },
    asyncInit: function() {
      var link;
      if (Conf['Hide Original Post Form']) {
        link = $.el('h1', {
          innerHTML: "<a href=javascript:;>" + (g.REPLY ? 'Reply to Thread' : 'Start a Thread') + "</a>"
        });
        $.on(link.firstChild, 'click', function() {
          QR.open();
          if (!g.REPLY) {
            QR.threadSelector.value = g.BOARD === 'f' ? '9999' : 'new';
          }
          return $('textarea', QR.el).focus();
        });
        $.before($.id('postForm'), link);
      }
      if (Conf['Check for Bans']) {
        BanChecker.init();
      }
      if (Conf['Persistent QR']) {
        QR.dialog();
        if (Conf['Auto Hide QR']) {
          QR.hide();
        }
      }
      $.on(d, 'dragover', QR.dragOver);
      $.on(d, 'drop', QR.dropFile);
      return $.on(d, 'dragstart dragend', QR.drag);
    },
    node: function(post) {
      return $.on($('a[title="Quote this post"]', $('.postInfo', post.el)), 'click', QR.quote);
    },
    open: function() {
      if (QR.el) {
        QR.el.hidden = false;
        return QR.unhide();
      } else {
        return QR.dialog();
      }
    },
    close: function() {
      var i, spoiler, _i, _len, _ref;
      QR.el.hidden = true;
      QR.abort();
      d.activeElement.blur();
      $.rmClass(QR.el, 'dump');
      _ref = QR.replies;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        i = _ref[_i];
        QR.replies[0].rm();
      }
      QR.cooldown.auto = false;
      QR.status();
      QR.resetFileInput();
      if (!Conf['Remember Spoiler'] && (spoiler = $.id('spoiler')).checked) {
        spoiler.click();
      }
      return QR.cleanError();
    },
    hide: function() {
      d.activeElement.blur();
      $.addClass(QR.el, 'autohide');
      return $.id('autohide').checked = true;
    },
    unhide: function() {
      $.rmClass(QR.el, 'autohide');
      return $.id('autohide').checked = false;
    },
    toggleHide: function() {
      return this.checked && QR.hide() || QR.unhide();
    },
    error: function(err) {
      var el;
      el = $('.warning', QR.el);
      if (typeof err === 'string') {
        el.textContent = err;
      } else {
        el.innerHTML = null;
        $.add(el, err);
      }
      QR.open();
      if (QR.captcha.isEnabled && /captcha|verification/i.test(el.textContent)) {
        $('[autocomplete]', QR.el).focus();
      }
      if (Conf['Focus on Alert'] && d.hidden) {
        return alert(el.textContent);
      }
    },
    cleanError: function() {
      return $('.warning', QR.el).textContent = null;
    },
    status: function(data) {
      var disabled, input, value;
      if (data == null) {
        data = {};
      }
      if (!QR.el) {
        return;
      }
      if (g.dead) {
        value = 404;
        disabled = true;
        QR.cooldown.auto = false;
      }
      value = data.progress || QR.cooldown.seconds || value;
      input = QR.status.input;
      input.value = QR.cooldown.auto && Conf['Cooldown'] ? value ? "Auto " + value : 'Auto' : value || 'Submit';
      return input.disabled = disabled || false;
    },
    cooldown: {
      init: function() {
        if (!Conf['Cooldown']) {
          return;
        }
        QR.cooldown.types = {
          thread: (function() {
            switch (g.BOARD) {
              case 'q':
                return 86400;
              case 'b':
              case 'soc':
              case 'r9k':
                return 600;
              default:
                return 300;
            }
          })(),
          sage: g.BOARD === 'q' ? 600 : 60,
          file: g.BOARD === 'q' ? 300 : 30,
          post: g.BOARD === 'q' ? 60 : 30
        };
        QR.cooldown.cooldowns = $.get("" + g.BOARD + ".cooldown", {});
        QR.cooldown.start();
        return $.sync("" + g.BOARD + ".cooldown", QR.cooldown.sync);
      },
      start: function() {
        if (QR.cooldown.isCounting) {
          return;
        }
        QR.cooldown.isCounting = true;
        return QR.cooldown.count();
      },
      sync: function(cooldowns) {
        var id;
        for (id in cooldowns) {
          QR.cooldown.cooldowns[id] = cooldowns[id];
        }
        return QR.cooldown.start();
      },
      set: function(data) {
        var cooldown, hasFile, isReply, isSage, start, type;
        if (!Conf['Cooldown']) {
          return;
        }
        start = Date.now();
        if (data.delay) {
          cooldown = {
            delay: data.delay
          };
        } else {
          isSage = /sage/i.test(data.post.email);
          hasFile = !!data.post.file;
          isReply = data.isReply;
          type = !isReply ? 'thread' : isSage ? 'sage' : hasFile ? 'file' : 'post';
          cooldown = {
            isReply: isReply,
            isSage: isSage,
            hasFile: hasFile,
            timeout: start + QR.cooldown.types[type] * $.SECOND
          };
        }
        QR.cooldown.cooldowns[start] = cooldown;
        $.set("" + g.BOARD + ".cooldown", QR.cooldown.cooldowns);
        return QR.cooldown.start();
      },
      unset: function(id) {
        delete QR.cooldown.cooldowns[id];
        return $.set("" + g.BOARD + ".cooldown", QR.cooldown.cooldowns);
      },
      count: function() {
        var cooldown, cooldowns, elapsed, hasFile, isReply, isSage, now, post, seconds, start, type, types, update, _ref;
        if (Object.keys(QR.cooldown.cooldowns).length) {
          setTimeout(QR.cooldown.count, 1000);
        } else {
          $["delete"]("" + g.BOARD + ".cooldown");
          delete QR.cooldown.isCounting;
          delete QR.cooldown.seconds;
          QR.status();
          return;
        }
        if ((isReply = g.REPLY ? true : QR.threadSelector.value !== 'new')) {
          post = QR.replies[0];
          isSage = /sage/i.test(post.email);
          hasFile = !!post.file;
        }
        now = Date.now();
        seconds = null;
        _ref = QR.cooldown, types = _ref.types, cooldowns = _ref.cooldowns;
        for (start in cooldowns) {
          cooldown = cooldowns[start];
          if ('delay' in cooldown) {
            if (cooldown.delay) {
              seconds = Math.max(seconds, cooldown.delay--);
            } else {
              seconds = Math.max(seconds, 0);
              QR.cooldown.unset(start);
            }
            continue;
          }
          if (isReply === cooldown.isReply) {
            type = !isReply ? 'thread' : isSage && cooldown.isSage ? 'sage' : hasFile && cooldown.hasFile ? 'file' : 'post';
            elapsed = Math.floor((now - start) / 1000);
            if (elapsed >= 0) {
              seconds = Math.max(seconds, types[type] - elapsed);
            }
          }
          if (!((start <= now && now <= cooldown.timeout))) {
            QR.cooldown.unset(start);
          }
        }
        update = seconds !== null || !!QR.cooldown.seconds;
        QR.cooldown.seconds = seconds;
        if (update) {
          QR.status();
        }
        if (seconds === 0 && QR.cooldown.auto) {
          return QR.submit();
        }
      }
    },
    quote: function(e) {
      var caretPos, id, range, s, sel, ta, text, _ref;
      if (e != null) {
        e.preventDefault();
      }
      QR.open();
      ta = $('textarea', QR.el);
      if (!(g.REPLY || ta.value)) {
        QR.threadSelector.value = $.x('ancestor::div[parent::div[@class="board"]]', this).id.slice(1);
      }
      id = this.previousSibling.hash.slice(2);
      text = ">>" + id + "\n";
      sel = d.getSelection();
      if ((s = sel.toString().trim()) && id === ((_ref = $.x('ancestor-or-self::blockquote', sel.anchorNode)) != null ? _ref.id.match(/\d+$/)[0] : void 0)) {
        s = s.replace(/\n/g, '\n>');
        text += ">" + s + "\n";
      }
      caretPos = ta.selectionStart;
      ta.value = ta.value.slice(0, caretPos) + text + ta.value.slice(ta.selectionEnd);
      range = caretPos + text.length;
      ta.setSelectionRange(range, range);
      ta.focus();
      return $.event(ta, new Event('input'));
    },
    characterCount: function() {
      var count, counter;
      counter = QR.charaCounter;
      count = this.textLength;
      counter.textContent = count;
      counter.hidden = count < 1000;
      return (count > 1500 ? $.addClass : $.rmClass)(counter, 'warning');
    },
    drag: function(e) {
      var toggle;
      toggle = e.type === 'dragstart' ? $.off : $.on;
      toggle(d, 'dragover', QR.dragOver);
      return toggle(d, 'drop', QR.dropFile);
    },
    dragOver: function(e) {
      e.preventDefault();
      return e.dataTransfer.dropEffect = 'copy';
    },
    dropFile: function(e) {
      if (!e.dataTransfer.files.length) {
        return;
      }
      e.preventDefault();
      QR.open();
      QR.fileInput.call(e.dataTransfer);
      return $.addClass(QR.el, 'dump');
    },
    fileInput: function() {
      var file, _i, _len, _ref;
      QR.cleanError();
      if (this.files.length === 1) {
        file = this.files[0];
        if (file.size > this.max) {
          QR.error('File too large.');
          QR.resetFileInput();
        } else if (-1 === QR.mimeTypes.indexOf(file.type)) {
          QR.error('Unsupported file type.');
          QR.resetFileInput();
        } else {
          QR.selected.setFile(file);
        }
        return;
      }
      _ref = this.files;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        file = _ref[_i];
        if (file.size > this.max) {
          QR.error("File " + file.name + " is too large.");
          break;
        } else if (-1 === QR.mimeTypes.indexOf(file.type)) {
          QR.error("" + file.name + ": Unsupported file type.");
          break;
        }
        if (!QR.replies[QR.replies.length - 1].file) {
          QR.replies[QR.replies.length - 1].setFile(file);
        } else {
          new QR.reply().setFile(file);
        }
      }
      $.addClass(QR.el, 'dump');
      return QR.resetFileInput();
    },
    resetFileInput: function() {
      return $('[type=file]', QR.el).value = null;
    },
    replies: [],
    reply: (function() {

      function _Class() {
        var key, persona, prev,
          _this = this;
        prev = QR.replies[QR.replies.length - 1];
        persona = $.get('persona', {
          global: {}
        });
        if (!persona[key = Conf['Per Board Persona'] ? g.BOARD : 'global']) {
          persona[key] = persona.global;
        }
        this.name = prev ? prev.name : persona[key].name || null;
        this.email = prev && (Conf["Remember Sage"] || !/^sage$/.test(prev.email)) ? prev.email : persona[key].email || null;
        this.sub = prev && Conf['Remember Subject'] ? prev.sub : Conf['Remember Subject'] ? persona[key].sub : null;
        this.spoiler = prev && Conf['Remember Spoiler'] ? prev.spoiler : false;
        this.com = null;
        this.el = $.el('a', {
          className: 'thumbnail',
          draggable: true,
          href: 'javascript:;',
          innerHTML: '<a class=remove>×</a><label hidden><input type=checkbox> Spoiler</label><span></span>'
        });
        $('input', this.el).checked = this.spoiler;
        $.on(this.el, 'click', function() {
          return _this.select();
        });
        $.on($('.remove', this.el), 'click', function(e) {
          e.stopPropagation();
          return _this.rm();
        });
        $.on($('label', this.el), 'click', function(e) {
          return e.stopPropagation();
        });
        $.on($('input', this.el), 'change', function(e) {
          _this.spoiler = e.target.checked;
          if (_this.el.id === 'selected') {
            return $.id('spoiler').checked = _this.spoiler;
          }
        });
        $.before($('#addReply', QR.el), this.el);
        $.on(this.el, 'dragstart', this.dragStart);
        $.on(this.el, 'dragenter', this.dragEnter);
        $.on(this.el, 'dragleave', this.dragLeave);
        $.on(this.el, 'dragover', this.dragOver);
        $.on(this.el, 'dragend', this.dragEnd);
        $.on(this.el, 'drop', this.drop);
        QR.replies.push(this);
      }

      _Class.prototype.setFile = function(file) {
        var fileUrl, img, url,
          _this = this;
        this.file = file;
        this.el.title = "" + file.name + " (" + ($.bytesToString(file.size)) + ")";
        if (QR.spoiler) {
          $('label', this.el).hidden = false;
        }
        if (!/^image/.test(file.type)) {
          this.el.style.backgroundImage = null;
          return;
        }
        if (!(url = window.URL || window.webkitURL)) {
          return;
        }
        url.revokeObjectURL(this.url);
        fileUrl = url.createObjectURL(file);
        img = $.el('img');
        $.on(img, 'load', function() {
          var c, data, i, l, s, ui8a, _i;
          s = 90 * 3;
          if (img.height < s || img.width < s) {
            _this.url = fileUrl;
            _this.el.style.backgroundImage = "url(" + _this.url + ")";
            return;
          }
          if (img.height <= img.width) {
            img.width = s / img.height * img.width;
            img.height = s;
          } else {
            img.height = s / img.width * img.height;
            img.width = s;
          }
          c = $.el('canvas');
          c.height = img.height;
          c.width = img.width;
          c.getContext('2d').drawImage(img, 0, 0, img.width, img.height);
          data = atob(c.toDataURL().split(',')[1]);
          l = data.length;
          ui8a = new Uint8Array(l);
          for (i = _i = 0; 0 <= l ? _i < l : _i > l; i = 0 <= l ? ++_i : --_i) {
            ui8a[i] = data.charCodeAt(i);
          }
          _this.url = url.createObjectURL(new Blob([ui8a], {
            type: 'image/png'
          }));
          _this.el.style.backgroundImage = "url(" + _this.url + ")";
          return typeof url.revokeObjectURL === "function" ? url.revokeObjectURL(fileUrl) : void 0;
        });
        return img.src = fileUrl;
      };

      _Class.prototype.rmFile = function() {
        var _base1;
        QR.resetFileInput();
        delete this.file;
        this.el.title = null;
        this.el.style.backgroundImage = null;
        if (QR.spoiler) {
          $('label', this.el).hidden = true;
        }
        return typeof (_base1 = window.URL || window.webkitURL).revokeObjectURL === "function" ? _base1.revokeObjectURL(this.url) : void 0;
      };

      _Class.prototype.select = function() {
        var data, rectEl, rectList, _i, _len, _ref, _ref1;
        if ((_ref = QR.selected) != null) {
          _ref.el.id = null;
        }
        QR.selected = this;
        this.el.id = 'selected';
        rectEl = this.el.getBoundingClientRect();
        rectList = this.el.parentNode.getBoundingClientRect();
        this.el.parentNode.scrollLeft += rectEl.left + rectEl.width / 2 - rectList.left - rectList.width / 2;
        _ref1 = ['name', 'email', 'sub', 'com'];
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          data = _ref1[_i];
          $("[name=" + data + "]", QR.el).value = this[data];
        }
        QR.characterCount.call($('textarea', QR.el));
        return $('#spoiler', QR.el).checked = this.spoiler;
      };

      _Class.prototype.dragStart = function() {
        return $.addClass(this, 'drag');
      };

      _Class.prototype.dragEnter = function() {
        return $.addClass(this, 'over');
      };

      _Class.prototype.dragLeave = function() {
        return $.rmClass(this, 'over');
      };

      _Class.prototype.dragOver = function(e) {
        e.preventDefault();
        return e.dataTransfer.dropEffect = 'move';
      };

      _Class.prototype.drop = function() {
        var el, index, newIndex, oldIndex, reply;
        el = $('.drag', this.parentNode);
        index = function(el) {
          return Array.prototype.slice.call(el.parentNode.children).indexOf(el);
        };
        oldIndex = index(el);
        newIndex = index(this);
        if (oldIndex < newIndex) {
          $.after(this, el);
        } else {
          $.before(this, el);
        }
        reply = QR.replies.splice(oldIndex, 1)[0];
        return QR.replies.splice(newIndex, 0, reply);
      };

      _Class.prototype.dragEnd = function() {
        var el;
        $.rmClass(this, 'drag');
        if (el = $('.over', this.parentNode)) {
          return $.rmClass(el, 'over');
        }
      };

      _Class.prototype.rm = function() {
        var index, _base1;
        QR.resetFileInput();
        $.rm(this.el);
        index = QR.replies.indexOf(this);
        if (QR.replies.length === 1) {
          new QR.reply().select();
        } else if (this.el.id === 'selected') {
          (QR.replies[index - 1] || QR.replies[index + 1]).select();
        }
        QR.replies.splice(index, 1);
        return typeof (_base1 = window.URL || window.webkitURL).revokeObjectURL === "function" ? _base1.revokeObjectURL(this.url) : void 0;
      };

      return _Class;

    })(),
    captcha: {
      init: function() {
        var _this = this;
        if (-1 !== d.cookie.indexOf('pass_enabled=')) {
          return;
        }
        if (!(this.isEnabled = !!$.id('captchaFormPart'))) {
          return;
        }
        if ($.id('recaptcha_challenge_field_holder')) {
          return this.ready();
        } else {
          this.onready = function() {
            return _this.ready();
          };
          return $.on($.id('recaptcha_widget_div'), 'DOMNodeInserted', this.onready);
        }
      },
      ready: function() {
        var _this = this;
        if (this.challenge = $.id('recaptcha_challenge_field_holder')) {
          $.off($.id('recaptcha_widget_div'), 'DOMNodeInserted', this.onready);
          delete this.onready;
        } else {
          return;
        }
        $.addClass(QR.el, 'captcha');
        $.after($('.textarea', QR.el), $.el('div', {
          className: 'captchaimg',
          title: 'Reload',
          innerHTML: '<img>'
        }));
        $.after($('.captchaimg', QR.el), $.el('div', {
          className: 'captchainput',
          innerHTML: '<input title=Verification class=field autocomplete=off size=1>'
        }));
        this.img = $('.captchaimg > img', QR.el);
        this.input = $('.captchainput > input', QR.el);
        $.on(this.img.parentNode, 'click', this.reload);
        $.on(this.input, 'keydown', this.keydown);
        $.on(this.challenge, 'DOMNodeInserted', function() {
          return _this.load();
        });
        $.sync('captchas', function(arr) {
          return _this.count(arr.length);
        });
        this.count($.get('captchas', []).length);
        return this.reload();
      },
      addCaptcha: function(challenge, response) {
        var captcha, captchas;
        captchas = $.get('captchas', []);
        while ((captcha = captchas[0]) && captcha.time < Date.now()) {
          captchas.shift();
        }
        captchas.push({
          challenge: challenge,
          response: response,
          time: this.timeout
        });
        $.set('captchas', captchas);
        return this.count(captchas.length);
      },
      validateCaptcha: function(challenge, response) {
        var callbacks, opts;
        opts = {
          form: $.formData({
            recaptcha_challenge_field: challenge,
            recaptcha_response_field: response
          })
        };
        callbacks = {
          onload: function(data) {
            var doc, key, ta;
            doc = d.implementation.createHTMLDocument('');
            doc.documentElement.innerHTML = data.responseText;
            if (ta = $('textarea', doc)) {
              key = ta.textContent;
              QR.cleanError();
              return QR.captcha.addCaptcha(key, 'manual_challenge');
            } else if ($('#recaptcha_response_field', doc)) {
              return QR.error('Bad CAPTCHA');
            } else {
              $.log('Could not understand response from CAPTCHA validator:', data.responseText);
              QR.error('Validation connection failed; adding CAPTCHA anyway');
              return QR.captcha.addCaptcha(challenge, response);
            }
          },
          onerror: function() {
            QR.error('Validation connection failed; adding CAPTCHA anyway');
            return QR.captcha.addCaptcha(challenge, response);
          }
        };
        return $.crossAjax('//www.google.com/recaptcha/api/noscript?k=6Ldp2bsSAAAAAAJ5uyx_lx34lJeEpTLVkP5k04qc', callbacks, opts);
      },
      save: function() {
        var challenge, response;
        if (!(response = this.input.value)) {
          return;
        }
        challenge = this.challenge.firstChild.value;
        if (Conf['Validate CAPTCHA']) {
          this.validateCaptcha(challenge, response);
        } else {
          this.addCaptcha(challenge, response);
        }
        return this.reload();
      },
      load: function() {
        var challenge,
          _this = this;
        this.timeout = Date.now() + 4 * $.MINUTE;
        challenge = this.challenge.firstChild.value;
        this.img.alt = challenge;
        this.img.src = "//www.google.com/recaptcha/api/image?c=" + challenge;
        return this.img.onload = function() {
          _this.img.style.visibility = 'visible';
          return _this.input.value = null;
        };
      },
      count: function(count) {
        this.input.placeholder = (function() {
          switch (count) {
            case 0:
              return 'Verification (Shift + Enter to cache)';
            case 1:
              return 'Verification (1 cached captcha)';
            default:
              return "Verification (" + count + " cached captchas)";
          }
        })();
        return this.input.alt = count;
      },
      reload: function(focus) {
        QR.captcha.input.value = null;
        QR.captcha.img.style.visibility = 'hidden';
        $.globalEval('javascript:Recaptcha.reload("t")');
        if (focus) {
          return QR.captcha.input.focus();
        }
      },
      keydown: function(e) {
        var c;
        c = QR.captcha;
        if (e.keyCode === 8 && !c.input.value) {
          c.reload();
        } else if (e.keyCode === 13 && e.shiftKey) {
          c.save();
        } else {
          return;
        }
        return e.preventDefault();
      }
    },
    dialog: function() {
      var fileInput, id, mimeTypes, name, spoiler, ta, thread, threads, _i, _j, _len, _len1, _ref, _ref1;
      QR.el = UI.dialog('qr', 'top:0;right:0;', '\
<div class=move>\
  Quick Reply <input type=checkbox id=autohide title=Auto-hide>\
  <span> <a class=close title=Close>×</a></span>\
</div>\
<form>\
  <div><input id=dump type=button title="Dump list" value=+ class=field><input name=name title=Name placeholder=Name class=field size=1><input name=email title=E-mail placeholder=E-mail class=field size=1><input name=sub title=Subject placeholder=Subject class=field size=1></div>\
  <div id=replies><div><a id=addReply href=javascript:; title="Add a reply">+</a></div></div>\
  <div class=textarea><textarea name=com title=Comment placeholder=Comment class=field></textarea><span id=charCount></span></div>\
  <div><input type=file title="Shift+Click to remove the selected file." multiple size=16><input type=submit></div>\
  <label id=spoilerLabel><input type=checkbox id=spoiler> Spoiler Image</label>\
  <div class=warning></div>\
</form>');
      if (Conf['Remember QR size'] && $.engine === 'gecko') {
        $.on(ta = $('textarea', QR.el), 'mouseup', function() {
          return $.set('QR.size', this.style.cssText);
        });
        ta.style.cssText = $.get('QR.size', '');
      }
      mimeTypes = $('ul.rules').firstElementChild.textContent.trim().match(/: (.+)/)[1].toLowerCase().replace(/\w+/g, function(type) {
        switch (type) {
          case 'jpg':
            return 'image/jpeg';
          case 'pdf':
            return 'application/pdf';
          case 'swf':
            return 'application/x-shockwave-flash';
          default:
            return "image/" + type;
        }
      });
      QR.mimeTypes = mimeTypes.split(', ');
      QR.mimeTypes.push('');
      fileInput = $('input[type=file]', QR.el);
      fileInput.max = $('input[name=MAX_FILE_SIZE]').value;
      if ($.engine !== 'presto') {
        fileInput.accept = mimeTypes;
      }
      QR.spoiler = !!$('input[name=spoiler]');
      spoiler = $('#spoilerLabel', QR.el);
      spoiler.hidden = !QR.spoiler;
      QR.charaCounter = $('#charCount', QR.el);
      ta = $('textarea', QR.el);
      if (!g.REPLY) {
        threads = '<option value=new>New thread</option>';
        _ref = $$('.thread');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          thread = _ref[_i];
          id = thread.id.slice(1);
          threads += "<option value=" + id + ">Thread " + id + "</option>";
        }
        QR.threadSelector = g.BOARD === 'f' ? $('select[name=filetag]').cloneNode(true) : $.el('select', {
          innerHTML: threads,
          title: 'Create a new thread / Reply to a thread'
        });
        $.prepend($('.move > span', QR.el), QR.threadSelector);
        $.on(QR.threadSelector, 'mousedown', function(e) {
          return e.stopPropagation();
        });
      }
      $.on($('#autohide', QR.el), 'change', QR.toggleHide);
      $.on($('.close', QR.el), 'click', QR.close);
      $.on($('#dump', QR.el), 'click', function() {
        return QR.el.classList.toggle('dump');
      });
      $.on($('#addReply', QR.el), 'click', function() {
        return new QR.reply().select();
      });
      $.on($('form', QR.el), 'submit', QR.submit);
      $.on(ta, 'input', function() {
        return QR.selected.el.lastChild.textContent = this.value;
      });
      $.on(ta, 'input', QR.characterCount);
      $.on(fileInput, 'change', QR.fileInput);
      $.on(fileInput, 'click', function(e) {
        if (e.shiftKey) {
          return QR.selected.rmFile() || e.preventDefault();
        }
      });
      $.on(spoiler.firstChild, 'change', function() {
        return $('input', QR.selected.el).click();
      });
      $.on($('.warning', QR.el), 'click', QR.cleanError);
      new QR.reply().select();
      _ref1 = ['name', 'email', 'sub', 'com'];
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        name = _ref1[_j];
        $.on($("[name=" + name + "]", QR.el), 'input', function() {
          var _ref2;
          QR.selected[this.name] = this.value;
          if (QR.cooldown.auto && QR.selected === QR.replies[0] && (0 < (_ref2 = QR.cooldown.seconds) && _ref2 <= 5)) {
            return QR.cooldown.auto = false;
          }
        });
      }
      QR.status.input = $('input[type=submit]', QR.el);
      QR.status();
      QR.cooldown.init();
      QR.captcha.init();
      $.add(d.body, QR.el);
      return $.event(QR.el, new CustomEvent('QRDialogCreation', {
        bubbles: true
      }));
    },
    submit: function(e) {
      var callbacks, captcha, captchas, challenge, err, filetag, m, opts, post, reply, response, textOnly, threadID, _ref;
      if (e != null) {
        e.preventDefault();
      }
      if (QR.cooldown.seconds) {
        QR.cooldown.auto = !QR.cooldown.auto;
        QR.status();
        return;
      }
      QR.abort();
      reply = QR.replies[0];
      if (g.BOARD === 'f' && !g.REPLY) {
        filetag = QR.threadSelector.value;
        threadID = 'new';
      } else {
        threadID = g.THREAD_ID || QR.threadSelector.value;
      }
      if (threadID === 'new') {
        threadID = null;
        if (((_ref = g.BOARD) === 'vg' || _ref === 'q') && !reply.sub) {
          err = 'New threads require a subject.';
        } else if (!(reply.file || (textOnly = !!$('input[name=textonly]', $.id('postForm'))))) {
          err = 'No file selected.';
        } else if (g.BOARD === 'f' && filetag === '9999') {
          err = 'Invalid tag specified.';
        }
      } else if (!(reply.com || reply.file)) {
        err = 'No file selected.';
      }
      if (QR.captcha.isEnabled && !err) {
        captchas = $.get('captchas', []);
        while ((captcha = captchas[0]) && captcha.time < Date.now()) {
          captchas.shift();
        }
        if (captcha = captchas.shift()) {
          challenge = captcha.challenge;
          response = captcha.response;
        } else {
          challenge = QR.captcha.img.alt;
          if (response = QR.captcha.input.value) {
            QR.captcha.reload();
          }
        }
        $.set('captchas', captchas);
        QR.captcha.count(captchas.length);
        if (!response) {
          err = 'No valid captcha.';
        } else {
          response = response.trim();
          if (!/\s|_/.test(response)) {
            response = "" + response + " " + response;
          }
        }
      }
      if (err) {
        QR.cooldown.auto = false;
        QR.status();
        QR.error(err);
        return;
      }
      QR.cleanError();
      QR.cooldown.auto = QR.replies.length > 1;
      if (Conf['Auto Hide QR'] && !QR.cooldown.auto) {
        QR.hide();
      }
      if (!QR.cooldown.auto && $.x('ancestor::div[@id="qr"]', d.activeElement)) {
        d.activeElement.blur();
      }
      QR.status({
        progress: '...'
      });
      post = {
        resto: threadID,
        name: reply.name,
        email: reply.email,
        sub: reply.sub,
        com: Conf['Markdown'] ? Markdown.format(reply.com) : reply.com,
        upfile: reply.file,
        filetag: filetag,
        spoiler: reply.spoiler,
        textonly: textOnly,
        mode: 'regist',
        pwd: (m = d.cookie.match(/4chan_pass=([^;]+)/)) ? decodeURIComponent(m[1]) : $('input[name=pwd]').value,
        recaptcha_challenge_field: challenge,
        recaptcha_response_field: response
      };
      callbacks = {
        onload: function() {
          return QR.response(this.response);
        },
        onerror: function() {
          QR.cooldown.auto = false;
          QR.status();
          QR.error($.el('a', {
            href: '//www.4chan.org/banned',
            target: '_blank',
            textContent: 'Connection error, or you are banned.'
          }));
          if (Conf['Check for Bans']) {
            $["delete"]('lastBanCheck');
            return BanChecker.init();
          }
        }
      };
      opts = {
        form: $.formData(post),
        upCallbacks: {
          onload: function() {
            return QR.status({
              progress: '...'
            });
          },
          onprogress: function(e) {
            return QR.status({
              progress: "" + (Math.round(e.loaded / e.total * 100)) + "%"
            });
          }
        }
      };
      return QR.ajax = $.ajax($.id('postForm').parentNode.action, callbacks, opts);
    },
    response: function(html) {
      var ban, board, doc, err, key, persona, postID, reply, threadID, _, _ref, _ref1;
      doc = d.implementation.createHTMLDocument('');
      doc.documentElement.innerHTML = html;
      if (ban = $('.banType', doc)) {
        board = $('.board', doc).innerHTML;
        err = $.el('span');
        if (ban.textContent.toLowerCase() === 'banned') {
          if (Conf['Check for Bans']) {
            $["delete"]('lastBanCheck');
            BanChecker.init();
          }
          err.innerHTML = ("You are banned on " + board + "! ;_;<br>") + "Click <a href=//www.4chan.org/banned target=_blank>here</a> to see the reason.";
        } else {
          err.innerHTML = ("You were issued a warning on " + board + " as " + ($('.nameBlock', doc).innerHTML) + ".<br>") + ("Reason: " + ($('.reason', doc).innerHTML));
        }
      } else if (err = doc.getElementById('errmsg')) {
        if ((_ref = $('a', err)) != null) {
          _ref.target = '_blank';
        }
      } else if (doc.title !== 'Post successful!') {
        err = 'Connection error with sys.4chan.org.';
      }
      if (err) {
        if (/captcha|verification/i.test(err.textContent) || err === 'Connection error with sys.4chan.org.') {
          if (/mistyped/i.test(err.textContent)) {
            err.textContent = 'Error: You seem to have mistyped the CAPTCHA.';
          }
          QR.cooldown.auto = QR.captcha.isEnabled ? !!$.get('captchas', []).length : err === 'Connection error with sys.4chan.org.' ? true : false;
          QR.cooldown.set({
            delay: 2
          });
        } else {
          QR.cooldown.auto = false;
        }
        QR.status();
        QR.error(err);
        return;
      }
      reply = QR.replies[0];
      persona = $.get('persona', {
        global: {}
      });
      persona[key = Conf['Per Board Persona'] ? g.BOARD : 'global'] = {
        name: reply.name,
        email: !Conf["Remember Sage"] && /^sage$/.test(reply.email) ? /^sage$/.test(persona[key].email) ? null : persona[key].email : reply.email,
        sub: Conf['Remember Subject'] ? reply.sub : null
      };
      $.set('persona', persona);
      _ref1 = doc.body.lastChild.textContent.match(/thread:(\d+),no:(\d+)/), _ = _ref1[0], threadID = _ref1[1], postID = _ref1[2];
      $.event(QR.el, new CustomEvent('QRPostSuccessful', {
        bubbles: true,
        detail: {
          threadID: threadID,
          postID: postID
        }
      }));
      QR.cooldown.set({
        post: reply,
        isReply: threadID !== '0'
      });
      if (threadID === '0') {
        location.pathname = "/" + g.BOARD + "/res/" + postID;
      } else {
        QR.cooldown.auto = QR.replies.length > 1;
        if (Conf['Open Reply in New Tab'] && !g.REPLY && !QR.cooldown.auto) {
          $.open("//boards.4chan.org/" + g.BOARD + "/res/" + threadID + "#p" + postID);
        }
      }
      if (Conf['Persistent QR'] || QR.cooldown.auto) {
        reply.rm();
      } else {
        QR.close();
      }
      QR.status();
      return QR.resetFileInput();
    },
    abort: function() {
      var _ref;
      if ((_ref = QR.ajax) != null) {
        _ref.abort();
      }
      delete QR.ajax;
      return QR.status();
    }
  };

  Options = {
    init: function() {
      return $.ready(Options.initReady);
    },
    initReady: function() {
      var a, setting, settings, _i, _len, _ref;
      _ref = ['navtopright', 'navbotright'];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        settings = _ref[_i];
        a = $.el('a', {
          href: 'javascript:;',
          className: 'settingsWindowLink',
          textContent: '4chan X Settings'
        });
        $.on(a, 'click', Options.dialog);
        setting = $.id(settings);
        if (Conf['Disable 4chan\'s extension']) {
          $.replace(setting.childNodes[1], a);
          continue;
        }
        $.prepend(setting, [$.tn('['), a, $.tn('] ')]);
      }
      if (!$.get('firstrun')) {
        $.set('firstrun', true);
        if (!Favicon.el) {
          Favicon.init();
        }
        return Options.dialog();
      }
    },
    dialog: function() {
      var archiver, arr, back, checked, description, dialog, favicon, fileInfo, filter, height, hiddenNum, hiddenThreads, indicator, indicators, input, key, li, name, obj, overlay, sauce, time, toSelect, tr, ul, updateIncrease, updateIncreaseB, value, width, _i, _j, _len, _len1, _ref, _ref1, _ref2;
      dialog = Options.el = $.el('div', {
        id: 'options',
        className: 'reply dialog',
        innerHTML: '<div id=optionsbar>\
  <div id=credits>\
    <a target=_blank href=http://ihavenoface.github.com/4chan-x/>4chan X</a>\
    | <a target=_blank href=https://raw.github.com/ihavenoface/4chan-x/master/changelog>' + Main.version + '</a>\
    | <a target=_blank href=http://ihavenoface.github.com/4chan-x/#bug-report>Issues</a>\
  </div>\
  <div>\
    <label for=main_tab>Main</label>\
    | <label for=filter_tab>Filter</label>\
    | <label for=sauces_tab>Sauce</label>\
    | <label for=rice_tab>Rice</label>\
    | <label for=keybinds_tab>Keybinds</label>\
    | <label onclick="document.location.reload()">Refresh</label>\
  </div>\
</div>\
<hr>\
<div id=content>\
  <input type=radio name=tab hidden id=main_tab checked>\
  <div>\
    <div class=imp-exp>\
      <button class=export>Export settings</button>\
      <button class=import>Import settings</button>\
      <input type=file style="visibility:hidden">\
    </div>\
    <p class=imp-exp-result></p>\
  </div>\
  <input type=radio name=tab hidden id=sauces_tab>\
  <div>\
    <div class=warning><code>Sauce</code> is disabled.</div>\
    Lines starting with a <code>#</code> will be ignored.<br>\
    You can specify a certain display text by appending <code>;text:[text]</code> to the url.\
    <ul>These parameters will be replaced by their corresponding values:\
      <li>$1: Thumbnail url.</li>\
      <li>$2: Full image url.</li>\
      <li>$3: MD5 hash.</li>\
      <li>$4: Current board.</li>\
    </ul>\
    <textarea name=sauces id=sauces class=field></textarea>\
  </div>\
  <input type=radio name=tab hidden id=filter_tab>\
  <div>\
    <div class=warning><code>Filter</code> is disabled.</div>\
    <select name=filter>\
      <option value=guide>Guide</option>\
      <option value=name>Name</option>\
      <option value=uniqueid>Unique ID</option>\
      <option value=tripcode>Tripcode</option>\
      <option value=mod>Admin/Mod</option>\
      <option value=email>E-mail</option>\
      <option value=subject>Subject</option>\
      <option value=comment>Comment</option>\
      <option value=country>Country</option>\
      <option value=filename>Filename</option>\
      <option value=dimensions>Image dimensions</option>\
      <option value=filesize>Filesize</option>\
      <option value=md5>Image MD5 (uses exact string matching, not regular expressions)</option>\
    </select>\
  </div>\
  <input type=radio name=tab hidden id=rice_tab>\
  <div>\
    Select an Archiver for this board<br>\
    <select name=archiver></select><br>\
    <div class=warning><code>Quote Backlinks</code> are disabled.</div>\
    <ul>\
      Backlink formatting\
      <li><input name=backlink class=field> : <span id=backlinkPreview></span></li>\
    </ul>\
    <div class=warning><code>Time Formatting</code> is disabled.</div>\
    <ul>\
      Time formatting\
      <li><input name=time class=field> : <span id=timePreview></span></li>\
      <li>Supported <a href=http://en.wikipedia.org/wiki/Date_%28Unix%29#Formatting>format specifiers</a>:</li>\
      <li>Day: %a, %A, %d, %e</li>\
      <li>Month: %m, %b, %B</li>\
      <li>Year: %y</li>\
      <li>Hour: %k, %H, %l (lowercase L), %I (uppercase i), %p, %P</li>\
      <li>Minutes: %M</li>\
      <li>Seconds: %S</li>\
    </ul>\
    <div class=warning><code>File Info Formatting</code> is disabled.</div>\
    <ul>\
      File Info Formatting\
      <li><input name=fileInfo class=field> : <span id=fileInfoPreview class=fileText></span></li>\
      <li>Link: %l (lowercase L, truncated), %L (untruncated), %t (Unix timestamp)</li>\
      <li>Original file name: %n (truncated), %N (untruncated), %T (Unix timestamp)</li>\
      <li>Spoiler indicator: %p</li>\
      <li>Size: %B (Bytes), %K (KB), %M (MB), %s (4chan default)</li>\
      <li>Resolution: %r (Displays PDF on /po/, for PDFs)</li>\
    </ul>\
    <ul>\
      <div class=warning><code>Unread Favicon</code> is disabled.</div>\
      Unread favicons<br>\
      <select name=favicon>\
        <option value=ferongr>ferongr</option>\
        <option value=xat->xat-</option>\
        <option value=Mayhem>Mayhem</option>\
        <option value=Original>Original</option>\
      </select>\
    <span></span>\
    </ul>\
    <ul>\
      Specify size of video embeds<br>\
      Width: <input name=embedWidth type=number />px | Heigth: <input name=embedHeight type=number />px <button name=resetSize>Reset</button>\
    </ul>\
    <ul>\
      Amounts for Optional Increase<br>\
      Visible tab<br>\
      <input name=updateIncrease class=field>\
      <br>Background tab<br>\
      <input name=updateIncreaseB class=field>\
    </ul>\
    <div class=warning><code>Per Board Persona</code> is disabled.</div>\
    <div id=persona>\
      <select name=personaboards></select>\
      <ul>\
        <li>\
          <div class=option>\
            Name:\
          </div>\
        </li>\
        <li>\
          <div class=option>\
            <input name=name>\
          </div>\
        </li>\
        <li>\
          <div class=option>\
            Email:\
          </div>\
        </li>\
        <li>\
          <div class=option>\
            <input name=email>\
          </div>\
        </li>\
        <li>\
          <div class=option>\
            Subject:\
          </div>\
        </li>\
        <li>\
          <div class=option>\
            <input name=sub>\
          </div>\
        </li>\
        <li>\
          <button></button>\
        </li>\
      </ul>\
    </div>\
  </div>\
  <input type=radio name=tab hidden id=keybinds_tab>\
  <div>\
    <div class=warning><code>Keybinds</code> are disabled.</div>\
    <div>Allowed keys: Ctrl, Alt, Meta, a-z, A-Z, 0-9, Up, Down, Right, Left.</div>\
    <table><tbody>\
      <tr><th>Actions</th><th>Keybinds</th></tr>\
    </tbody></table>\
  </div>\
</div>'
      });
      $.on($('#main_tab + div .export', dialog), 'click', Options["export"]);
      $.on($('#main_tab + div .import', dialog), 'click', Options["import"]);
      $.on($('#main_tab + div input', dialog), 'change', Options.onImport);
      _ref = Config.main;
      for (key in _ref) {
        obj = _ref[key];
        ul = $.el('ul', {
          textContent: key
        });
        for (key in obj) {
          arr = obj[key];
          checked = $.get(key, Conf[key]) ? 'checked' : '';
          description = arr[1];
          li = $.el('li', {
            innerHTML: "<label><input type=checkbox name=\"" + key + "\" " + checked + ">" + key + "</label><span class=description>: " + description + "</span>"
          });
          $.on($('input', li), 'click', $.cb.checked);
          $.add(ul, li);
        }
        $.add($('#main_tab + div', dialog), ul);
      }
      hiddenThreads = $.get("hiddenThreads/" + g.BOARD + "/", {});
      hiddenNum = Object.keys(g.hiddenReplies).length + Object.keys(hiddenThreads).length;
      li = $.el('li', {
        innerHTML: "<button>hidden: " + hiddenNum + "</button> <span class=description>: Forget all hidden posts. Useful if you accidentally hide a post and have \"Show Stubs\" disabled."
      });
      $.on($('button', li), 'click', Options.clearHidden);
      $.add($('ul:nth-child(3)', dialog), li);
      filter = $('select[name=filter]', dialog);
      $.on(filter, 'change', Options.filter);
      archiver = $('select[name=archiver]', dialog);
      if (!(toSelect = Redirect.select(g.BOARD))[0]) {
        toSelect = ['No archive available.'];
      }
      for (_i = 0, _len = toSelect.length; _i < _len; _i++) {
        name = toSelect[_i];
        if (archiver.length >= toSelect.length) {
          break;
        }
        $.add(archiver, $.el('option', {
          textContent: name
        }));
      }
      if (toSelect[1]) {
        archiver.value = $.get((value = "archiver/" + g.BOARD + "/"), toSelect[0]);
        $.on(archiver, 'mouseup', function() {
          if (Redirect.archive[g.BOARD]) {
            Redirect.archive[g.BOARD] = this.value;
          }
          if (this.value === toSelect[0]) {
            return $["delete"](value);
          } else {
            return $.set(value, this.value);
          }
        });
      }
      sauce = $('#sauces', dialog);
      sauce.value = $.get(sauce.name, Conf[sauce.name]);
      $.on(sauce, 'change', $.cb.value);
      (back = $('[name=backlink]', dialog)).value = $.get('backlink', Conf['backlink']);
      (time = $('[name=time]', dialog)).value = $.get('time', Conf['time']);
      (fileInfo = $('[name=fileInfo]', dialog)).value = $.get('fileInfo', Conf['fileInfo']);
      $.on(back, 'input', $.cb.value);
      $.on(back, 'input', Options.backlink);
      $.on(time, 'input', $.cb.value);
      $.on(time, 'input', Options.time);
      $.on(fileInfo, 'input', $.cb.value);
      $.on(fileInfo, 'input', Options.fileInfo);
      favicon = $('select[name=favicon]', dialog);
      favicon.value = $.get('favicon', Conf['favicon']);
      $.on(favicon, 'change', $.cb.value);
      $.on(favicon, 'change', Options.favicon);
      (updateIncrease = $('[name=updateIncrease]', dialog)).value = $.get('updateIncrease', Conf['updateIncrease']);
      $.on(updateIncrease, 'input', $.cb.value);
      (updateIncreaseB = $('[name=updateIncreaseB]', dialog)).value = $.get('updateIncreaseB', Conf['updateIncreaseB']);
      $.on(updateIncreaseB, 'input', $.cb.value);
      (width = $('[name=embedWidth]', dialog)).value = $.get('embedWidth', Conf['embedWidth']);
      (height = $('[name=embedHeight]', dialog)).value = $.get('embedHeight', Conf['embedHeight']);
      $.on(width, 'input', $.cb.value);
      $.on(height, 'input', $.cb.value);
      $.on($('[name=resetSize]', dialog), 'click', function() {
        $.set('embedWidth', width.value = Config.embedWidth);
        return $.set('embedHeight', height.value = Config.embedHeight);
      });
      Options.persona.select = $('[name=personaboards]', dialog);
      Options.persona.button = $('#persona button', dialog);
      Options.persona.data = $.get('persona', {
        global: {}
      });
      if (!Options.persona.data[g.BOARD]) {
        Options.persona.data[g.BOARD] = Options.persona.data.global;
      }
      for (name in Options.persona.data) {
        Options.persona.select.innerHTML += "<option value=" + name + ">" + name + "</option>";
      }
      Options.persona.select.value = Conf['Per Board Persona'] ? g.BOARD : 'global';
      Options.persona.init();
      $.on(Options.persona.select, 'change', Options.persona.change);
      _ref1 = Config.hotkeys;
      for (key in _ref1) {
        arr = _ref1[key];
        tr = $.el('tr', {
          innerHTML: "<td>" + arr[1] + "</td><td><input name=" + key + " class=field></td>"
        });
        input = $('input', tr);
        input.value = $.get(key, Conf[key]);
        $.on(input, 'keydown', Options.keybind);
        $.add($('#keybinds_tab + div tbody', dialog), tr);
      }
      indicators = {};
      _ref2 = $$('.warning', dialog);
      for (_j = 0, _len1 = _ref2.length; _j < _len1; _j++) {
        indicator = _ref2[_j];
        key = indicator.firstChild.textContent;
        indicator.hidden = $.get(key, Conf[key]);
        indicators[key] = indicator;
        $.on($("[name='" + key + "']", dialog), 'click', function() {
          return indicators[this.name].hidden = this.checked;
        });
      }
      overlay = $.el('div', {
        id: 'overlay'
      });
      $.on(overlay, 'click', Options.close);
      $.on(dialog, 'click', function(e) {
        return e.stopPropagation();
      });
      $.add(overlay, dialog);
      $.add(d.body, overlay);
      d.body.style.setProperty('width', "" + d.body.clientWidth + "px", null);
      $.addClass(d.body, 'unscroll');
      Options.filter.call(filter);
      Options.backlink.call(back);
      Options.time.call(time);
      Options.fileInfo.call(fileInfo);
      return Options.favicon.call(favicon);
    },
    persona: {
      init: function() {
        var input, item, key, _i, _len, _ref;
        key = Conf['Per Board Persona'] ? g.BOARD : 'global';
        Options.persona.newButton();
        _ref = Options.persona.array;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          item = _ref[_i];
          input = $("input[name=" + item + "]", Options.el);
          input.value = this.data[key][item] || "";
          $.on(input, 'blur input', function() {
            var pers;
            pers = Options.persona;
            pers.data[pers.select.value][this.name] = this.value;
            return $.set('persona', pers.data);
          });
        }
        return $.on(Options.persona.button, 'click', Options.persona.copy);
      },
      array: ['name', 'email', 'sub'],
      change: function() {
        var input, item, key, _i, _len, _ref, _results;
        key = this.value;
        Options.persona.newButton();
        _ref = Options.persona.array;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          item = _ref[_i];
          input = $("input[name=" + item + "]", Options.el);
          _results.push(input.value = Options.persona.data[key][item]);
        }
        return _results;
      },
      copy: function() {
        var change, data, select, _ref;
        _ref = Options.persona, select = _ref.select, data = _ref.data, change = _ref.change;
        if (select.value === 'global') {
          data.global = data[select.value];
        } else {
          data[select.value] = data.global;
        }
        $.set('persona', Options.persona.data = data);
        return change.call(select);
      },
      newButton: function() {
        return Options.persona.button.textContent = "Copy from " + (Options.persona.select.value === 'global' ? 'current board' : 'global');
      }
    },
    close: function() {
      $.rm(this);
      d.body.style.removeProperty('width');
      return $.rmClass(d.body, 'unscroll');
    },
    clearHidden: function() {
      $["delete"]("hiddenReplies/" + g.BOARD + "/");
      $["delete"]("hiddenThreads/" + g.BOARD + "/");
      this.textContent = "hidden: 0";
      return g.hiddenReplies = {};
    },
    keybind: function(e) {
      var key;
      if (e.keyCode === 9) {
        return;
      }
      e.preventDefault();
      e.stopPropagation();
      if ((key = Keybinds.keyCode(e)) == null) {
        return;
      }
      this.value = key;
      return $.cb.value.call(this);
    },
    filter: function() {
      var el, name, ta;
      el = this.nextSibling;
      if ((name = this.value) !== 'guide') {
        ta = $.el('textarea', {
          name: name,
          className: 'field',
          value: $.get(name, Conf[name])
        });
        $.on(ta, 'change', $.cb.value);
        $.replace(el, ta);
        return;
      }
      if (el) {
        $.rm(el);
      }
      return $.after(this, $.el('article', {
        innerHTML: '<p>Use <a href=https://developer.mozilla.org/en/JavaScript/Guide/Regular_Expressions>regular expressions</a>, one per line.<br>\
  Lines starting with a <code>#</code> will be ignored.<br>\
  For example, <code>/weeaboo/i</code> will filter posts containing the string `<code>weeaboo</code>`, case-insensitive.</p>\
  <ul>You can use these settings with each regular expression, separate them with semicolons:\
    <li>\
      Per boards, separate them with commas. It is global if not specified.<br>\
      For example: <code>boards:a,jp;</code>.\
    </li>\
    <li>\
      Filter OPs only along with their threads (`only`), replies only (`no`, this is default), or both (`yes`).<br>\
      For example: <code>op:only;</code>, <code>op:no;</code> or <code>op:yes;</code>.\
    </li>\
    <li>\
      Overrule the `Show Stubs` setting if specified: create a stub (`yes`) or not (`no`).<br>\
      For example: <code>stub:yes;</code> or <code>stub:no;</code>.\
    </li>\
    <li>\
      Highlight instead of hiding. You can specify a class name to use with a userstyle.<br>\
      For example: <code>highlight;</code> or <code>highlight:wallpaper;</code>.\
    </li>\
    <li>\
      Highlighted OPs will have their threads put on top of board pages by default.<br>\
      For example: <code>top:yes;</code> or <code>top:no;</code>.\
    </li>\
  </ul>'
      }));
    },
    time: function() {
      Time.foo();
      Time.date = new Date();
      return $.id('timePreview').textContent = Time.funk(Time);
    },
    backlink: function() {
      return $.id('backlinkPreview').textContent = Conf['backlink'].replace(/%id/, '123456789');
    },
    fileInfo: function() {
      FileInfo.data = {
        link: '//images.4chan.org/g/src/1334437723720.jpg',
        spoiler: true,
        size: '276',
        unit: 'KB',
        resolution: '1280x720',
        fullname: 'd9bb2efc98dd0df141a94399ff5880b7.jpg',
        shortname: 'd9bb2efc98dd0df141a94399ff5880(...).jpg'
      };
      FileInfo.setFormats();
      return $.id('fileInfoPreview').innerHTML = FileInfo.funk(FileInfo);
    },
    favicon: function() {
      Favicon["switch"]();
      Unread.update(true);
      return this.nextElementSibling.innerHTML = "<img src=" + Favicon.unreadSFW + "> <img src=" + Favicon.unreadNSFW + "> <img src=" + Favicon.unreadDead + ">";
    },
    "export": function() {
      var a, data, now, output;
      now = Date.now();
      data = {
        version: Main.version,
        date: now,
        Conf: Conf,
        WatchedThreads: $.get('watched', {})
      };
      a = $.el('a', {
        className: 'warning',
        textContent: 'Save me!',
        download: "4chan X v" + Main.version + "-" + now + ".json",
        href: "data:application/json;base64," + (btoa(unescape(encodeURIComponent(JSON.stringify(data))))),
        target: '_blank'
      });
      if ($.engine !== 'gecko') {
        a.click();
        return;
      }
      output = this.parentNode.nextElementSibling;
      output.innerHTML = null;
      return $.add(output, a);
    },
    "import": function() {
      return this.nextElementSibling.click();
    },
    onImport: function() {
      var file, output, reader;
      if (!(file = this.files[0])) {
        return;
      }
      output = this.parentNode.nextElementSibling;
      if (!confirm('Your current settings will be entirely overwritten, are you sure?')) {
        output.textContent = 'Import aborted.';
        return;
      }
      reader = new FileReader();
      reader.onload = function(e) {
        var data;
        try {
          data = JSON.parse(decodeURIComponent(escape(e.target.result)));
          Options.loadSettings(data);
          if (confirm('Import successful. Refresh now?')) {
            return window.location.reload();
          }
        } catch (err) {
          return output.textContent = 'Import failed due to an error.';
        }
      };
      return reader.readAsText(file);
    },
    loadSettings: function(data) {
      var key, val, _ref;
      _ref = data.Conf;
      for (key in _ref) {
        val = _ref[key];
        $.set(key, val);
      }
      return $.set('watched', data.WatchedThreads);
    }
  };

  Updater = {
    init: function() {
      var checkbox, checked, dialog, html, input, name, title, _i, _len, _ref;
      html = '<div class=move><span id=count></span> <span id=timer></span></div>';
      checkbox = Config.updater.checkbox;
      for (name in checkbox) {
        title = checkbox[name][1];
        checked = Conf[name] ? 'checked' : '';
        html += "<div><label title='" + title + "'>" + name + "<input name='" + name + "' type=checkbox " + checked + "></label></div>";
      }
      checked = Conf['Auto Update'] ? 'checked' : '';
      html += "      <div><label title='Controls whether *this* thread automatically updates or not'>Auto Update This<input name='Auto Update This' type=checkbox " + checked + "></label></div>      <div><label>Interval (s)<input type=number name=Interval" + (Conf['Interval per board'] ? "_" + g.BOARD : '') + " class=field min=1></label></div>      <div><label>BGInterval<input type=number name=BGInterval" + (Conf['Interval per board'] ? "_" + g.BOARD : '') + " class=field min=1></label></div>";
      html += "<div><input value='Update Now' type=button name='Update Now'></div>";
      dialog = UI.dialog('updater', 'bottom: 0; right: 0;', html);
      this.count = $('#count', dialog);
      this.timer = $('#timer', dialog);
      this.thread = $.id("t" + g.THREAD_ID);
      this.save = [];
      this.checkPostCount = 0;
      this.unsuccessfulFetchCount = 0;
      this.lastModified = '0';
      _ref = $$('input', dialog);
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        input = _ref[_i];
        if (input.type === 'checkbox') {
          $.on(input, 'click', $.cb.checked);
        }
        switch (input.name) {
          case 'Scroll BG':
            $.on(input, 'click', this.cb.scrollBG);
            this.cb.scrollBG.call(input);
            break;
          case 'Verbose':
            $.on(input, 'click', this.cb.verbose);
            this.cb.verbose.call(input);
            break;
          case 'Auto Update This':
            $.on(input, 'click', this.cb.autoUpdate);
            this.cb.autoUpdate.call(input);
            break;
          case 'Interval':
          case 'BGInterval':
          case "Interval_" + g.BOARD:
          case "BGInterval_" + g.BOARD:
            input.value = Conf[input.name];
            $.on(input, 'change', this.cb.interval);
            this.cb.interval.call(input);
            break;
          case 'Update Now':
            $.on(input, 'click', this.update);
        }
      }
      $.add(d.body, dialog);
      $.on(d, 'QRPostSuccessful', function(e) {
        Updater.cb.post();
        return Updater.postID = e.detail.postID;
      });
      return $.on(d, 'visibilitychange', this.cb.visibility);
    },
    /*
    http://freesound.org/people/pierrecartoons1979/sounds/90112/
    cc-by-nc-3.0
    */

    audio: $.el('audio', {
      src: 'data:audio/wav;base64,UklGRjQDAABXQVZFZm10IBAAAAABAAEAgD4AAIA+AAABAAgAc21wbDwAAABBAAADAAAAAAAAAAA8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABkYXRhzAIAAGMms8em0tleMV4zIpLVo8nhfSlcPR102Ki+5JspVEkdVtKzs+K1NEhUIT7DwKrcy0g6WygsrM2k1NpiLl0zIY/WpMrjgCdbPhxw2Kq+5Z4qUkkdU9K1s+K5NkVTITzBwqnczko3WikrqM+l1NxlLF0zIIvXpsnjgydZPhxs2ay95aIrUEkdUdC3suK8N0NUIjq+xKrcz002WioppdGm091pK1w0IIjYp8jkhydXPxxq2K295aUrTkoeTs65suK+OUFUIzi7xqrb0VA0WSoootKm0t5tKlo1H4TYqMfkiydWQBxm16+85actTEseS8y7seHAPD9TIza5yKra01QyWSson9On0d5wKVk2H4DYqcfkjidUQB1j1rG75KsvSkseScu8seDCPz1TJDW2yara1FYxWSwnm9Sn0N9zKVg2H33ZqsXkkihSQR1g1bK65K0wSEsfR8i+seDEQTxUJTOzy6rY1VowWC0mmNWoz993KVc3H3rYq8TklSlRQh1d1LS647AyR0wgRMbAsN/GRDpTJTKwzKrX1l4vVy4lldWpzt97KVY4IXbUr8LZljVPRCxhw7W3z6ZISkw1VK+4sMWvXEhSPk6buay9sm5JVkZNiLWqtrJ+TldNTnquqbCwilZXU1BwpKirrpNgWFhTaZmnpquZbFlbVmWOpaOonHZcXlljhaGhpZ1+YWBdYn2cn6GdhmdhYGN3lp2enIttY2Jjco+bnJuOdGZlZXCImJqakHpoZ2Zug5WYmZJ/bGlobX6RlpeSg3BqaW16jZSVkoZ0bGtteImSk5KIeG5tbnaFkJKRinxxbm91gY2QkIt/c3BwdH6Kj4+LgnZxcXR8iI2OjIR5c3J0e4WLjYuFe3VzdHmCioyLhn52dHR5gIiKioeAeHV1eH+GiYqHgXp2dnh9hIiJh4J8eHd4fIKHiIeDfXl4eHyBhoeHhH96eHmA'
    }),
    cb: {
      post: function() {
        if (!Conf['Auto Update This']) {
          return;
        }
        Updater.unsuccessfulFetchCount = 0;
        return setTimeout(Updater.update, 500);
      },
      checkpost: function(status) {
        if (status !== 404 && Updater.save.join(' ').indexOf(Updater.postID) === -1 && Updater.checkPostCount < 10) {
          return (function() {
            return setTimeout(Updater.update, this);
          }).call(++Updater.checkPostCount * 500);
        }
        Updater.save = [];
        Updater.checkPostCount = 0;
        return delete Updater.postID;
      },
      visibility: function() {
        if (d.hidden) {
          return;
        }
        Updater.unsuccessfulFetchCount = 0;
        if (Conf['Interval per board']) {
          if (Updater.timer.textContent < -Conf['Interval_' + g.BOARD]) {
            return Updater.set('timer', -Updater.getInterval());
          }
        } else {
          if (Updater.timer.textContent < -Conf['Interval']) {
            return Updater.set('timer', -Updater.getInterval());
          }
        }
      },
      interval: function() {
        var val;
        val = parseInt(this.value, 10);
        this.value = val > 0 ? val : 30;
        $.cb.value.call(this);
        return Updater.set('timer', -Updater.getInterval());
      },
      verbose: function() {
        if (Conf['Verbose']) {
          Updater.set('count', '+0');
          return Updater.timer.hidden = false;
        } else {
          Updater.set('count', 'Thread Updater');
          Updater.count.className = '';
          return Updater.timer.hidden = true;
        }
      },
      autoUpdate: function() {
        if (Conf['Auto Update This'] = this.checked) {
          return Updater.timeoutID = setTimeout(Updater.timeout, 1000);
        } else {
          return clearTimeout(Updater.timeoutID);
        }
      },
      scrollBG: function() {
        return Updater.scrollBG = this.checked ? function() {
          return true;
        } : function() {
          return !d.hidden;
        };
      },
      load: function() {
        switch (this.status) {
          case 404:
            $.event(d, new CustomEvent('theThreadisDead'));
            Updater.set('timer', '');
            Updater.set('count', 404);
            Updater.count.className = 'warning';
            clearTimeout(Updater.timeoutID);
            g.dead = true;
            if (Conf['Unread Count']) {
              Unread.title = Unread.title.match(/^.+-/)[0] + ' 404';
            } else {
              d.title = d.title.match(/^.+-/)[0] + ' 404';
            }
            Unread.update(true);
            QR.abort();
            break;
          case 0:
          case 304:
            /*
            Status Code 304: Not modified
            By sending the `If-Modified-Since` header we get a proper status code, and no response.
            This saves bandwidth for both the user and the servers and avoid unnecessary computation.
            */

            Updater.unsuccessfulFetchCount++;
            Updater.set('timer', -Updater.getInterval());
            if (Conf['Verbose']) {
              Updater.set('count', '+0');
              Updater.count.className = null;
            }
            break;
          case 200:
            Updater.lastModified = this.getResponseHeader('Last-Modified');
            Updater.cb.update(JSON.parse(this.response).posts);
            Updater.set('timer', -Updater.getInterval());
            break;
          default:
            Updater.unsuccessfulFetchCount++;
            Updater.set('timer', -Updater.getInterval());
            if (Conf['Verbose']) {
              Updater.set('count', this.statusText);
              Updater.count.className = 'warning';
            }
        }
        if (Updater.postID) {
          Updater.cb.checkpost(this.status);
        }
        return delete Updater.request;
      },
      update: function(posts) {
        var count, id, lastPost, nodes, post, scroll, spoilerRange, _i, _len, _ref;
        if (spoilerRange = posts[0].custom_spoiler) {
          Build.spoilerRange[g.BOARD] = spoilerRange;
        }
        lastPost = Updater.thread.lastElementChild;
        id = +lastPost.id.slice(2);
        nodes = [];
        _ref = posts.reverse();
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          post = _ref[_i];
          if (post.no <= id) {
            break;
          }
          nodes.push(Build.postFromObject(post, g.BOARD));
          if (Updater.postID) {
            Updater.save.push(post.no);
          }
        }
        count = nodes.length;
        if (Conf['Verbose']) {
          Updater.set('count', "+" + count);
          Updater.count.className = count ? 'new' : null;
        }
        if (count) {
          if (Conf['Beep'] && d.hidden && (Unread.replies.length === 0)) {
            Updater.audio.play();
          }
          Updater.unsuccessfulFetchCount = 0;
        } else {
          Updater.unsuccessfulFetchCount++;
          return;
        }
        scroll = Conf['Scrolling'] && Updater.scrollBG() && lastPost.getBoundingClientRect().bottom - d.documentElement.clientHeight < 25;
        $.add(Updater.thread, nodes.reverse());
        if (scroll && nodes) {
          return nodes[0].scrollIntoView();
        }
      }
    },
    set: function(name, text) {
      var el, node;
      el = Updater[name];
      if (node = el.firstChild) {
        return node.data = text;
      } else {
        return el.textContent = text;
      }
    },
    getInput: function(input) {
      var number, _i, _len, _results;
      while (input.length < 10) {
        input.push(input[input.length - 1]);
      }
      _results = [];
      for (_i = 0, _len = input.length; _i < _len; _i++) {
        number = input[_i];
        _results.push(Number(number));
      }
      return _results;
    },
    getInterval: function() {
      var bg, i, j;
      if (Conf['Interval per board']) {
        i = +Conf['Interval_' + g.BOARD];
        bg = +Conf['BGInterval_' + g.BOARD];
      } else {
        i = +Conf['Interval'];
        bg = +Conf['BGInterval'];
      }
      j = Math.min(this.unsuccessfulFetchCount, 9);
      if (!d.hidden) {
        if (Conf['Optional Increase']) {
          return Math.max(i, Updater.getInput(Conf['updateIncrease'].split(','))[j]);
        }
        return i;
      }
      if (Conf['Optional Increase']) {
        return Math.max(bg, Updater.getInput(Conf['updateIncreaseB'].split(','))[j]);
      }
      return bg;
    },
    timeout: function() {
      var n;
      Updater.timeoutID = setTimeout(Updater.timeout, 1000);
      n = 1 + Number(Updater.timer.firstChild.data);
      if (n === 0) {
        return Updater.update();
      } else if (n >= Updater.getInterval()) {
        Updater.unsuccessfulFetchCount++;
        Updater.set('count', 'Retry');
        Updater.count.className = null;
        return Updater.update();
      } else {
        return Updater.set('timer', n);
      }
    },
    update: function() {
      var request, url;
      Updater.set('timer', 0);
      request = Updater.request;
      if (request) {
        request.onloadend = null;
        request.abort();
      }
      url = "//api.4chan.org/" + g.BOARD + "/res/" + g.THREAD_ID + ".json";
      return Updater.request = $.ajax(url, {
        onloadend: Updater.cb.load
      }, {
        headers: {
          'If-Modified-Since': Updater.lastModified
        }
      });
    }
  };

  Watcher = {
    init: function() {
      var favicon, html, input, _i, _len, _ref;
      html = '<div class=move>Thread Watcher</div>';
      this.dialog = UI.dialog('watcher', 'top: 50px; left: 0px;', html);
      $.add(d.body, this.dialog);
      _ref = $$('.op input');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        input = _ref[_i];
        favicon = $.el('img', {
          className: 'favicon'
        });
        $.on(favicon, 'click', this.cb.toggle);
        $.before(input, favicon);
      }
      if (g.THREAD_ID === $.get('autoWatch', 0)) {
        this.watch(g.THREAD_ID);
        $["delete"]('autoWatch');
      } else {
        this.refresh();
      }
      $.on(d, 'QRPostSuccessful', this.cb.post);
      return $.sync('watched', this.refresh);
    },
    refresh: function(watched) {
      var board, div, favicon, id, link, nodes, props, watchedBoard, x, _i, _j, _len, _len1, _ref, _ref1, _ref2;
      watched || (watched = $.get('watched', {}));
      nodes = [];
      for (board in watched) {
        _ref = watched[board];
        for (id in _ref) {
          props = _ref[id];
          x = $.el('a', {
            textContent: '×',
            href: 'javascript:;'
          });
          $.on(x, 'click', Watcher.cb.x);
          link = $.el('a', props);
          link.title = link.textContent;
          div = $.el('div');
          $.add(div, [x, $.tn(' '), link]);
          nodes.push(div);
        }
      }
      _ref1 = $$('div:not(.move)', Watcher.dialog);
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        div = _ref1[_i];
        $.rm(div);
      }
      $.add(Watcher.dialog, nodes);
      watchedBoard = watched[g.BOARD] || {};
      _ref2 = $$('.favicon');
      for (_j = 0, _len1 = _ref2.length; _j < _len1; _j++) {
        favicon = _ref2[_j];
        id = favicon.nextSibling.name;
        if (id in watchedBoard) {
          favicon.src = Favicon["default"];
        } else {
          favicon.src = Favicon.empty;
        }
      }
    },
    cb: {
      toggle: function() {
        return Watcher.toggle(this.parentNode);
      },
      x: function() {
        var thread;
        thread = this.nextElementSibling.pathname.split('/');
        return Watcher.unwatch(thread[3], thread[1]);
      },
      post: function(e) {
        var postID, threadID, _ref;
        _ref = e.detail, postID = _ref.postID, threadID = _ref.threadID;
        if (threadID === '0') {
          if (Conf['Auto Watch']) {
            return $.set('autoWatch', postID);
          }
        } else if (Conf['Auto Watch Reply']) {
          return Watcher.watch(threadID);
        }
      }
    },
    toggle: function(thread) {
      var id;
      id = $('.favicon + input', thread).name;
      return Watcher.watch(id) || Watcher.unwatch(id, g.BOARD);
    },
    unwatch: function(id, board) {
      var watched;
      watched = $.get('watched', {});
      delete watched[board][id];
      $.set('watched', watched);
      return Watcher.refresh();
    },
    watch: function(id) {
      var thread, watched, _name;
      thread = $.id("t" + id);
      if ($('.favicon', thread).src === Favicon["default"]) {
        return false;
      }
      watched = $.get('watched', {});
      watched[_name = g.BOARD] || (watched[_name] = {});
      watched[g.BOARD][id] = {
        href: "/" + g.BOARD + "/res/" + id,
        textContent: Get.title(thread)
      };
      $.set('watched', watched);
      Watcher.refresh();
      return true;
    }
  };

  Anonymize = {
    init: function() {
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var name, parent, trip;
      if (post.isInlined && !post.isCrosspost) {
        return;
      }
      name = $('.postInfo .name', post.el);
      name.textContent = 'Anonymous';
      if ((trip = name.nextElementSibling) && trip.className === 'postertrip') {
        $.rm(trip);
      }
      if ((parent = name.parentNode).className === 'useremail' && !/^mailto:sage$/i.test(parent.href)) {
        return $.replace(parent, name);
      }
    }
  };

  Sauce = {
    init: function() {
      var link, _i, _len, _ref;
      if (g.BOARD === 'f') {
        return;
      }
      this.links = [];
      _ref = Conf['sauces'].split('\n');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        link = _ref[_i];
        if (link[0] === '#') {
          continue;
        }
        this.links.push(this.createSauceLink(link.trim()));
      }
      if (!this.links.length) {
        return;
      }
      return Main.callbacks.push(this.node);
    },
    createSauceLink: function(link) {
      var domain, el, href, m;
      link = link.replace(/(\$\d)/g, function(parameter) {
        switch (parameter) {
          case '$1':
            return "' + (isArchived ? img.firstChild.src : 'http://thumbs.4chan.org' + img.pathname.replace(/src(\\/\\d+).+$/, 'thumb$1s.jpg')) + '";
          case '$2':
            return "' + encodeURIComponent(img.href) + '";
          case '$3':
            return "' + encodeURIComponent(img.firstChild.dataset.md5) + '";
          case '$4':
            return g.BOARD;
          default:
            return parameter;
        }
      });
      domain = (m = link.match(/;text:(.+)$/)) ? m[1] : link.match(/(\w+)\.\w+\//)[1];
      href = link.replace(/;text:.+$/, '');
      href = Function('img', 'isArchived', "return '" + href + "'");
      el = $.el('a', {
        target: '_blank',
        textContent: domain
      });
      return function(img, isArchived) {
        var a;
        a = el.cloneNode(true);
        a.href = href(img, isArchived);
        return a;
      };
    },
    node: function(post) {
      var img, link, nodes, _i, _len, _ref;
      img = post.img;
      if (post.isInlined && !post.isCrosspost || !img) {
        return;
      }
      img = img.parentNode;
      nodes = [];
      _ref = Sauce.links;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        link = _ref[_i];
        nodes.push($.tn('\u00A0'), link(img, post.isArchived));
      }
      return $.add(post.fileInfo, nodes);
    }
  };

  RevealSpoilers = {
    init: function() {
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var img, s;
      img = post.img;
      if (!(img && /^Spoiler/.test(img.alt)) || post.isInlined && !post.isCrosspost || post.isArchived) {
        return;
      }
      img.removeAttribute('style');
      s = img.style;
      s.maxHeight = s.maxWidth = /\bop\b/.test(post["class"]) ? '250px' : '125px';
      return img.src = "//thumbs.4chan.org" + (img.parentNode.pathname.replace(/src(\/\d+).+$/, 'thumb$1s.jpg'));
    }
  };

  RemoveSpoilers = {
    init: function() {
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var spoiler, spoilers, _i, _len;
      spoilers = $$('s', post.el);
      for (_i = 0, _len = spoilers.length; _i < _len; _i++) {
        spoiler = spoilers[_i];
        $.replace(spoiler, $.tn(spoiler.textContent));
      }
    }
  };

  Time = {
    init: function() {
      Time.foo();
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var node;
      if (post.isInlined && !post.isCrosspost) {
        return;
      }
      node = $('.postInfo > .dateTime', post.el);
      Time.date = new Date(node.dataset.utc * 1000);
      return node.textContent = Time.funk(Time);
    },
    foo: function() {
      var code;
      code = Conf['time'].replace(/%([A-Za-z])/g, function(s, c) {
        if (c in Time.formatters) {
          return "' + Time.formatters." + c + "() + '";
        } else {
          return s;
        }
      });
      return Time.funk = Function('Time', "return '" + code + "'");
    },
    day: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
    month: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
    zeroPad: function(n) {
      if (n < 10) {
        return '0' + n;
      } else {
        return n;
      }
    },
    formatters: {
      a: function() {
        return Time.day[Time.date.getDay()].slice(0, 3);
      },
      A: function() {
        return Time.day[Time.date.getDay()];
      },
      b: function() {
        return Time.month[Time.date.getMonth()].slice(0, 3);
      },
      B: function() {
        return Time.month[Time.date.getMonth()];
      },
      d: function() {
        return Time.zeroPad(Time.date.getDate());
      },
      e: function() {
        return Time.date.getDate();
      },
      H: function() {
        return Time.zeroPad(Time.date.getHours());
      },
      I: function() {
        return Time.zeroPad(Time.date.getHours() % 12 || 12);
      },
      k: function() {
        return Time.date.getHours();
      },
      l: function() {
        return Time.date.getHours() % 12 || 12;
      },
      m: function() {
        return Time.zeroPad(Time.date.getMonth() + 1);
      },
      M: function() {
        return Time.zeroPad(Time.date.getMinutes());
      },
      p: function() {
        if (Time.date.getHours() < 12) {
          return 'AM';
        } else {
          return 'PM';
        }
      },
      P: function() {
        if (Time.date.getHours() < 12) {
          return 'am';
        } else {
          return 'pm';
        }
      },
      S: function() {
        return Time.zeroPad(Time.date.getSeconds());
      },
      y: function() {
        return Time.date.getFullYear() - 2000;
      }
    }
  };

  RelativeDates = {
    INTERVAL: $.MINUTE,
    init: function() {
      Main.callbacks.push(this.node);
      return $.on(d, 'visibilitychange', this.flush);
    },
    node: function(post) {
      var dateEl, diff, utc;
      dateEl = $('.postInfo > .dateTime', post.el);
      dateEl.title = dateEl.textContent;
      utc = dateEl.dataset.utc * 1000;
      diff = Date.now() - utc;
      dateEl.textContent = RelativeDates.relative(diff);
      RelativeDates.setUpdate(dateEl, utc, diff);
      return RelativeDates.flush();
    },
    relative: function(diff) {
      var number, rounded, unit;
      unit = (number = diff / $.DAY) > 1 ? 'day' : (number = diff / $.HOUR) > 1 ? 'hour' : (number = diff / $.MINUTE) > 1 ? 'minute' : (number = diff / $.SECOND, 'second');
      rounded = Math.round(number);
      if (rounded !== 1) {
        unit += 's';
      }
      return "" + rounded + " " + unit + " ago";
    },
    stale: [],
    flush: $.debounce($.SECOND, function() {
      var now, update, _i, _len, _ref;
      if (d.hidden) {
        return;
      }
      now = Date.now();
      _ref = RelativeDates.stale;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        update = _ref[_i];
        update(now);
      }
      RelativeDates.stale = [];
      clearTimeout(RelativeDates.timeout);
      return RelativeDates.timeout = setTimeout(RelativeDates.flush, RelativeDates.INTERVAL);
    }),
    setUpdate: function(dateEl, utc, diff) {
      var markStale, setOwnTimeout, update;
      setOwnTimeout = function(diff) {
        var delay;
        delay = diff < $.MINUTE ? $.SECOND - (diff + $.SECOND / 2) % $.SECOND : diff < $.HOUR ? $.MINUTE - (diff + $.MINUTE / 2) % $.MINUTE : $.HOUR - (diff + $.HOUR / 2) % $.HOUR;
        return setTimeout(markStale, delay);
      };
      update = function(now) {
        if (d.contains(dateEl)) {
          diff = now - utc;
          dateEl.textContent = RelativeDates.relative(diff);
          return setOwnTimeout(diff);
        }
      };
      markStale = function() {
        return RelativeDates.stale.push(update);
      };
      return setOwnTimeout(diff);
    }
  };

  FileInfo = {
    init: function() {
      if (g.BOARD === 'f') {
        return;
      }
      this.setFormats();
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var alt, filename, node, _ref;
      if (post.isInlined && !post.isCrosspost || !post.fileInfo) {
        return;
      }
      node = post.fileInfo.firstElementChild;
      alt = post.img.alt;
      filename = ((_ref = $('span', node)) != null ? _ref.title : void 0) || node.title;
      FileInfo.data = {
        link: post.img.parentNode.href,
        spoiler: /^Spoiler/.test(alt),
        size: alt.match(/\d+\.?\d*/)[0],
        unit: alt.match(/\w+$/)[0],
        resolution: node.textContent.match(/\d+x\d+|PDF/)[0],
        fullname: filename,
        shortname: Build.shortFilename(filename, post.ID === post.threadID)
      };
      node.setAttribute('data-filename', filename);
      return node.innerHTML = FileInfo.funk(FileInfo);
    },
    setFormats: function() {
      var code;
      code = Conf['fileInfo'].replace(/%(.)/g, function(s, c) {
        if (c in FileInfo.formatters) {
          return "' + f.formatters." + c + "() + '";
        } else {
          return s;
        }
      });
      return this.funk = Function('f', "return '" + code + "'");
    },
    convertUnit: function(unitT) {
      var i, size, unitF, units;
      size = this.data.size;
      unitF = this.data.unit;
      if (unitF !== unitT) {
        units = ['B', 'KB', 'MB'];
        i = units.indexOf(unitF) - units.indexOf(unitT);
        if (unitT === 'B') {
          unitT = 'Bytes';
        }
        if (i > 0) {
          while (i-- > 0) {
            size *= 1024;
          }
        } else if (i < 0) {
          while (i++ < 0) {
            size /= 1024;
          }
        }
        if (size < 1 && size.toString().length > size.toFixed(2).length) {
          size = size.toFixed(2);
        }
      }
      return "" + size + " " + unitT;
    },
    formatters: {
      t: function() {
        return FileInfo.data.link.match(/\d+\..+$/)[0];
      },
      T: function() {
        return "<a href=" + FileInfo.data.link + " target=_blank>" + (this.t()) + "</a>";
      },
      l: function() {
        return "<a href=" + FileInfo.data.link + " target=_blank>" + (this.n()) + "</a>";
      },
      L: function() {
        return "<a href=" + FileInfo.data.link + " target=_blank>" + (this.N()) + "</a>";
      },
      n: function() {
        if (FileInfo.data.fullname === FileInfo.data.shortname) {
          return FileInfo.data.fullname;
        } else {
          return "<span class=fntrunc>" + FileInfo.data.shortname + "</span><span class=fnfull>" + FileInfo.data.fullname + "</span>";
        }
      },
      N: function() {
        return FileInfo.data.fullname;
      },
      p: function() {
        if (FileInfo.data.spoiler) {
          return 'Spoiler, ';
        } else {
          return '';
        }
      },
      s: function() {
        return "" + FileInfo.data.size + " " + FileInfo.data.unit;
      },
      B: function() {
        return FileInfo.convertUnit('B');
      },
      K: function() {
        return FileInfo.convertUnit('KB');
      },
      M: function() {
        return FileInfo.convertUnit('MB');
      },
      r: function() {
        return FileInfo.data.resolution;
      }
    }
  };

  Get = {
    post: function(board, threadID, postID, root, cb) {
      var post, url;
      if (board === g.BOARD && (post = $.id("pc" + postID))) {
        $.add(root, Get.cleanPost(post.cloneNode(true)));
        return;
      }
      root.textContent = "Loading post No." + postID + "...";
      if (threadID) {
        return $.cache("//api.4chan.org/" + board + "/res/" + threadID + ".json", function() {
          return Get.parsePost(this, board, threadID, postID, root, cb);
        });
      } else if (url = Redirect.post(board, postID)) {
        return $.cache(url, function() {
          return Get.parseArchivedPost(this, board, postID, root, cb);
        });
      }
    },
    parsePost: function(req, board, threadID, postID, root, cb) {
      var post, posts, spoilerRange, status, url, _i, _len;
      status = req.status;
      if (status !== 200) {
        if (url = Redirect.post(board, postID)) {
          $.cache(url, function() {
            return Get.parseArchivedPost(this, board, postID, root, cb);
          });
        } else {
          $.addClass(root, 'warning');
          root.textContent = status === 404 ? "Thread No." + threadID + " 404'd." : "Error " + req.status + ": " + req.statusText + ".";
        }
        return;
      }
      posts = JSON.parse(req.response).posts;
      if (spoilerRange = posts[0].custom_spoiler) {
        Build.spoilerRange[board] = spoilerRange;
      }
      postID = +postID;
      for (_i = 0, _len = posts.length; _i < _len; _i++) {
        post = posts[_i];
        if (post.no === postID) {
          break;
        }
        if (post.no > postID) {
          if (url = Redirect.post(board, postID)) {
            $.cache(url, function() {
              return Get.parseArchivedPost(this, board, postID, root, cb);
            });
          } else {
            $.addClass(root, 'warning');
            root.textContent = "Post No." + postID + " was not found.";
          }
          return;
        }
      }
      $.replace(root.firstChild, Get.cleanPost(Build.postFromObject(post, board)));
      if (cb) {
        return cb();
      }
    },
    parseArchivedPost: function(req, board, postID, root, cb) {
      var bq, comment, data, o, _ref;
      data = JSON.parse(req.response);
      if (data.error) {
        $.addClass(root, 'warning');
        root.textContent = data.error;
        return;
      }
      bq = $.el('blockquote', {
        textContent: data.comment
      });
      bq.innerHTML = bq.innerHTML.replace(/\n|\[\/?b\]|\[\/?spoiler\]|\[\/?code\]|\[\/?moot\]|\[\/?banned\]/g, function(text) {
        switch (text) {
          case '\n':
            return '<br>';
          case '[b]':
            return '<b>';
          case '[/b]':
            return '</b>';
          case '[spoiler]':
            return '<s>';
          case '[/spoiler]':
            return '</s>';
          case '[code]':
            return '<pre class=prettyprint>';
          case '[/code]':
            return '</pre>';
          case '[moot]':
            return '<div style="padding:5px;margin-left:.5em;border-color:#faa;border:2px dashed rgba(255,0,0,.1);border-radius:2px">';
          case '[/moot]':
            return '</div>';
          case '[banned]':
            return '<b style="color: red;">';
          case '[/banned]':
            return '</b>';
        }
      });
      comment = bq.innerHTML.replace(/(^|>)(&gt;[^<$]*)(<|$)/g, '$1<span class=quote>$2</span>$3');
      comment = comment.replace(/((&gt;){2}(&gt;\/[a-z\d]+\/)?\d+)/g, '<span class=deadlink>$1</span>');
      o = {
        postID: postID,
        threadID: data.thread_num,
        board: board,
        name: data.name_processed,
        capcode: (function() {
          switch (data.capcode) {
            case 'M':
              return 'mod';
            case 'A':
              return 'admin';
            case 'D':
              return 'developer';
          }
        })(),
        tripcode: data.trip,
        uniqueID: data.poster_hash,
        email: data.email ? encodeURI(data.email) : '',
        subject: data.title_processed,
        flagCode: data.poster_country,
        flagName: data.poster_country_name_processed,
        date: data.fourchan_date,
        dateUTC: data.timestamp,
        comment: comment
      };
      if ((_ref = data.media) != null ? _ref.media_filename : void 0) {
        o.file = {
          name: data.media.media_filename_processed,
          timestamp: data.media.media_orig,
          url: data.media.media_link || data.media.remote_media_link,
          height: data.media.media_h,
          width: data.media.media_w,
          MD5: data.media.media_hash,
          size: data.media.media_size,
          turl: data.media.thumb_link || ("//thumbs.4chan.org/" + board + "/thumb/" + data.media.preview_orig),
          theight: data.media.preview_h,
          twidth: data.media.preview_w,
          isSpoiler: data.media.spoiler === '1'
        };
      }
      $.replace(root.firstChild, Get.cleanPost(Build.post(o, true)));
      if (cb) {
        return cb();
      }
    },
    cleanPost: function(root) {
      var child, el, els, inline, inlined, now, post, _i, _j, _k, _l, _len, _len1, _len2, _len3, _ref, _ref1, _ref2;
      post = $('.post', root);
      _ref = Array.prototype.slice.call(root.childNodes);
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        if (child !== post) {
          $.rm(child);
        }
      }
      _ref1 = $$('.inline', post);
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        inline = _ref1[_j];
        $.rm(inline);
      }
      _ref2 = $$('.inlined', post);
      for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
        inlined = _ref2[_k];
        $.rmClass(inlined, 'inlined');
      }
      now = Date.now();
      els = $$('[id]', root);
      els.push(root);
      for (_l = 0, _len3 = els.length; _l < _len3; _l++) {
        el = els[_l];
        el.id = "" + now + "_" + el.id;
      }
      $.rmClass(root, 'forwarded');
      $.rmClass(root, 'qphl');
      $.rmClass(post, 'highlight');
      $.rmClass(post, 'qphl');
      root.hidden = post.hidden = false;
      return root;
    },
    title: function(thread) {
      var el, op, span;
      op = $('.op', thread);
      el = $('.postInfo .subject', op);
      if (!el.textContent) {
        el = $('blockquote', op);
        if (!el.textContent) {
          el = $('.nameBlock', op);
        }
      }
      span = $.el('span', {
        innerHTML: el.innerHTML.replace(/<br>/g, ' ')
      });
      return "/" + g.BOARD + "/ - " + (span.textContent.trim());
    }
  };

  Build = {
    spoilerRange: {},
    shortFilename: function(filename, isOP) {
      var threshold;
      threshold = isOP ? 40 : 30;
      if (filename.length - 4 > threshold) {
        return "" + filename.slice(0, threshold - 5) + "(...)." + filename.slice(-3);
      } else {
        return filename;
      }
    },
    postFromObject: function(data, board) {
      var o;
      o = {
        postID: data.no,
        threadID: data.resto || data.no,
        board: board,
        name: data.name,
        capcode: data.capcode,
        tripcode: data.trip,
        uniqueID: data.id,
        email: data.email ? encodeURI(data.email.replace(/&quot;/g, '"')) : '',
        subject: data.sub,
        flagCode: data.country,
        flagName: data.country_name,
        date: data.now,
        dateUTC: data.time,
        comment: data.com,
        isSticky: !!data.sticky,
        isClosed: !!data.closed
      };
      if (data.ext || data.filedeleted) {
        o.file = {
          name: data.filename + data.ext,
          timestamp: "" + data.tim + data.ext,
          url: "//images.4chan.org/" + board + "/src/" + data.tim + data.ext,
          height: data.h,
          width: data.w,
          MD5: data.md5,
          size: data.fsize,
          turl: "//thumbs.4chan.org/" + board + "/thumb/" + data.tim + "s.jpg",
          theight: data.tn_h,
          twidth: data.tn_w,
          isSpoiler: !!data.spoiler,
          isDeleted: !!data.filedeleted
        };
      }
      return Build.post(o);
    },
    post: function(o, isArchived) {
      /*
      This function contains code from 4chan-JS (https://github.com/4chan/4chan-JS).
      @license: https://github.com/4chan/4chan-JS/blob/master/LICENSE
      */

      var a, board, capcode, capcodeClass, capcodeStart, closed, comment, container, date, dateUTC, email, emailEnd, emailStart, ext, file, fileDims, fileHTML, fileInfo, fileSize, fileThumb, filename, flag, flagCode, flagName, href, imgSrc, isClosed, isOP, isSticky, name, postID, quote, shortFilename, spoilerRange, staticPath, sticky, subject, threadID, tripcode, uniqueID, userID, _i, _len, _ref;
      postID = o.postID, threadID = o.threadID, board = o.board, name = o.name, capcode = o.capcode, tripcode = o.tripcode, uniqueID = o.uniqueID, email = o.email, subject = o.subject, flagCode = o.flagCode, flagName = o.flagName, date = o.date, dateUTC = o.dateUTC, isSticky = o.isSticky, isClosed = o.isClosed, comment = o.comment, file = o.file;
      isOP = postID === threadID;
      staticPath = '//static.4chan.org';
      if (email) {
        emailStart = '<a href="mailto:' + email + '" class="useremail">';
        emailEnd = '</a>';
      } else {
        emailStart = '';
        emailEnd = '';
      }
      subject = "<span class=subject>" + (subject || '') + "</span>";
      userID = !capcode && uniqueID ? (" <span class='posteruid id_" + uniqueID + "'>(ID: ") + ("<span class=hand title='Highlight posts by this ID'>" + uniqueID + "</span>)</span> ") : '';
      switch (capcode) {
        case 'admin':
        case 'admin_highlight':
          capcodeClass = " capcodeAdmin";
          capcodeStart = " <strong class='capcode hand id_admin'" + "title='Highlight posts by the Administrator'>## Admin</strong>";
          capcode = (" <img src='" + staticPath + "/image/adminicon.gif' ") + "alt='This user is the 4chan Administrator.' " + "title='This user is the 4chan Administrator.' class=identityIcon>";
          break;
        case 'mod':
          capcodeClass = " capcodeMod";
          capcodeStart = " <strong class='capcode hand id_mod' " + "title='Highlight posts by Moderators'>## Mod</strong>";
          capcode = (" <img src='" + staticPath + "/image/modicon.gif' ") + "alt='This user is a 4chan Moderator.' " + "title='This user is a 4chan Moderator.' class=identityIcon>";
          break;
        case 'developer':
          capcodeClass = " capcodeDeveloper";
          capcodeStart = " <strong class='capcode hand id_developer' " + "title='Highlight posts by Developers'>## Developer</strong>";
          capcode = (" <img src='" + staticPath + "/image/developericon.gif' ") + "alt='This user is a 4chan Developer.' " + "title='This user is a 4chan Developer.' class=identityIcon>";
          break;
        default:
          capcodeClass = '';
          capcodeStart = '';
          capcode = '';
      }
      flag = flagCode ? (" <img src='" + staticPath + "/image/country/" + (board === 'pol' ? 'troll/' : '')) + flagCode.toLowerCase() + (".gif' alt=" + flagCode + " title='" + flagName + "' class=countryFlag>") : '';
      if (file != null ? file.isDeleted : void 0) {
        fileHTML = isOP ? ("<div class=file id=f" + postID + "><div class=fileInfo></div><span class=fileThumb>") + ("<img src='" + staticPath + "/image/filedeleted.gif' alt='File deleted.' class='fileDeleted retina'>") + "</span></div>" : ("<div id=f" + postID + " class=file><span class=fileThumb>") + ("<img src='" + staticPath + "/image/filedeleted-res.gif' alt='File deleted.' class='fileDeletedRes retina'>") + "</span></div>";
      } else if (file) {
        ext = file.name.slice(-3);
        if (!file.twidth && !file.theight && ext === 'gif') {
          file.twidth = file.width;
          file.theight = file.height;
        }
        fileSize = $.bytesToString(file.size);
        fileThumb = file.turl;
        if (file.isSpoiler) {
          fileSize = "Spoiler Image, " + fileSize;
          if (!isArchived) {
            fileThumb = '//static.4chan.org/image/spoiler';
            if (spoilerRange = Build.spoilerRange[board]) {
              fileThumb += ("-" + board) + Math.floor(1 + spoilerRange * Math.random());
            }
            fileThumb += '.png';
            file.twidth = file.theight = 100;
          }
        }
        imgSrc = ("<a class='fileThumb" + (file.isSpoiler ? ' imgspoiler' : '') + "' href='" + file.url + "' target=_blank>") + ("<img src='" + fileThumb + "' alt='" + fileSize + "' data-md5=" + file.MD5 + " style='width:" + file.twidth + "px;height:" + file.theight + "px'></a>");
        a = $.el('a', {
          innerHTML: file.name
        });
        filename = a.textContent.replace(/%22/g, '"');
        a.textContent = Build.shortFilename(filename);
        shortFilename = a.innerHTML;
        a.textContent = filename;
        filename = a.innerHTML.replace(/'/g, '&apos;');
        fileDims = ext === 'pdf' ? 'PDF' : "" + file.width + "x" + file.height;
        fileInfo = ("<span class=fileText id=fT" + postID + (file.isSpoiler ? " title='" + filename + "'" : '') + ">File: <a href='" + file.url + "' target=_blank>" + file.timestamp + "</a>") + ("-(" + fileSize + ", " + fileDims + (file.isSpoiler ? '' : ", <span title='" + filename + "'>" + shortFilename + "</span>")) + ")</span>";
        fileHTML = "<div id=f" + postID + " class=file><div class=fileInfo>" + fileInfo + "</div>" + imgSrc + "</div>";
      } else {
        fileHTML = '';
      }
      tripcode = tripcode ? " <span class=postertrip>" + tripcode + "</span>" : '';
      sticky = isSticky ? ' <img src=//static.4chan.org/image/sticky.gif alt=Sticky title=Sticky style="height:16px;width:16px">' : '';
      closed = isClosed ? ' <img src=//static.4chan.org/image/closed.gif alt=Closed title=Closed style="height:16px;width:16px">' : '';
      container = $.el('div', {
        id: "pc" + postID,
        className: "postContainer " + (isOP ? 'op' : 'reply') + "Container",
        innerHTML: (isOP ? '' : "<div class=sideArrows id=sa" + postID + ">&gt;&gt;</div>") + ("<div id=p" + postID + " class='post " + (isOP ? 'op' : 'reply') + (capcode === 'admin_highlight' ? ' highlightPost' : '') + "'>") + ("<div class='postInfoM mobile' id=pim" + postID + ">") + ("<span class='nameBlock" + capcodeClass + "'>") + ("<span class=name>" + (name || '') + "</span>") + tripcode + capcodeStart + capcode + userID + flag + sticky + closed + ("<br>" + subject) + ("</span><span class='dateTime postNum' data-utc=" + dateUTC + ">" + date) + '<br><em>' + ("<a href=" + ("/" + board + "/res/" + threadID + "#p" + postID) + ">No.</a>") + ("<a href='" + (g.REPLY && g.THREAD_ID === threadID ? "javascript:quote(" + postID + ")" : "/" + board + "/res/" + threadID + "#q" + postID) + "'>" + postID + "</a>") + '</em></span>' + '</div>' + (isOP ? fileHTML : '') + ("<div class='postInfo desktop' id=pi" + postID + ">") + ("<input type=checkbox name=" + postID + " value=delete> ") + ("" + subject + " ") + ("<span class='nameBlock" + capcodeClass + "'>") + emailStart + ("<span class=name>" + (name || '') + "</span>") + tripcode + capcodeStart + emailEnd + capcode + userID + flag + sticky + closed + ' </span> ' + ("<span class=dateTime data-utc=" + dateUTC + ">" + date + "</span> ") + "<span class='postNum desktop'>" + ("<a href=" + ("/" + board + "/res/" + threadID + "#p" + postID) + " title='Highlight this post'>No.</a>") + ("<a href='" + (g.REPLY && +g.THREAD_ID === threadID ? "javascript:quote(" + postID + ")" : "/" + board + "/res/" + threadID + "#q" + postID) + "' title='Quote this post'>" + postID + "</a>") + '</span>' + '</div>' + (isOP ? '' : fileHTML) + ("<blockquote class=postMessage id=m" + postID + ">" + (comment || '') + "</blockquote> ") + '</div>'
      });
      _ref = $$('.quotelink', container);
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        quote = _ref[_i];
        href = quote.getAttribute('href');
        if (href[0] === '/') {
          continue;
        }
        quote.href = "/" + board + "/res/" + href;
      }
      return container;
    }
  };

  TitlePost = {
    init: function() {
      return d.title = Get.title();
    }
  };

  QuoteBacklink = {
    init: function() {
      var format;
      format = Conf['backlink'].replace(/%id/g, "' + id + '");
      this.funk = Function('id', "return '" + format + "'");
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var a, container, el, link, qid, quote, quotes, _i, _len, _ref;
      if (post.isInlined) {
        return;
      }
      quotes = {};
      _ref = post.quotes;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        quote = _ref[_i];
        if (quote.parentNode.parentNode.className === 'capcodeReplies') {
          break;
        }
        if (quote.hostname === 'boards.4chan.org' && !/catalog$/.test(quote.pathname) && (qid = quote.hash.slice(2))) {
          quotes[qid] = true;
        }
      }
      a = $.el('a', {
        href: "/" + g.BOARD + "/res/" + post.threadID + "#p" + post.ID,
        className: post.el.hidden ? 'filtered backlink' : 'backlink',
        textContent: QuoteBacklink.funk(post.ID)
      });
      for (qid in quotes) {
        if (!(el = $.id("pi" + qid)) || !Conf['OP Backlinks'] && /\bop\b/.test(el.parentNode.className)) {
          continue;
        }
        link = a.cloneNode(true);
        if (Conf['Quote Preview']) {
          $.on(link, 'mouseover', QuotePreview.mouseover);
        }
        if (Conf['Quote Inline'] && !(Conf['QI only on index'] && g.REPLY)) {
          $.on(link, 'click', QuoteInline.toggle);
        }
        if (!(container = $.id("blc" + qid))) {
          container = $.el('span', {
            className: 'container',
            id: "blc" + qid
          });
          $.add(el, container);
        }
        $.add(container, [$.tn(' '), link]);
      }
    }
  };

  QuoteInline = {
    init: function() {
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var quote, _i, _j, _len, _len1, _ref, _ref1;
      if (Conf['QI only on index'] && g.REPLY) {
        return;
      }
      _ref = post.quotes;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        quote = _ref[_i];
        if (!(quote.hash && quote.hostname === 'boards.4chan.org' && !/catalog$/.test(quote.pathname) || /\bdeadlink\b/.test(quote.className))) {
          continue;
        }
        $.on(quote, 'click', QuoteInline.toggle);
      }
      _ref1 = post.backlinks;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        quote = _ref1[_j];
        $.on(quote, 'click', QuoteInline.toggle);
      }
    },
    toggle: function(e) {
      var id;
      if (e.shiftKey || e.altKey || e.ctrlKey || e.metaKey || e.button !== 0) {
        return;
      }
      e.preventDefault();
      id = this.dataset.id || this.hash.slice(2);
      if (/\binlined\b/.test(this.className)) {
        QuoteInline.rm(this, id);
      } else {
        if ($.x("ancestor::div[contains(@id,'p" + id + "')]", this)) {
          return;
        }
        QuoteInline.add(this, id);
      }
      return this.classList.toggle('inlined');
    },
    add: function(q, id) {
      var board, el, i, inline, isBacklink, path, postID, root, threadID;
      if (q.host === 'boards.4chan.org') {
        path = q.pathname.split('/');
        board = path[1];
        threadID = path[3];
        postID = id;
      } else {
        board = q.dataset.board;
        threadID = 0;
        postID = q.dataset.id;
      }
      el = board === g.BOARD ? $.id("p" + postID) : false;
      inline = $.el('div', {
        id: "i" + postID,
        className: el ? 'inline' : 'inline crosspost'
      });
      root = (isBacklink = /\bbacklink\b/.test(q.className)) ? q.parentNode : $.x('ancestor-or-self::*[parent::blockquote][1]', q);
      $.after(root, inline);
      Get.post(board, threadID, postID, inline);
      if (!el) {
        return;
      }
      if (isBacklink && Conf['Forward Hiding']) {
        $.addClass(el.parentNode, 'forwarded');
        ++el.dataset.forwarded || (el.dataset.forwarded = 1);
      }
      if ((i = Unread.replies.indexOf(el)) !== -1) {
        Unread.replies.splice(i, 1);
        Unread.update(true);
      }
      if (Conf['Color user IDs'] && (board === 'b' || board === 'q' || board === 'soc')) {
        return setTimeout(function() {
          return $.rmClass($('.reply.highlight', inline), 'highlight');
        });
      }
    },
    rm: function(q, id) {
      var div, inlined, _i, _len, _ref;
      div = $.x("following::div[@id='i" + id + "']", q);
      $.rm(div);
      if (!Conf['Forward Hiding']) {
        return;
      }
      _ref = $$('.backlink.inlined', div);
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        inlined = _ref[_i];
        div = $.id(inlined.hash.slice(1));
        if (!--div.dataset.forwarded) {
          $.rmClass(div.parentNode, 'forwarded');
        }
      }
      if (/\bbacklink\b/.test(q.className)) {
        div = $.id("p" + id);
        if (!--div.dataset.forwarded) {
          return $.rmClass(div.parentNode, 'forwarded');
        }
      }
    }
  };

  QuotePreview = {
    init: function() {
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var quote, _i, _j, _len, _len1, _ref, _ref1;
      _ref = post.quotes;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        quote = _ref[_i];
        if (!(quote.hash && quote.hostname === 'boards.4chan.org' && !/catalog$/.test(quote.pathname) || /\bdeadlink\b/.test(quote.className))) {
          continue;
        }
        $.on(quote, 'mouseover', QuotePreview.mouseover);
      }
      _ref1 = post.backlinks;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        quote = _ref1[_j];
        $.on(quote, 'mouseover', QuotePreview.mouseover);
      }
    },
    mouseover: function(e) {
      var board, el, path, postID, qp, quote, quoterID, threadID, yourPost, _i, _len, _ref;
      if (/\binlined\b/.test(this.className)) {
        return;
      }
      if (qp = $.id('qp')) {
        if (qp === UI.el) {
          delete UI.el;
        }
        $.rm(qp);
      }
      if (UI.el) {
        return;
      }
      if (this.host === 'boards.4chan.org') {
        path = this.pathname.split('/');
        board = path[1];
        threadID = path[3];
        postID = this.hash.slice(2);
      } else {
        board = this.dataset.board;
        threadID = 0;
        postID = this.dataset.id;
      }
      qp = UI.el = $.el('div', {
        id: 'qp',
        className: 'reply dialog'
      });
      UI.hover(e);
      $.add(d.body, qp);
      if (board === g.BOARD) {
        el = $.id("p" + postID);
      }
      Get.post(board, threadID, postID, qp, function() {
        var bq, img, post;
        bq = $('blockquote', qp);
        Main.prettify(bq);
        post = {
          el: qp,
          blockquote: bq,
          isArchived: /\barchivedPost\b/.test(qp.className)
        };
        if (img = $('img[data-md5]', qp)) {
          post.fileInfo = img.parentNode.previousElementSibling;
          post.img = img;
        }
        if (Conf['Reveal Spoilers']) {
          RevealSpoilers.node(post);
        }
        if (Conf['Time Formatting']) {
          Time.node(post);
        }
        if (Conf['File Info Formatting']) {
          FileInfo.node(post);
        }
        if (Conf['Linkify']) {
          Linkify.node(post);
        }
        if (Conf['Resurrect Quotes']) {
          Quotify.node(post);
        }
        if (Conf['Anonymize']) {
          Anonymize.node(post);
        }
        if (Conf['Replace GIF'] || Conf['Replace PNG'] || Conf['Replace JPG']) {
          ImageReplace.node(post);
        }
        if (Conf['Color user IDs'] && (board === 'b' || board === 'q' || board === 'soc')) {
          IDColor.node(post);
        }
        if (Conf['RemoveSpoilers']) {
          return RemoveSpoilers.node(post);
        }
      });
      $.on(this, 'mousemove', UI.hover);
      $.on(this, 'mouseout click', QuotePreview.mouseout);
      if (!el) {
        return;
      }
      if (Conf['Indicate Quotes of You'] && /\byourPost\b/.test(el.className)) {
        $.rmClass((yourPost = $('.reply.yourPost', qp)), 'yourPost');
        $.addClass(qp, 'yourPost');
      }
      if (Conf['Quote Highlighting']) {
        if (/\bop\b/.test(el.className)) {
          $.addClass(el.parentNode, 'qphl');
        } else {
          $.addClass(el, 'qphl');
        }
      }
      quoterID = $.x('ancestor::*[@id][1]', this).id.match(/\d+$/)[0];
      _ref = $$('.quotelink, .backlink', qp);
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        quote = _ref[_i];
        if (quote.hash.slice(2) === quoterID) {
          $.addClass(quote, 'forwardlink');
        }
      }
    },
    mouseout: function(e) {
      var el;
      UI.hoverend();
      if (el = $.id(this.hash.slice(1))) {
        $.rmClass(el, 'qphl');
        $.rmClass(el.parentNode, 'qphl');
      }
      $.off(this, 'mousemove', UI.hover);
      return $.off(this, 'mouseout click', QuotePreview.mouseout);
    }
  };

  QuoteYou = {
    init: function() {
      $.on(d, 'QRPostSuccessful', this.post);
      $.on(d, 'theThreadisDead', this.prune);
      this.posts = $.get('yourPosts', {});
      return Main.callbacks.push(this.node);
    },
    post: function(e) {
      var postID, posts, threadID, _ref;
      _ref = e.detail, postID = _ref.postID, threadID = _ref.threadID;
      if (threadID === '0') {
        return;
      }
      if (!(posts = QuoteYou.posts[threadID])) {
        posts = [];
      }
      posts.push(postID);
      QuoteYou.posts[threadID] = posts;
      return $.set('yourPosts', QuoteYou.posts);
    },
    node: function(post) {
      var posts, quote, _i, _len, _ref, _ref1, _ref2;
      posts = QuoteYou.posts;
      posts = posts[post.threadID];
      if (!posts || post.isInlined && !post.isCrosspost) {
        return;
      }
      if (_ref = post.ID, __indexOf.call(posts, _ref) >= 0) {
        $.addClass(post.el, 'yourPost');
      }
      _ref1 = post.quotes;
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        quote = _ref1[_i];
        if (_ref2 = quote.hash.slice(2), __indexOf.call(posts, _ref2) >= 0) {
          $.add(quote, $.tn('\u00A0(You)'));
        }
      }
    },
    prune: function() {
      var posts;
      if (!(posts = QuoteYou.posts)[g.THREAD_ID]) {
        return;
      }
      delete posts[g.THREAD_ID];
      return $.set('yourPosts', posts);
    }
  };

  QuoteOP = {
    init: function() {
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var quote, _i, _len, _ref;
      if (post.isInlined && !post.isCrosspost) {
        return;
      }
      _ref = post.quotes;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        quote = _ref[_i];
        if (quote.hash.slice(2) === post.threadID) {
          $.add(quote, $.tn('\u00A0(OP)'));
        }
      }
    }
  };

  QuoteCT = {
    init: function() {
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var path, quote, _i, _len, _ref;
      if (post.isInlined && !post.isCrosspost) {
        return;
      }
      _ref = post.quotes;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        quote = _ref[_i];
        if (!(quote.hash && quote.hostname === 'boards.4chan.org' && !/catalog$/.test(quote.pathname))) {
          continue;
        }
        path = quote.pathname.split('/');
        if (path[1] === g.BOARD && path[3] !== post.threadID) {
          $.add(quote, $.tn('\u00A0(Cross-thread)'));
        }
      }
    }
  };

  IDColor = {
    init: function() {
      var _ref;
      if ((_ref = g.BOARD) !== 'b' && _ref !== 'q' && _ref !== 'soc') {
        return;
      }
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var str, uid;
      if (!(uid = post.el.getElementsByClassName('hand')[1])) {
        return;
      }
      str = uid.textContent;
      if (uid.nodeName === 'SPAN') {
        uid.style.cssText = IDColor.apply.call(str);
      }
      if (!IDColor.highlight[str]) {
        IDColor.highlight[str] = [];
      }
      if (str === $.get("highlightedID/" + g.BOARD + "/")) {
        $.addClass(post.el, 'highlight');
        IDColor.highlight.current.push(post);
      }
      IDColor.highlight[str].push(post);
      return $.on(uid, 'click', function() {
        return IDColor.idClick(str);
      });
    },
    ids: {},
    compute: function(str) {
      var hash, rgb;
      rgb = [];
      hash = this.hash(str);
      rgb[0] = (hash >> 24) & 0xFF;
      rgb[1] = (hash >> 16) & 0xFF;
      rgb[2] = (hash >> 8) & 0xFF;
      rgb[3] = ((rgb[0] * 0.299) + (rgb[1] * 0.587) + (rgb[2] * 0.114)) > 125;
      this.ids[str] = rgb;
      return rgb;
    },
    apply: function() {
      var rgb;
      rgb = IDColor.ids[this] || IDColor.compute(this);
      return ("background-color: rgb(" + rgb[0] + "," + rgb[1] + "," + rgb[2] + "); color: ") + (rgb[3] ? "black;" : "white;");
    },
    hash: function(str) {
      var i, j, msg;
      msg = 0;
      i = 0;
      j = str.length;
      while (i < j) {
        msg = ((msg << 5) - msg) + str.charCodeAt(i);
        ++i;
      }
      return msg;
    },
    highlight: {
      current: []
    },
    idClick: function(str) {
      var last, post, value, _i, _j, _len, _len1, _ref, _ref1;
      _ref = this.highlight.current;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        post = _ref[_i];
        $.rmClass(post.el, 'highlight');
      }
      last = $.get(value = "highlightedID/" + g.BOARD + "/", false);
      if (str === last) {
        this.highlight.current = [];
        return $["delete"](value);
      }
      _ref1 = this.highlight[str];
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        post = _ref1[_j];
        if (post.isInlined) {
          continue;
        }
        $.addClass(post.el, 'highlight');
        this.highlight.current.push(post);
      }
      return $.set(value, str);
    }
  };

  Linkify = {
    init: function() {
      return Main.callbacks.push(this.node);
    },
    regString: /(((magnet|mailto)\:|(news|(ht|f)tp(s?))\:\/\/){1}\S+)/gi,
    node: function(post) {
      var a, data, i, index, key, link, linked, links, match, next, node, nodes, prev, service, snapshot, text, type, wbr, _i, _j, _k, _len, _len1, _ref, _ref1, _ref2;
      if (post.isInlined && !post.isCrosspost) {
        return;
      }
      _ref = $$('wbr', post.blockquote);
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        wbr = _ref[_i];
        prev = wbr.previousSibling;
        next = wbr.nextSibling;
        if (!(((prev && next) != null) && prev.data && next.data && prev.data.match(Linkify.regString))) {
          continue;
        }
        $.replace(prev, $.tn([prev.data + next.data]));
        $.rm(next);
        $.rm(wbr);
      }
      snapshot = d.evaluate('.//text()', post.blockquote, null, 6, null);
      for (i = _j = 0, _ref1 = snapshot.snapshotLength; 0 <= _ref1 ? _j < _ref1 : _j > _ref1; i = 0 <= _ref1 ? ++_j : --_j) {
        node = snapshot.snapshotItem(i);
        data = node.data;
        if (!(links = data.match(Linkify.regString))) {
          continue;
        }
        nodes = [];
        for (_k = 0, _len1 = links.length; _k < _len1; _k++) {
          link = links[_k];
          index = data.indexOf(link);
          if (text = data.slice(0, index)) {
            nodes.push($.tn(text));
          }
          a = $.el('a', {
            textContent: link,
            rel: 'nofollow noreferrer',
            target: 'blank',
            href: link.indexOf(':') < 0 ? (link.indexOf('@') > 0 ? 'mailto:' + link : 'http://' + link) : link
          });
          nodes.push(a);
          data = data.slice(index + link.length);
        }
        if (data) {
          nodes.push($.tn(data));
        }
        $.replace(node, nodes);
        $.on(a, 'click', Linkify.concat);
        if (!Conf['Embed']) {
          continue;
        }
        if (linked = Linkify.linked[a.href]) {
          if (linked.title) {
            if (Conf['Show FavIcons']) {
              a.className = "" + linked.service.low + "Title";
              a.textContent = linked.title;
            } else {
              a.textContent = "[" + linked.service.low + "] " + linked.title;
            }
          }
          Linkify.createToggle(a, post.ID);
        } else {
          _ref2 = Linkify.types;
          for (key in _ref2) {
            type = _ref2[key];
            if (!(match = a.href.match(type.regExp))) {
              continue;
            }
            service = {
              low: key,
              name: key.charAt(0).toUpperCase() + key.slice(1),
              type: type
            };
            break;
          }
          if (match === null || !service) {
            continue;
          }
          link = {
            name: match[1],
            href: a.href,
            service: service,
            posts: {}
          };
          Linkify.linked[a.href] = link;
          Linkify.createToggle(a, post.ID);
        }
      }
    },
    linked: {},
    createToggle: function(node, postID) {
      var cached, embed, href, link, service, titles, unembed;
      embed = $.el('span', {
        innerHTML: '[<a href=javascript:; class=embed>embed</a>]'
      });
      unembed = $.el('span', {
        innerHTML: '[<a href=javascript:; class=unembed>unembed</a>]'
      });
      href = node.href;
      $.on(embed, 'click', function() {
        return Linkify.embed(href, postID);
      });
      $.after(node, [$.tn(' '), embed]);
      Linkify.linked[href].posts[postID] = {
        node: node,
        embed: embed,
        unembed: unembed
      };
      link = Linkify.linked[href];
      if (!link.title && Conf[link.service.name] && link.service.type.title) {
        if (!(titles = $.get('CachedTitles', {}))[service = link.service.low]) {
          titles[service] = {};
          $.set('CachedTitles', titles);
        }
        if (cached = Linkify.linked[href].title = titles[service][link.name]) {
          if (Conf['Show FavIcons']) {
            node.className = "" + service + "Title";
            return node.textContent = cached;
          }
          node.textContent = "[" + service + "] " + cached;
        }
        return link.service.type.title.call({
          node: node,
          name: link.name,
          service: service
        });
      }
    },
    embed: function(href, postID) {
      var el, key, link, span, type, value, _ref, _ref1;
      if (typeof href === 'string') {
        link = Linkify.linked[href];
        span = link.posts[postID];
        if (span.el) {
          $.rm(span.embed);
          return $.replace(span.node, [span.el, $.tn(' '), span.unembed]);
        }
        if (!(el = link.service.type.el(link, postID))) {
          return;
        }
        if ((type = link.service.type).style) {
          _ref = type.style;
          for (key in _ref) {
            value = _ref[key];
            el.style[key] = value;
          }
        } else {
          el.style.cssText = "border: 0; width: " + ($.get('embedWidth', Config.embedWidth)) + "px; height: " + ($.get('embedHeight', Config.embedHeight)) + "px";
        }
      } else {
        _ref1 = href, el = _ref1.el, href = _ref1.href, postID = _ref1.postID;
        link = Linkify.linked[href];
        span = link.posts[postID];
      }
      Linkify.linked[href].posts[postID].el = el;
      $.on(span.unembed, 'click', function() {
        return Linkify.unembed(span);
      });
      $.rm(span.embed);
      return $.replace(span.node, [span.el, $.tn(' '), span.unembed]);
    },
    unembed: function(span) {
      $.rm(span.unembed);
      return $.replace(span.el, [span.node, $.tn(' '), span.embed]);
    },
    json: function(info) {
      return $.cache(info.url, function() {
        try {
          info.status = this.status;
          info.txt = this.responseText;
          return Linkify.save(info);
        } catch (err) {

        }
      });
    },
    save: function(info) {
      var i, node, saved, service, status, titles;
      node = info.node, service = info.service, status = info.status;
      titles = $.get('CachedTitles', {});
      i = 2000;
      while (saved = Object.keys(titles[service])[++i]) {
        delete titles[service][saved];
      }
      if (Conf['Show FavIcons']) {
        node.className = "" + service + "Title";
      }
      node.textContent = titles[service][info.name] = (function() {
        switch (status) {
          case 200:
          case 304:
            return Linkify.types[service].text.call(info.txt);
          case 400:
          case 404:
            return "Not Found";
          case 403:
            return "Forbidden or Private";
          default:
            return "" + status + "'d";
        }
      })();
      if (!Conf['Show FavIcons']) {
        node.textContent = "[" + service + "] " + node.textContent;
      }
      return $.set('CachedTitles', titles);
    },
    types: {
      youtube: {
        regExp: /.*(?:youtu.be\/|youtube.*v=|youtube.*\/embed\/|youtube.*\/v\/|youtube.*videos\/)([^#\&\?]*).*/,
        el: function(link) {
          return $.el('iframe', {
            src: "//www.youtube.com/embed/" + link.name
          });
        },
        title: function() {
          this.url = "https://gdata.youtube.com/feeds/api/videos/" + this.name + "?alt=json&fields=title/text(),yt:noembed,app:control/yt:state/@reasonCode";
          return Linkify.json(this);
        },
        text: function() {
          return JSON.parse(this).entry.title.$t;
        }
      },
      vimeo: {
        regExp: /.*(?:vimeo.com\/)([^#\&\?]*).*/,
        el: function(link) {
          return $.el('iframe', {
            src: "//player.vimeo.com/video/" + link.name
          });
        },
        title: function() {
          this.url = "https://vimeo.com/api/oembed.json?url=http://vimeo.com/" + this.name;
          return Linkify.json(this);
        },
        text: function() {
          return JSON.parse(this).title;
        }
      },
      liveleak: {
        regExp: /.*(?:liveleak.com\/view.+i=)([0-9a-z_]+)/,
        el: function(link) {
          return $.el('iframe', {
            src: "http://www.liveleak.com/e/" + link.name + "?autostart=true"
          });
        }
      },
      vocaroo: {
        regExp: /.*(?:vocaroo.com\/i\/)([^#\&\?]*).*/,
        style: {
          border: '0',
          width: '150px',
          height: '45px'
        },
        el: function(link) {
          return $.el('iframe', {
            src: "http://vocaroo.com/player.swf?playMediaID=" + link.name + "&autoplay=0"
          });
        }
      },
      soundcloud: {
        regExp: /.*(?:soundcloud.com\/|snd.sc\/)([^#\&\?]*).*/,
        url: "//soundcloud.com/oembed?show_artwork=false&&maxwidth=500px&show_comments=false&format=json&url=",
        el: function(link, postID) {
          var href;
          href = link.href;
          $.cache(Linkify.types.soundcloud.url + href, function() {
            var response;
            response = {
              el: $.el('div', {
                innerHTML: JSON.parse(this.responseText).html
              }),
              href: href,
              postID: postID
            };
            return Linkify.embed(response);
          });
          return false;
        },
        title: function() {
          this.url = Linkify.types.soundcloud.url + this.node.href;
          return Linkify.json(this);
        },
        text: function() {
          return JSON.parse(this).title;
        }
      },
      audio: {
        regExp: /(.*\.(mp3|ogg|wav))$/,
        style: {
          width: '400px',
          heigth: '30px'
        },
        el: function(link) {
          return $.el('audio', {
            controls: 'controls',
            preload: 'auto',
            src: link.href,
            textContent: 'You should get a better browser.'
          });
        }
      }
    }
  };

  Quotify = {
    init: function() {
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var a, board, deadlink, id, m, postBoard, quote, _i, _len, _ref, _ref1;
      if (post.isInlined && !post.isCrosspost) {
        return;
      }
      _ref = $$('.deadlink', post.blockquote);
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        deadlink = _ref[_i];
        if (deadlink.parentNode.className === 'prettyprint') {
          $.replace(deadlink, Array.prototype.slice.call(deadlink.childNodes));
          continue;
        }
        quote = deadlink.textContent;
        a = $.el('a', {
          textContent: "" + quote + "\u00A0(Dead)"
        });
        if (!(id = (_ref1 = quote.match(/\d+$/)) != null ? _ref1[0] : void 0)) {
          continue;
        }
        if (m = quote.match(/^>>>\/([a-z\d]+)/)) {
          board = m[1];
        } else if (postBoard) {
          board = postBoard;
        } else {
          board = postBoard = $('a[title="Highlight this post"]', post.el).pathname.split('/')[1];
        }
        if (board === g.BOARD && $.id("p" + id)) {
          a.href = "#p" + id;
          a.className = 'quotelink';
        } else {
          a.href = Redirect.to({
            board: board,
            threadID: 0,
            postID: id
          });
          a.className = 'deadlink';
          a.target = '_blank';
          if (Redirect.post(board, id)) {
            $.addClass(a, 'quotelink');
            a.setAttribute('data-board', board);
            a.setAttribute('data-id', id);
          }
        }
        $.replace(deadlink, a);
      }
    }
  };

  DeleteLink = {
    init: function() {
      var aImage, aPost, children, div;
      div = $.el('div', {
        className: 'delete_link',
        textContent: 'Delete'
      });
      aPost = $.el('a', {
        className: 'delete_post',
        href: 'javascript:;'
      });
      aImage = $.el('a', {
        className: 'delete_image',
        href: 'javascript:;'
      });
      children = [];
      children.push({
        el: aPost,
        open: function() {
          aPost.textContent = 'Post';
          $.on(aPost, 'click', DeleteLink["delete"]);
          return true;
        }
      });
      children.push({
        el: aImage,
        open: function(post) {
          if (!post.img) {
            return false;
          }
          aImage.textContent = 'Image';
          $.on(aImage, 'click', DeleteLink["delete"]);
          return true;
        }
      });
      Menu.addEntry({
        el: div,
        open: function(post) {
          var node, seconds;
          if (post.isArchived) {
            return false;
          }
          node = div.firstChild;
          if (seconds = DeleteLink.cooldown[post.ID]) {
            node.textContent = "Delete (" + seconds + ")";
            DeleteLink.cooldown.el = node;
          } else {
            node.textContent = 'Delete';
            delete DeleteLink.cooldown.el;
          }
          return true;
        },
        children: children
      });
      return $.on(d, 'QRPostSuccessful', this.cooldown.start);
    },
    "delete": function() {
      var board, form, id, m, menu, pwd, self;
      menu = $.id('menu');
      id = menu.dataset.id;
      if (DeleteLink.cooldown[id]) {
        return;
      }
      $.off(this, 'click', DeleteLink["delete"]);
      this.textContent = 'Deleting...';
      pwd = (m = d.cookie.match(/4chan_pass=([^;]+)/)) ? decodeURIComponent(m[1]) : $.id('delPassword').value;
      board = $('a[title="Highlight this post"]', $.id(menu.dataset.rootid)).pathname.split('/')[1];
      self = this;
      form = {
        mode: 'usrdel',
        onlyimgdel: /\bdelete_image\b/.test(this.className),
        pwd: pwd
      };
      form[id] = 'delete';
      return $.ajax($.id('delform').action.replace("/" + g.BOARD + "/", "/" + board + "/"), {
        onload: function() {
          return DeleteLink.load(self, this.response);
        },
        onerror: function() {
          return DeleteLink.error(self);
        }
      }, {
        form: $.formData(form)
      });
    },
    load: function(self, html) {
      var doc, msg, s;
      doc = d.implementation.createHTMLDocument('');
      doc.documentElement.innerHTML = html;
      if (doc.title === '4chan - Banned') {
        s = 'Banned!';
      } else if (msg = doc.getElementById('errmsg')) {
        s = msg.textContent;
        $.on(self, 'click', DeleteLink["delete"]);
      } else {
        s = 'Deleted';
      }
      return self.textContent = s;
    },
    error: function(self) {
      self.textContent = 'Connection error, please retry.';
      return $.on(self, 'click', DeleteLink["delete"]);
    },
    cooldown: {
      start: function(e) {
        var seconds;
        seconds = g.BOARD === 'q' ? 600 : 30;
        return DeleteLink.cooldown.count(e.detail.postID, seconds, seconds);
      },
      count: function(postID, seconds, length) {
        var el;
        if (!((0 <= seconds && seconds <= length))) {
          return;
        }
        setTimeout(DeleteLink.cooldown.count, 1000, postID, seconds - 1, length);
        el = DeleteLink.cooldown.el;
        if (seconds === 0) {
          if (el != null) {
            el.textContent = 'Delete';
          }
          delete DeleteLink.cooldown[postID];
          delete DeleteLink.cooldown.el;
          return;
        }
        if (el != null) {
          el.textContent = "Delete (" + seconds + ")";
        }
        return DeleteLink.cooldown[postID] = seconds;
      }
    }
  };

  ReportLink = {
    init: function() {
      var a;
      a = $.el('a', {
        className: 'report_link',
        href: 'javascript:;',
        textContent: 'Report this post'
      });
      $.on(a, 'click', this.report);
      return Menu.addEntry({
        el: a,
        open: function(post) {
          return post.isArchived === false;
        }
      });
    },
    report: function() {
      var a, id, set, url;
      a = $('a[title="Highlight this post"]', $.id(this.parentNode.dataset.rootid));
      url = "//sys.4chan.org/" + (a.pathname.split('/')[1]) + "/imgboard.php?mode=report&no=" + this.parentNode.dataset.id;
      id = Date.now();
      set = "toolbar=0,scrollbars=0,location=0,status=1,menubar=0,resizable=1,width=685,height=200";
      return window.open(url, id, set);
    }
  };

  DownloadLink = {
    init: function() {
      var a;
      if ($.el('a').download === void 0) {
        return;
      }
      a = $.el('a', {
        className: 'download_link',
        textContent: 'Download file'
      });
      return Menu.addEntry({
        el: a,
        open: function(post) {
          var fileText;
          if (!post.img) {
            return false;
          }
          a.href = post.img.parentNode.href;
          fileText = post.fileInfo.firstElementChild;
          a.download = Conf['File Info Formatting'] ? fileText.dataset.filename : $('span', fileText).title;
          return true;
        }
      });
    }
  };

  ArchiveLink = {
    init: function() {
      var div, entry, type, _i, _len, _ref;
      div = $.el('div', {
        textContent: 'Archive'
      });
      entry = {
        el: div,
        open: function(post) {
          var path;
          path = $('a[title="Highlight this post"]', post.el).pathname.split('/');
          if ((Redirect.to({
            board: path[1],
            threadID: path[3],
            postID: post.ID
          })) === ("//boards.4chan.org/" + path[1] + "/")) {
            return false;
          }
          post.info = [path[1], path[3]];
          return true;
        },
        children: []
      };
      _ref = [['Post', 'apost'], ['Name', 'name'], ['Tripcode', 'tripcode'], ['E-mail', 'email'], ['Subject', 'subject'], ['Filename', 'filename'], ['Image MD5', 'md5']];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        type = _ref[_i];
        entry.children.push(this.createSubEntry(type[0], type[1]));
      }
      return Menu.addEntry(entry);
    },
    createSubEntry: function(text, type) {
      var el, open;
      el = $.el('a', {
        textContent: text,
        target: '_blank'
      });
      open = function(post) {
        var value;
        if (type === 'apost') {
          el.href = Redirect.to({
            board: post.info[0],
            threadID: post.info[1],
            postID: post.ID
          });
          return true;
        }
        value = Filter[type](post);
        if (!value) {
          return false;
        }
        return el.href = Redirect.to({
          board: post.info[0],
          type: type,
          value: value,
          isSearch: true
        });
      };
      return {
        el: el,
        open: open
      };
    }
  };

  EmbedLink = {
    init: function() {
      var a;
      return;
      a = $.el('a', {
        className: 'embed_link',
        textContent: 'Embed all in post'
      });
      return Menu.addEntry({
        el: a,
        open: function(post) {
          if ($$('a.embed', post.blockquote).length > 0) {
            $.on(this.el, 'click', this.toggle);
            return true;
          }
          if ($('a.unembed', post.blockquote)) {
            this.el.textContent = 'Unembed all in post';
            $.on(this.el, 'click', this.toggle);
            return true;
          }
          return false;
        },
        toggle: function() {
          var blockquote, link, toggle, _i, _len;
          blockquote = $.id("m" + (this.parentNode.getAttribute('data-id')));
          if ((toggle = $$('a.embed', blockquote)).length === 0) {
            this.textContent = 'Embed all in post';
            toggle = $$('a.unembed', blockquote);
          } else {
            this.textContent = 'Unembed all in post';
          }
          for (_i = 0, _len = toggle.length; _i < _len; _i++) {
            link = toggle[_i];
            $.event(link, new Event('click'));
          }
        }
      });
    }
  };

  ThreadStats = {
    init: function() {
      var dialog;
      dialog = UI.dialog('stats', 'bottom: 0; left: 0;', '<div class=move><span id=postcount>0</span> / <span id=imagecount>0</span></div>');
      dialog.className = 'dialog';
      $.add(d.body, dialog);
      this.posts = this.images = 0;
      this.imgLimit = (function() {
        switch (g.BOARD) {
          case 'a':
          case 'b':
          case 'v':
          case 'co':
          case 'mlp':
            return 251;
          case 'vg':
            return 376;
          default:
            return 151;
        }
      })();
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var imgcount;
      if (post.isInlined) {
        return;
      }
      $.id('postcount').textContent = ++ThreadStats.posts;
      if (!post.img) {
        return;
      }
      imgcount = $.id('imagecount');
      imgcount.textContent = ++ThreadStats.images;
      if (ThreadStats.images > ThreadStats.imgLimit) {
        return $.addClass(imgcount, 'warning');
      }
    }
  };

  Unread = {
    init: function() {
      this.title = d.title;
      $.on(d, 'QRPostSuccessful', this.post);
      this.update();
      $.on(window, 'scroll focus', Unread.scroll);
      return Main.callbacks.push(this.node);
    },
    replies: [],
    foresee: [],
    post: function(e) {
      return Unread.foresee.push(e.detail.postID);
    },
    node: function(post) {
      var count, el, index;
      if ((index = Unread.foresee.indexOf(post.ID)) !== -1) {
        Unread.foresee.splice(index, 1);
        return;
      }
      el = post.el;
      if (el.hidden || /\bop\b/.test(post["class"]) || post.isInlined) {
        return;
      }
      count = Unread.replies.push(el);
      return Unread.update(count === 1);
    },
    scroll: function() {
      var bottom, height, i, reply, _i, _len, _ref;
      height = d.documentElement.clientHeight;
      _ref = Unread.replies;
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        reply = _ref[i];
        bottom = reply.getBoundingClientRect().bottom;
        if (bottom > height) {
          break;
        }
      }
      if (i === 0) {
        return;
      }
      Unread.replies = Unread.replies.slice(i);
      return Unread.update(Unread.replies.length === 0);
    },
    setTitle: function(count) {
      if (this.scheduled) {
        clearTimeout(this.scheduled);
        delete Unread.scheduled;
        this.setTitle(count);
        return;
      }
      return this.scheduled = setTimeout((function() {
        return d.title = "(" + count + ") " + Unread.title;
      }), 5);
    },
    update: function(updateFavicon) {
      var count;
      if (!g.REPLY) {
        return;
      }
      count = this.replies.length;
      if (Conf['Unread Count']) {
        this.setTitle(count);
      }
      if (!(Conf['Unread Favicon'] && updateFavicon)) {
        return;
      }
      if ($.engine === 'presto') {
        $.rm(Favicon.el);
      }
      Favicon.el.href = g.dead ? count ? Favicon.unreadDead : Favicon.dead : count ? Favicon.unread : Favicon["default"];
      if (g.dead) {
        $.addClass(Favicon.el, 'dead');
      } else {
        $.rmClass(Favicon.el, 'dead');
      }
      if (count) {
        $.addClass(Favicon.el, 'unread');
      } else {
        $.rmClass(Favicon.el, 'unread');
      }
      if ($.engine !== 'webkit') {
        return $.add(d.head, Favicon.el);
      }
    }
  };

  Favicon = {
    init: function() {
      var href;
      if (this.el) {
        return;
      }
      this.el = $('link[rel="shortcut icon"]', d.head);
      this.el.type = 'image/x-icon';
      href = this.el.href;
      this.SFW = /ws.ico$/.test(href);
      this["default"] = href;
      return this["switch"]();
    },
    "switch": function() {
      switch (Conf['favicon']) {
        case 'ferongr':
          this.unreadDead = 'data:image/gif;base64,R0lGODlhEAAQAOMHAOgLAnMFAL8AAOgLAukMA/+AgP+rq////////////////////////////////////yH5BAEKAAcALAAAAAAQABAAAARZ8MhJ6xwDWIBv+AM1fEEIBIVRlNKYrtpIECuGzuwpCLg974EYiXUYkUItjGbC6VQ4omXFiKROA6qSy0A8nAo9GS3YCswIWnOvLAi0be23Z1QtdSUaqXcviQAAOw==';
          this.unreadSFW = 'data:image/gif;base64,R0lGODlhEAAQAOMHAADX8QBwfgC2zADX8QDY8nnl8qLp8v///////////////////////////////////yH5BAEKAAcALAAAAAAQABAAAARZ8MhJ6xwDWIBv+AM1fEEIBIVRlNKYrtpIECuGzuwpCLg974EYiXUYkUItjGbC6VQ4omXFiKROA6qSy0A8nAo9GS3YCswIWnOvLAi0be23Z1QtdSUaqXcviQAAOw==';
          this.unreadNSFW = 'data:image/gif;base64,R0lGODlhEAAQAOMHAFT+ACh5AEncAFT+AFX/Acz/su7/5v///////////////////////////////////yH5BAEKAAcALAAAAAAQABAAAARZ8MhJ6xwDWIBv+AM1fEEIBIVRlNKYrtpIECuGzuwpCLg974EYiXUYkUItjGbC6VQ4omXFiKROA6qSy0A8nAo9GS3YCswIWnOvLAi0be23Z1QtdSUaqXcviQAAOw==';
          break;
        case 'xat-':
          this.unreadDead = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA2ElEQVQ4y61TQQrCMBDMQ8WDIEV6LbT2A4og2Hq0veo7fIAH04dY9N4xmyYlpGmI2MCQTWYy3Wy2DAD7B2wWAzWgcTgVeZKlZRxHNYFi2jM18oBh0IcKtC6ixf22WT4IFLs0owxswXu9egm0Ls6bwfCFfNsJYJKfqoEkd3vgUgFVLWObtzNgVKyruC+ljSzr5OEnBzjvjcQecaQhbZgBb4CmGQw+PoMkTUtdbd8VSEPakcGxPOcsoIgUKy0LecY29BmdBrqRfjIwZ93KLs5loHvBnL3cLH/jF+C/+z5dgUysAAAAAElFTkSuQmCC';
          this.unreadSFW = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA30lEQVQ4y2P4//8/AyWYgSoGQMF/GJ7Y11VVUVoyKTM9ey4Ig9ggMWQ1YA1IBvzXm34YjkH8mPyJB+Nqlp8FYRAbmxoMF6ArSNrw6T0Qf8Amh9cFMEWVR/7/A+L/uORxhgEIt5/+/3/2lf//5wAxiI0uj+4CBlBgxVUvOwtydgXQZpDmi2/+/7/0GmIQSAwkB1IDUkuUAZeABlx+g2zAZ9wGlAOjChba+LwAUgNSi2HA5Am9VciBhSsQQWyoWgZiovEDsdGI1QBYQiLJAGQalpSxyWEzAJYWkGm8clTJjQCZ1hkoVG0CygAAAABJRU5ErkJggg==';
          this.unreadNSFW = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA4ElEQVQ4y2P4//8/AyWYgSoGQMF/GJ7YNbGqrKRiUnp21lwQBrFBYshqwBqQDPifdsYYjkH8mInxB+OWx58FYRAbmxoMF6ArKPmU9B6IP2CTw+sCmKKe/5X/gPg/LnmcYQDCs/63/1/9fzYQzwGz0eXRXcAACqy4ZfFnQc7u+V/xD6T55v+LQHwJbBBIDCQHUgNSS5QBt4Cab/2/jDDgMx4DykrKJ8FCG58XQGpAajEMmNw7uQo5sHAFIogNVctATDR+IDYasRoAS0gkGYBMw5IyNjlsBsDSAjKNV44quREAx58Mr9vt5wQAAAAASUVORK5CYII=';
          break;
        case 'Mayhem':
          this.unreadDead = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABIUlEQVQ4jZ2ScWuDMBDFgw4pIkU0WsoQkWAYIkXZH4N9/+/V3dmfXSrKYIFHwt17j8vdGWNMIkgFuaDgzgQnwRs4EQs5KdolUQtagRN0givEDBTEOjgtGs0Zq8F7cKqqusVxrMQLaDUWcjBSrXkn8gs51tpJSWLk9b3HUa0aNIL5gPBR1/V4kJvR7lTwl8GmAm1Gf9+c3S+89qBHa8502AsmSrtBaEBPbIbj0ah2madlNAPEccdgJDfAtWifBjqWKShRBT6KoiH8QlEUn/qt0CCjnNdmPUwmFWzj9Oe6LpKuZXcwqq88z78Pch3aZU3dPwwc2sWlfZKCW5tWluV8kGvXClLm6dYN4/aUqfCbnEOzNDGhGZbNargvxCzvMGfRJD8UaDVvgkzo6QAAAABJRU5ErkJggg==';
          this.unreadSFW = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABCElEQVQ4jZ2S4crCMAxF+0OGDJEPKYrIGKOsiJSx/fJRfSAfTJNyKqXfiuDg0C25N2RJjTGmEVrhTzhw7oStsIEtsVzT4o2Jo9ALThiEM8IdHIgNaHo8mjNWg6/ske8bohPo+63QOLzmooHp8fyAICBSQkVz0QKdsFQEV6WSW/D+7+BbgbIDHcb4Kp61XyjyI16zZ8JemGltQtDBSGxB4/GoN+7TpkkjDCsFArm0IYv3U0BbnYtf8BCy+JytsE0X6VyuKhPPK/GAJ14kvZZDZVV3pZIb8MZr6n4o4PDGKn0S5SdDmyq5PnXQsk+Xbhinp03FFzmHJw6xYRiWm9VxnohZ3vOcxdO8ARmXRvbWdtzQAAAAAElFTkSuQmCC';
          this.unreadNSFW = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABCklEQVQ4jZ2S0WrDMAxF/TBCCKWMYhZKCSGYmFJMSNjD/mhf239qJXNcjBdTWODgRLpXKJKNMaYROuFTOHEehFb4gJZYrunwxsSXMApOmIQzwgOciE1oRjyaM1aDj+yR7xuiHvT9VmgcXnPRwO/9+wWCgEgJFc1FCwzCVhFclUpuw/u3g3cFyg50GPOjePZ+ocjPeM2RCXthpbUFwQAzsQ2Nx6PeuE+bJo0w7BQI5NKGLN5XAW11LX7BQ8jia7bCLl2kc7mqTLzuxAOeeJH0Wk6VVf0oldyEN15T948CDm+sMiZRfjK0pZIbUwcd+3TphnF62lR8kXN44hAbhmG5WQNnT8zynucsnuYJhFpBfkMzqD4AAAAASUVORK5CYII=';
          break;
        case 'Original':
          this.unreadDead = 'data:image/gif;base64,R0lGODlhEAAQAKECAAAAAP8AAP///////yH5BAEKAAMALAAAAAAQABAAAAI/nI95wsqygIRxDgGCBhTrwF3Zxowg5H1cSopS6FrGQ82PU1951ckRmYKJVCXizLRC9kAnT0aIiR6lCFT1cigAADs=';
          this.unreadSFW = 'data:image/gif;base64,R0lGODlhEAAQAKECAAAAAC6Xw////////yH5BAEKAAMALAAAAAAQABAAAAI/nI95wsqygIRxDgGCBhTrwF3Zxowg5H1cSopS6FrGQ82PU1951ckRmYKJVCXizLRC9kAnT0aIiR6lCFT1cigAADs=';
          this.unreadNSFW = 'data:image/gif;base64,R0lGODlhEAAQAKECAAAAAGbMM////////yH5BAEKAAMALAAAAAAQABAAAAI/nI95wsqygIRxDgGCBhTrwF3Zxowg5H1cSopS6FrGQ82PU1951ckRmYKJVCXizLRC9kAnT0aIiR6lCFT1cigAADs=';
      }
      return this.unread = this.SFW ? this.unreadSFW : this.unreadNSFW;
    },
    empty: 'data:image/gif;base64,R0lGODlhEAAQAJEAAAAAAP///9vb2////yH5BAEAAAMALAAAAAAQABAAAAIvnI+pq+D9DBAUoFkPFnbs7lFZKIJOJJ3MyraoB14jFpOcVMpzrnF3OKlZYsMWowAAOw==',
    dead: 'data:image/gif;base64,R0lGODlhEAAQAKECAAAAAP8AAP///////yH5BAEKAAIALAAAAAAQABAAAAIvlI+pq+D9DAgUoFkPDlbs7lFZKIJOJJ3MyraoB14jFpOcVMpzrnF3OKlZYsMWowAAOw=='
  };

  Redirect = {
    image: function(board, filename) {
      switch (board) {
        case 'a':
        case 'jp':
        case 'm':
        case 'q':
        case 'sp':
        case 'tg':
        case 'vg':
        case 'wsg':
          return "//archive.foolz.us/" + board + "/full_image/" + filename;
        case 'u':
          return "//nsfw.foolz.us/" + board + "/full_image/" + filename;
        case 'ck':
        case 'lit':
          return "//fuuka.warosu.org/" + board + "/full_image/" + filename;
        case 'cgl':
        case 'g':
        case 'mu':
        case 'w':
          return "//rbt.asia/" + board + "/full_image/" + filename;
        case 'an':
        case 'k':
        case 'toy':
        case 'x':
          return "http://archive.heinessen.com/" + board + "/full_image/" + filename;
        case 'e':
          return "//www.xn--clich-fsa.net/4chan/cgi-board.pl/" + board + "/img/" + filename;
        case 'c':
          return "//archive.nyafuu.org/" + board + "/full_image/" + filename;
      }
    },
    post: function(board, postID) {
      switch (board) {
        case 'a':
        case 'co':
        case 'jp':
        case 'm':
        case 'q':
        case 'sp':
        case 'tg':
        case 'tv':
        case 'v':
        case 'vg':
        case 'wsg':
        case 'dev':
        case 'foolz':
          return "//archive.foolz.us/_/api/chan/post/?board=" + board + "&num=" + postID;
        case 'u':
        case 'kuku':
          return "//nsfw.foolz.us/_/api/chan/post/?board=" + board + "&num=" + postID;
      }
    },
    archive: {},
    archiver: {
      'Foolz': {
        base: '//archive.foolz.us',
        boards: ['a', 'co', 'jp', 'm', 'q', 'sp', 'tg', 'tv', 'v', 'vg', 'wsg', 'dev', 'foolz'],
        type: 'foolfuuka'
      },
      'NSFWFoolz': {
        base: '//nsfw.foolz.us',
        boards: ['u', 'kuku'],
        type: 'foolfuuka'
      },
      'TheDarkCave': {
        base: 'http://archive.thedarkcave.org',
        boards: ['c', 'int', 'po'],
        type: 'foolfuuka'
      },
      'Warosu': {
        base: '//fuuka.warosu.org',
        boards: ['cgl', 'ck', 'jp', 'lit', 'q', 'tg'],
        type: 'fuuka'
      },
      'RebeccaBlackTech': {
        base: '//rbt.asia',
        boards: ['cgl', 'g', 'mu', 'w'],
        type: 'fuuka_mail'
      },
      'InstallGentoo': {
        base: '//archive.installgentoo.net',
        boards: ['diy', 'g', 'sci'],
        type: 'fuuka'
      },
      'Heinessen': {
        base: 'http://archive.heinessen.com',
        boards: ['an', 'fit', 'k', 'mlp', 'r9k', 'toy', 'x'],
        type: 'fuuka'
      },
      'Cliché': {
        base: '//www.xn--clich-fsa.net/4chan/cgi-board.pl',
        boards: ['e'],
        type: 'fuuka'
      },
      'NyaFuu': {
        base: '//archive.nyafuu.org',
        boards: ['c', 'w'],
        type: 'fuuka'
      }
    },
    select: function(board) {
      var name, names, type, _ref;
      names = [];
      _ref = this.archiver;
      for (name in _ref) {
        type = _ref[name];
        if (type.boards.indexOf(board) === -1) {
          continue;
        }
        names.push(name);
      }
      return names;
    },
    to: function(data) {
      var aboard, board;
      if (aboard = this.archiver[this.archive[board = data.board] || (this.archive[board] = $.get("archiver/" + board + "/", this.select(board)[0]))]) {
        return this.path(aboard.base, aboard.type, data);
      } else if (!data.isSearch && data.threadID) {
        return "//boards.4chan.org/" + board + "/";
      } else {
        return null;
      }
    },
    path: function(base, archiver, data) {
      var board, path, postID, threadID, type, value;
      if (data.isSearch) {
        board = data.board, type = data.type, value = data.value;
        type = type === 'name' ? 'username' : type === 'md5' ? 'image' : type;
        value = encodeURIComponent(value);
        if (archiver === 'foolfuuka') {
          return "" + base + "/" + board + "/search/" + type + "/" + value;
        } else if (type === 'image') {
          return "" + base + "/" + board + "/?task=search2&search_media_hash=" + value;
        } else if (/fuuka/.test(archiver)) {
          if (archiver === 'fuuka_mail' || type !== 'email') {
            return "" + base + "/" + board + "/?task=search2&search_" + type + "=" + value;
          } else {
            return false;
          }
        }
      }
      board = data.board, threadID = data.threadID, postID = data.postID;
      if (postID) {
        postID = postID.match(/\d+/)[0];
      }
      path = threadID ? "" + board + "/thread/" + threadID : "" + board + "/post/" + postID;
      if (archiver === 'foolfuuka') {
        path += '/';
      }
      if (threadID && postID) {
        path += archiver === 'foolfuuka' ? "#" + postID : "#p" + postID;
      }
      return "" + base + "/" + path;
    }
  };

  ImageHover = {
    init: function() {
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      if (!post.img || post.hasPdf) {
        return;
      }
      return $.on(post.img, 'mouseover', ImageHover.mouseover);
    },
    mouseover: function() {
      var el;
      if (el = $.id('ihover')) {
        if (el === UI.el) {
          delete UI.el;
        }
        $.rm(el);
      }
      if (UI.el) {
        return;
      }
      el = UI.el = $.el('img', {
        id: 'ihover',
        src: this.parentNode.href
      });
      $.add(d.body, el);
      $.on(el, 'load', ImageHover.load);
      $.on(el, 'error', ImageHover.error);
      $.on(this, 'mousemove', UI.hover);
      return $.on(this, 'mouseout', ImageHover.mouseout);
    },
    load: function() {
      var style;
      if (!this.parentNode) {
        return;
      }
      style = this.style;
      return UI.hover({
        clientX: -45 + parseInt(style.left),
        clientY: 120 + parseInt(style.top)
      });
    },
    error: function() {
      var src, timeoutID, url,
        _this = this;
      src = this.src.split('/');
      if (!(src[2] === 'images.4chan.org' && (url = Redirect.image(src[3], src[5])))) {
        if (g.dead) {
          return;
        }
        url = "//images.4chan.org/" + src[3] + "/src/" + src[5];
      }
      if ($.engine !== 'webkit' && url.split('/')[2] === 'images.4chan.org') {
        return;
      }
      timeoutID = setTimeout((function() {
        return _this.src = url;
      }), 3000);
      if ($.engine !== 'webkit' || url.split('/')[2] !== 'images.4chan.org') {
        return;
      }
      return $.ajax(url, {
        onreadystatechange: (function() {
          if (this.status === 404) {
            return clearTimeout(timeoutID);
          }
        })
      }, {
        type: 'head'
      });
    },
    mouseout: function() {
      UI.hoverend();
      $.off(this, 'mousemove', UI.hover);
      return $.off(this, 'mouseout', ImageHover.mouseout);
    }
  };

  Prefetch = {
    init: function() {
      if (g.BOARD === 'f') {
        return;
      }
      return this.dialog();
    },
    dialog: function() {
      var controls, first, input;
      controls = $.el('label', {
        id: 'prefetch',
        innerHTML: "Prefetch Images<input type=checkbox id=prefetch>"
      });
      input = $('input', controls);
      $.on(input, 'change', Prefetch.change);
      first = $.id('delform').firstElementChild;
      if (first.id === 'imgControls') {
        return $.after(first, controls);
      } else {
        return $.before(first, controls);
      }
    },
    change: function() {
      var thumb, _i, _len, _ref;
      $.off(this, 'change', Prefetch.change);
      _ref = $$('a.fileThumb');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        thumb = _ref[_i];
        $.el('img', {
          src: thumb.href
        });
      }
      return Main.callbacks.push(Prefetch.node);
    },
    node: function(post) {
      var img;
      img = post.img;
      if (post.el.hidden || !img) {
        return;
      }
      return $.el('img', {
        src: img.parentNode.href
      });
    }
  };

  ImageReplace = {
    init: function() {
      if (g.BOARD === 'f') {
        return;
      }
      return Main.callbacks.push(this.node);
    },
    node: function(post) {
      var el, img;
      img = post.img;
      if (post.el.hidden || !img || /spoiler/.test(img.src)) {
        return;
      }
      el = $.el('img', {
        src: img.parentNode.href
      });
      if (Conf["Replace " + ((el.src.match(/\w{3}$/))[0].toUpperCase())]) {
        return $.on(el, 'load', function() {
          return img.src = el.src;
        });
      }
    }
  };

  ImageExpand = {
    init: function() {
      if (g.BOARD === 'f') {
        return;
      }
      Main.callbacks.push(this.node);
      return this.dialog();
    },
    node: function(post) {
      var a;
      if (!post.img || post.hasPdf) {
        return;
      }
      a = post.img.parentNode;
      $.on(a, 'click', ImageExpand.cb.toggle);
      if (Conf['Don\'t Expand Spoilers'] && !Conf['Reveal Spoilers'] && /^Spoiler\ Image/.test(a.firstChild.alt)) {
        return;
      }
      if (ImageExpand.on && !post.el.hidden) {
        return ImageExpand.expand(post.img);
      }
    },
    cb: {
      toggle: function(e) {
        if (e.shiftKey || e.altKey || e.ctrlKey || e.metaKey || e.button !== 0) {
          return;
        }
        e.preventDefault();
        return ImageExpand.toggle(this);
      },
      all: function() {
        var i, thumb, thumbs, _i, _j, _k, _len, _len1, _len2, _ref;
        ImageExpand.on = this.checked;
        if (ImageExpand.on) {
          thumbs = $$('img[data-md5]');
          if (Conf['Expand From Current']) {
            for (i = _i = 0, _len = thumbs.length; _i < _len; i = ++_i) {
              thumb = thumbs[i];
              if (thumb.getBoundingClientRect().top > 0) {
                break;
              }
            }
            thumbs = thumbs.slice(i);
          }
          for (_j = 0, _len1 = thumbs.length; _j < _len1; _j++) {
            thumb = thumbs[_j];
            if (Conf['Don\'t Expand Spoilers'] && !Conf['Reveal Spoilers'] && /^Spoiler\ Image/.test(thumb.alt)) {
              continue;
            }
            ImageExpand.expand(thumb);
          }
        } else {
          _ref = $$('img[data-md5][hidden]');
          for (_k = 0, _len2 = _ref.length; _k < _len2; _k++) {
            thumb = _ref[_k];
            ImageExpand.contract(thumb);
          }
        }
      },
      typeChange: function() {
        var klass;
        switch (this.value) {
          case 'full':
            klass = '';
            break;
          case 'fit width':
            klass = 'fitwidth';
            break;
          case 'fit height':
            klass = 'fitheight';
            break;
          case 'fit screen':
            klass = 'fitwidth fitheight';
        }
        $.id('delform').className = klass;
        if (/\bfitheight\b/.test(klass)) {
          $.on(window, 'resize', ImageExpand.resize);
          if (!ImageExpand.style) {
            ImageExpand.style = $.addStyle('');
          }
          return ImageExpand.resize();
        } else if (ImageExpand.style) {
          return $.off(window, 'resize', ImageExpand.resize);
        }
      }
    },
    toggle: function(a) {
      var rect, thumb;
      thumb = a.firstChild;
      if (thumb.hidden) {
        rect = a.getBoundingClientRect();
        if (rect.bottom > 0) {
          if ($.engine === 'webkit') {
            if (rect.top < 0) {
              d.body.scrollTop += rect.top - 42;
            }
            if (rect.left < 0) {
              d.body.scrollLeft += rect.left;
            }
          } else {
            if (rect.top < 0) {
              d.documentElement.scrollTop += rect.top - 42;
            }
            if (rect.left < 0) {
              d.documentElement.scrollLeft += rect.left;
            }
          }
        }
        return ImageExpand.contract(thumb);
      } else {
        return ImageExpand.expand(thumb);
      }
    },
    contract: function(thumb) {
      thumb.hidden = false;
      thumb.nextSibling.hidden = true;
      return $.rmClass(thumb.parentNode.parentNode.parentNode, 'image_expanded');
    },
    expand: function(thumb, src) {
      var a, img;
      if ($.x('ancestor-or-self::*[@hidden]', thumb)) {
        return;
      }
      a = thumb.parentNode;
      src || (src = a.href);
      if (/\.pdf$/.test(src)) {
        return;
      }
      thumb.hidden = true;
      $.addClass(thumb.parentNode.parentNode.parentNode, 'image_expanded');
      if ((img = thumb.nextSibling) && img.nodeName === 'IMG') {
        img.hidden = false;
        return;
      }
      img = $.el('img', {
        src: src
      });
      $.on(img, 'error', ImageExpand.error);
      return $.after(thumb, img);
    },
    error: function() {
      var src, thumb, timeoutID, url;
      thumb = this.previousSibling;
      ImageExpand.contract(thumb);
      $.rm(this);
      src = this.src.split('/');
      if (!(src[2] === 'images.4chan.org' && (url = Redirect.image(src[3], src[5])))) {
        if (g.dead) {
          return;
        }
        url = "//images.4chan.org/" + src[3] + "/src/" + src[5];
      }
      if ($.engine !== 'webkit' && url.split('/')[2] === 'images.4chan.org') {
        return;
      }
      timeoutID = setTimeout(ImageExpand.expand, 10000, thumb, url);
      if ($.engine !== 'webkit' || url.split('/')[2] !== 'images.4chan.org') {
        return;
      }
      return $.ajax(url, {
        onreadystatechange: (function() {
          if (this.status === 404) {
            return clearTimeout(timeoutID);
          }
        })
      }, {
        type: 'head'
      });
    },
    dialog: function() {
      var controls, imageType, select;
      controls = $.el('span', {
        id: 'imgControls',
        innerHTML: "<select id=imageType name=imageType><option value=full>Full</option><option value='fit width'>Fit Width</option><option value='fit height'>Fit Height</option value='fit screen'><option value='fit screen'>Fit Screen</option></select><label>Expand Images<input type=checkbox id=imageExpand></label>"
      });
      imageType = $.get('imageType', 'full');
      select = $('select', controls);
      select.value = imageType;
      ImageExpand.cb.typeChange.call(select);
      $.on(select, 'change', $.cb.value);
      $.on(select, 'change', ImageExpand.cb.typeChange);
      $.on($('input', controls), 'click', ImageExpand.cb.all);
      return $.prepend($.id('delform'), controls);
    },
    resize: function() {
      return ImageExpand.style.textContent = ".fitheight img[data-md5] + img {max-height:" + d.documentElement.clientHeight + "px;}";
    }
  };

  CatalogLinks = {
    init: function() {
      var clone, el, nav, _i, _len, _ref;
      el = $.el('span', {
        className: 'toggleCatalog',
        innerHTML: '[<a href=javascript:;></a>]'
      });
      _ref = ['boardNavDesktop', 'boardNavDesktopFoot'];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        nav = _ref[_i];
        clone = el.cloneNode(true);
        $.on(clone.firstElementChild, 'click', this.toggle);
        $.add($.id(nav), clone);
      }
      return this.toggle(true);
    },
    toggle: function(onLoad) {
      var a, board, nav, root, useCatalog, _i, _j, _len, _len1, _ref, _ref1;
      if (onLoad === true) {
        useCatalog = $.get('CatalogIsToggled', g.CATALOG);
      } else {
        useCatalog = this.textContent === 'Catalog Off';
        $.set('CatalogIsToggled', useCatalog);
      }
      _ref = ['boardNavDesktop', 'boardNavDesktopFoot'];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        nav = _ref[_i];
        root = $.id(nav);
        _ref1 = $$('a[href*="boards.4chan.org"]', root);
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          a = _ref1[_j];
          board = a.pathname.split('/')[1];
          if (board === 'f') {
            a.pathname = '/f/';
            continue;
          }
          a.pathname = "/" + board + "/" + (useCatalog ? 'catalog' : '');
        }
        a = $('.toggleCatalog', root).firstElementChild;
        a.textContent = "Catalog " + (useCatalog ? 'On' : 'Off');
        a.title = "Turn catalog links " + (useCatalog ? 'off' : 'on') + ".";
      }
    }
  };

  Main = {
    init: function() {
      var key, path, pathname, settings, temp, val;
      Main.flatten(null, Config);
      for (key in Conf) {
        val = Conf[key];
        Conf[key] = $.get(key, val);
      }
      path = location.pathname;
      pathname = path.slice(1).split('/');
      g.BOARD = pathname[0], temp = pathname[1];
      switch (temp) {
        case 'res':
          g.REPLY = true;
          g.THREAD_ID = pathname[2];
          break;
        case 'catalog':
          g.CATALOG = true;
      }
      if (Conf["Interval per board"]) {
        Conf["Interval_" + g.BOARD] = $.get("Interval_" + g.BOARD, Conf["Interval"]);
        Conf["BGInterval_" + g.BOARD] = $.get("BGInterval_" + g.BOARD, Conf["BGInteval"]);
      }
      switch (location.hostname) {
        case 'sys.4chan.org':
          if (/report/.test(location.search)) {
            $.ready(function() {
              var field, form;
              form = $('form');
              field = $.id('recaptcha_response_field');
              $.on(field, 'keydown', function(e) {
                if (e.keyCode === 8 && !e.target.value) {
                  return window.location = 'javascript:Recaptcha.reload()';
                }
              });
              return $.on(form, 'submit', function(e) {
                var response;
                e.preventDefault();
                response = field.value.trim();
                if (!/\s/.test(response)) {
                  field.value = "" + response + " " + response;
                }
                return form.submit();
              });
            });
          }
          if (/auth/.test(location.pathname)) {
            $.ready(function() {
              var message;
              if (!(message = $('span'))) {
                return;
              }
              return setTimeout(function() {
                if (/^Success!/.test(message.textContent)) {
                  return window.close();
                } else {
                  return window.history.back();
                }
              }, 1500);
            });
          }
          return;
        case 'images.4chan.org':
          $.ready(function() {
            var url;
            if (/^4chan - 404/.test(d.title) && Conf['404 Redirect']) {
              path = location.pathname.split('/');
              url = Redirect.image(path[1], path[3]);
              if (url) {
                return location.href = url;
              }
            }
          });
          return;
      }
      if (Conf['Disable 4chan\'s extension']) {
        settings = JSON.parse(localStorage.getItem('4chan-settings')) || {};
        settings.disableAll = true;
        localStorage.setItem('4chan-settings', JSON.stringify(settings));
      }
      Main.polyfill();
      if (g.CATALOG) {
        return $.ready(Main.catalog);
      } else {
        return Main.features();
      }
    },
    polyfill: function() {
      var event, prefix, property;
      if (!('visibilityState' in document)) {
        prefix = 'mozVisibilityState' in document ? 'moz' : 'webkitVisibilityState' in document ? 'webkit' : 'o';
        property = prefix + 'VisibilityState';
        event = prefix + 'visibilitychange';
        d.visibilityState = d[property];
        d.hidden = d.visibilityState === 'hidden';
        return $.on(d, event, function() {
          d.visibilityState = d[property];
          d.hidden = d.visibilityState === 'hidden';
          return $.event(d, new CustomEvent('visibilitychange'));
        });
      }
    },
    catalog: function() {
      if (Conf['Catalog Links']) {
        CatalogLinks.init();
      }
      if (Conf['Thread Hiding']) {
        ThreadHiding.init();
      }
      return setTimeout(function() {
        Main.hidegMessage.create();
        return Main.cleanup();
      });
    },
    features: function() {
      var cutoff, hiddenThreads, id, now, timestamp, _ref;
      Options.init();
      if (Conf['Quick Reply'] && Conf['Hide Original Post Form']) {
        Main.css += '#postForm { display: none; }';
      }
      if (Conf['Color user IDs']) {
        Main.css += '.posteruid .hand { padding: 0 5px; border-radius: 6px; font-size: 0.8em; }';
      }
      $.addStyle(Main.css);
      now = Date.now();
      if (Conf['Check for Updates'] && $.get('lastUpdate', 0) < now - 6 * $.HOUR) {
        $.ready(function() {
          $.on(window, 'message', Main.message);
          $.set('lastUpdate', now);
          return $.add(d.head, $.el('script', {
            src: 'https://github.com/ihavenoface/4chan-x/raw/master/latest.js'
          }));
        });
      }
      g.hiddenReplies = $.get("hiddenReplies/" + g.BOARD + "/", {});
      if ($.get('lastChecked', 0) < now - 1 * $.DAY) {
        $.set('lastChecked', now);
        cutoff = now - 7 * $.DAY;
        hiddenThreads = $.get("hiddenThreads/" + g.BOARD + "/", {});
        for (id in hiddenThreads) {
          timestamp = hiddenThreads[id];
          if (timestamp < cutoff) {
            delete hiddenThreads[id];
          }
        }
        _ref = g.hiddenReplies;
        for (id in _ref) {
          timestamp = _ref[id];
          if (timestamp < cutoff) {
            delete g.hiddenReplies[id];
          }
        }
        $.set("hiddenThreads/" + g.BOARD + "/", hiddenThreads);
        $.set("hiddenReplies/" + g.BOARD + "/", g.hiddenReplies);
      }
      if (Conf['Filter']) {
        Filter.init();
      }
      if (Conf['Reply Hiding']) {
        ReplyHiding.init();
      }
      if (Conf['Filter'] || Conf['Reply Hiding']) {
        StrikethroughQuotes.init();
      }
      if (Conf['Anonymize']) {
        Anonymize.init();
      }
      if (Conf['Time Formatting']) {
        Time.init();
      }
      if (Conf['Relative Post Dates']) {
        RelativeDates.init();
      }
      if (Conf['File Info Formatting']) {
        FileInfo.init();
      }
      if (Conf['Sauce']) {
        Sauce.init();
      }
      if (Conf['Reveal Spoilers']) {
        RevealSpoilers.init();
      }
      if (Conf['Image Hover']) {
        ImageHover.init();
      }
      if (Conf['Menu']) {
        Menu.init();
        if (Conf['Report Link']) {
          ReportLink.init();
        }
        if (Conf['Delete Link']) {
          DeleteLink.init();
        }
        if (Conf['Filter']) {
          Filter.menuInit();
        }
        if (Conf['Archive Link']) {
          ArchiveLink.init();
        }
        if (Conf['Download Link']) {
          DownloadLink.init();
        }
        if (Conf['Embed Link']) {
          EmbedLink.init();
        }
      }
      if (Conf['Linkify']) {
        Linkify.init();
      }
      if (Conf['Remove Spoilers']) {
        RemoveSpoilers.init();
      }
      if (Conf['Resurrect Quotes']) {
        Quotify.init();
      }
      if (Conf['Quote Inline']) {
        QuoteInline.init();
      }
      if (Conf['Quote Preview']) {
        QuotePreview.init();
      }
      if (Conf['Quote Backlinks']) {
        QuoteBacklink.init();
      }
      if (Conf['Indicate OP quote']) {
        QuoteOP.init();
      }
      if (Conf['Indicate Quotes of You']) {
        QuoteYou.init();
      }
      if (Conf['Indicate Cross-thread Quotes']) {
        QuoteCT.init();
      }
      if (Conf['Color user IDs']) {
        IDColor.init();
      }
      return $.ready(Main.featuresReady);
    },
    featuresReady: function() {
      var MutationObserver, a, board, nav, node, nodes, observer, passLink, styleSelector, _i, _j, _len, _len1, _ref, _ref1;
      if (/^4chan - 404/.test(d.title)) {
        if (Conf['404 Redirect'] && /^\d+$/.test(g.THREAD_ID)) {
          location.href = Redirect.to({
            board: g.BOARD,
            threadID: g.THREAD_ID,
            postID: location.hash
          });
        }
        return;
      }
      if (!$.id('navtopright')) {
        return;
      }
      $.addClass(d.body, $.engine);
      $.addClass(d.body, 'fourchan_x');
      _ref = ['boardNavDesktop', 'boardNavDesktopFoot'];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        nav = _ref[_i];
        if (a = $("a[href$='/" + g.BOARD + "/']", $.id(nav))) {
          $.addClass(a, 'current');
        }
      }
      if (styleSelector = $.id('styleSelector')) {
        passLink = $.el('a', {
          textContent: '4chan Pass',
          href: 'javascript:;'
        });
        $.on(passLink, 'click', function() {
          return window.open('//sys.4chan.org/auth', 'This will steal your data.', 'left=0,top=0,width=500,height=255,toolbar=0,resizable=0');
        });
        $.before(styleSelector.previousSibling, [$.tn('['), passLink, $.tn(']\u00A0\u00A0')]);
      }
      Main.hidegMessage.create();
      Main.cleanup();
      Favicon.init();
      if (Conf['Quick Reply']) {
        QR.init();
      }
      if (Conf['Image Expansion']) {
        ImageExpand.init();
      }
      if (Conf['Catalog Links']) {
        CatalogLinks.init();
      }
      if (Conf['Thread Watcher']) {
        setTimeout(function() {
          return Watcher.init();
        });
      }
      if (Conf['Keybinds']) {
        setTimeout(function() {
          return Keybinds.init();
        });
      }
      if (Conf['Replace GIF'] || Conf['Replace PNG'] || Conf['Replace JPG']) {
        ImageReplace.init();
      }
      if (g.REPLY) {
        if (Conf['Prefetch']) {
          Prefetch.init();
        }
        if (Conf['Thread Updater']) {
          setTimeout(function() {
            return Updater.init();
          });
        }
        if (Conf['Thread Stats']) {
          ThreadStats.init();
        }
        if (Conf['Reply Navigation']) {
          setTimeout(function() {
            return Nav.init();
          });
        }
        if (Conf['Post in Title']) {
          TitlePost.init();
        }
        if (Conf['Unread Count'] || Conf['Unread Favicon']) {
          Unread.init();
        }
      } else {
        if (Conf['Thread Hiding']) {
          ThreadHiding.init();
        }
        if (Conf['Thread Expansion']) {
          setTimeout(function() {
            return ExpandThread.init();
          });
        }
        if (Conf['Comment Expansion']) {
          setTimeout(function() {
            return ExpandComment.init();
          });
        }
        if (Conf['Index Navigation']) {
          setTimeout(function() {
            return Nav.init();
          });
        }
      }
      board = $('.board');
      nodes = [];
      _ref1 = $$('.postContainer', board);
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        node = _ref1[_j];
        nodes.push(Main.preParse(node));
      }
      Main.node(nodes, function() {
        if (d.readyState === "complete") {
          return true;
        }
        return false;
      });
      Main.hasCodeTags = !!$('script[src^="//static.4chan.org/js/prettify/prettify"]');
      if (MutationObserver = window.MutationObserver || window.WebKitMutationObserver || window.OMutationObserver) {
        observer = new MutationObserver(Main.observer);
        observer.observe(board, {
          childList: true,
          subtree: true
        });
      } else {
        $.on(board, 'DOMNodeInserted', Main.listener);
      }
    },
    flatten: function(parent, obj) {
      var key, val;
      if (obj instanceof Array) {
        Conf[parent] = obj[0];
      } else if (typeof obj === 'object') {
        for (key in obj) {
          val = obj[key];
          Main.flatten(key, val);
        }
      } else {
        Conf[parent] = obj;
      }
    },
    message: function(e) {
      var version, xupdate;
      version = e.data.version;
      if (version && version !== Main.version) {
        xupdate = $.el('div', {
          id: 'xupdater',
          innerHTML: "An updated version of <a href=https://raw.github.com/ihavenoface/4chan-x/" + version + "/4chan_x.user.js>4chan X</a> (v" + version + ") is available.<a href=javascript:; id=dismiss_xupdate>  ×</a>"
        });
        $.prepend($.id('delform'), xupdate);
        return $.on($('#dismiss_xupdate'), 'click', function() {
          return $.rm(xupdate);
        });
      }
    },
    preParse: function(node) {
      var el, img, imgParent, parentClass, post;
      parentClass = node.parentNode.className;
      el = $('.post', node);
      post = {
        root: node,
        el: el,
        "class": el.className,
        ID: el.id.match(/\d+$/)[0],
        threadID: g.THREAD_ID || $.x('ancestor::div[parent::div[@class="board"]]', node).id.match(/\d+$/)[0],
        isArchived: /\barchivedPost\b/.test(parentClass),
        isInlined: /\binline\b/.test(parentClass),
        isCrosspost: /\bcrosspost\b/.test(parentClass),
        blockquote: el.lastElementChild,
        quotes: el.getElementsByClassName('quotelink'),
        backlinks: el.getElementsByClassName('backlink'),
        fileInfo: false,
        img: false
      };
      if (img = $('img[data-md5]', el)) {
        imgParent = img.parentNode;
        post.img = img;
        post.fileInfo = imgParent.previousElementSibling;
        post.hasPdf = /\.pdf$/.test(imgParent.href);
      }
      Main.prettify(post.blockquote);
      return post;
    },
    node: function(nodes, notify) {
      var callback, node, _i, _j, _len, _len1, _ref;
      _ref = Main.callbacks;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        callback = _ref[_i];
        try {
          for (_j = 0, _len1 = nodes.length; _j < _len1; _j++) {
            node = nodes[_j];
            callback(node);
          }
        } catch (err) {
          if (notify) {
            alert("4chan X (" + Main.version + ") error: " + err.message + "\nReport the bug at ihavenoface.github.com/4chan-x/#bug-report\n\nURL: " + window.location + "\n" + err.stack);
          }
        }
      }
    },
    observer: function(mutations) {
      var addedNode, mutation, nodes, _i, _j, _len, _len1, _ref;
      nodes = [];
      for (_i = 0, _len = mutations.length; _i < _len; _i++) {
        mutation = mutations[_i];
        _ref = mutation.addedNodes;
        for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
          addedNode = _ref[_j];
          if (/\bpostContainer\b/.test(addedNode.className)) {
            nodes.push(Main.preParse(addedNode));
          }
        }
      }
      if (nodes.length) {
        return Main.node(nodes);
      }
    },
    listener: function(e) {
      var target;
      target = e.target;
      if (/\bpostContainer\b/.test(target.className)) {
        return Main.node([Main.preParse(target)]);
      }
    },
    prettify: function(bq) {
      var code;
      if (!Main.hasCodeTags) {
        return;
      }
      code = function() {
        var pre, _i, _len, _ref;
        _ref = document.getElementById('_id_').getElementsByClassName('prettyprint');
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          pre = _ref[_i];
          pre.innerHTML = prettyPrintOne(pre.innerHTML.replace(/\s/g, '&nbsp;'));
        }
      };
      return $.globalEval(("(" + code + ")()").replace('_id_', bq.id));
    },
    hidegMessage: {
      create: function() {
        var first, gmsg, hideBtn, hideState, last;
        if (!(gmsg = $.id('globalMessage'))) {
          return;
        }
        if (g.CATALOG) {
          $.rm($.id('toggleMsgBtn'));
        }
        hideState = $.get('hidegMessage', {
          hidden: false
        });
        hideBtn = $.el('div', {
          id: 'hideBtn',
          innerHTML: "[<a href=javascript:; id=hgMessage>Hide</a>] " + "<span>[<a href=javascript:; id=dgMessage>Dismiss</a>]</span>"
        });
        $.on((first = hideBtn.firstElementChild), 'click', function() {
          return Main.hidegMessage.toggle.call({
            el: first,
            gmsg: gmsg,
            hideState: hideState
          });
        });
        $.on((last = hideBtn.lastElementChild.firstElementChild), 'click', function() {
          return Main.hidegMessage.toggle.call({
            el: last,
            gmsg: gmsg,
            hideState: hideState
          });
        });
        $.before(gmsg, hideBtn);
        if (hideState.hidden && !hideState.gmsg && hideState.gmsg !== gmsg.textContent) {
          this.toggle.call({
            el: first,
            gmsg: gmsg,
            hideState: hideState
          });
        }
        if (hideState.gmsg && hideState.gmsg === gmsg.textContent) {
          if (hideState.hidden) {
            this.toggle.call({
              el: first,
              gmsg: gmsg,
              hideState: hideState
            });
          }
          return this.toggle.call({
            el: last,
            gmsg: gmsg,
            hideState: hideState
          });
        }
      },
      toggle: function() {
        var el, gmsg, hideState, i, _i, _len, _ref;
        el = this.el, gmsg = this.gmsg, hideState = this.hideState;
        switch (el.id) {
          case 'hgMessage':
            _ref = [gmsg, el.nextElementSibling];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              i = _ref[_i];
              i.classList.toggle('hidden');
            }
            if (el.textContent === 'Hide') {
              hideState.hidden = true;
              el.textContent = 'Show';
            } else {
              hideState.hidden = false;
              el.textContent = 'Hide';
            }
            break;
          case 'dgMessage':
            if (el.textContent === 'Dismiss') {
              hideState.gmsg = gmsg.textContent;
              el.textContent = 'Detain';
            } else {
              delete hideState.gmsg;
              el.textContent = 'Dismiss';
            }
        }
        return $.set('hidegMessage', hideState);
      }
    },
    cleanup: function() {
      var ad, hr, _i, _len, _ref;
      _ref = ['top', 'middle', 'bottom'];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        ad = _ref[_i];
        if (!(ad = $("." + ad + "ad"))) {
          continue;
        }
        if ((hr = ad.nextSibling).localName === 'hr') {
          $.rm(hr);
        }
        $.rm(ad);
      }
    },
    namespace: '4chan_x.',
    version: '2.38.5',
    callbacks: [],
    css: '\
/* dialog styling */\
hr.abovePostForm {\
  width: 100% !important;\
}\
.post.reply.yourPost, #qp.yourPost {\
  border-left: 1px solid rgba(221,0,0,.5) !important;\
}\
.dialog.reply {\
  display: block;\
  border: 1px solid rgba(0,0,0,.25);\
  padding: 0;\
}\
.move {\
  cursor: move;\
}\
label, .favicon {\
  cursor: pointer;\
}\
a[href="javascript:;"] {\
  text-decoration: none;\
}\
.warning {\
  color: red;\
}\
\
.hide_thread_button:not(.hidden_thread) {\
  float: left;\
}\
\
.thread > .hidden_thread ~ *,\
[hidden],\
#globalMessage.hidden,\
#content > [name=tab]:not(:checked) + div,\
#updater:not(:hover) > :not(.move),\
.autohide:not(:hover) > form,\
#qp input, .forwarded {\
  display: none !important;\
}\
\
.menu_button {\
  display: inline-block;\
}\
.menu_button > span {\
  border-top:   .5em solid;\
  border-right: .3em solid transparent;\
  border-left:  .3em solid transparent;\
  display: inline-block;\
  margin: 2px;\
  vertical-align: middle;\
}\
#menu {\
  position: absolute;\
  outline: none;\
}\
.entry {\
  border-bottom: 1px solid rgba(0, 0, 0, .25);\
  cursor: pointer;\
  display: block;\
  outline: none;\
  padding: 3px 7px;\
  position: relative;\
  text-decoration: none;\
  white-space: nowrap;\
}\
.entry:last-child {\
  border: none;\
}\
.focused.entry {\
  background: rgba(255, 255, 255, .33);\
}\
.entry.hasSubMenu {\
  padding-right: 1.5em;\
}\
.hasSubMenu::after {\
  content: "";\
  border-left:   .5em solid;\
  border-top:    .3em solid transparent;\
  border-bottom: .3em solid transparent;\
  display: inline-block;\
  margin: .3em;\
  position: absolute;\
  right: 3px;\
}\
.hasSubMenu:not(.focused) > .subMenu {\
  display: none;\
}\
.subMenu {\
  position: absolute;\
  left: 100%;\
  top: 0;\
  margin-top: -1px;\
}\
h1,\
h2 {\
  text-align: center;\
}\
#qr > .move {\
  min-width: 300px;\
  overflow: hidden;\
  box-sizing: border-box;\
  -moz-box-sizing: border-box;\
  padding: 0 2px;\
}\
#qr > .move > span {\
  float: right;\
}\
#autohide, .close, #qr select, #dump, .remove, .captchaimg, #qr div.warning {\
  cursor: pointer;\
}\
#qr select,\
#qr > form {\
  margin: 0;\
}\
#dump {\
  background: -webkit-linear-gradient(#EEE, #CCC);\
  background: -moz-linear-gradient(#EEE, #CCC);\
  background: -o-linear-gradient(#EEE, #CCC);\
  background: linear-gradient(#EEE, #CCC);\
  width: 10%;\
}\
.gecko #dump {\
  padding: 1px 0 2px;\
}\
#dump:hover, #dump:focus {\
  background: -webkit-linear-gradient(#FFF, #DDD);\
  background: -moz-linear-gradient(#FFF, #DDD);\
  background: -o-linear-gradient(#FFF, #DDD);\
  background: linear-gradient(#FFF, #DDD);\
}\
#dump:active, .dump #dump:not(:hover):not(:focus) {\
  background: -webkit-linear-gradient(#CCC, #DDD);\
  background: -moz-linear-gradient(#CCC, #DDD);\
  background: -o-linear-gradient(#CCC, #DDD);\
  background: linear-gradient(#CCC, #DDD);\
}\
#qr:not(.dump) #replies, .dump > form > label {\
  display: none;\
}\
#replies {\
  display: block;\
  height: 100px;\
  position: relative;\
  -webkit-user-select: none;\
  -moz-user-select: none;\
  -o-user-select: none;\
  user-select: none;\
}\
#replies > div {\
  counter-reset: thumbnails;\
  top: 0; right: 0; bottom: 0; left: 0;\
  margin: 0; padding: 0;\
  overflow: hidden;\
  position: absolute;\
  white-space: pre;\
}\
#replies > div:hover {\
  bottom: -10px;\
  overflow-x: auto;\
  z-index: 1;\
}\
.thumbnail {\
  background-color: rgba(0,0,0,.2) !important;\
  background-position: 50% 20% !important;\
  background-size: cover !important;\
  border: 1px solid #666;\
  box-sizing: border-box;\
  -moz-box-sizing: border-box;\
  cursor: move;\
  display: inline-block;\
  height: 90px; width: 90px;\
  margin: 5px; padding: 2px;\
  opacity: .5;\
  outline: none;\
  overflow: hidden;\
  position: relative;\
  text-shadow: 0 1px 1px #000;\
  -webkit-transition: opacity .25s ease-in-out;\
  -moz-transition: opacity .25s ease-in-out;\
  -o-transition: opacity .25s ease-in-out;\
  transition: opacity .25s ease-in-out;\
  vertical-align: top;\
}\
.thumbnail:hover, .thumbnail:focus {\
  opacity: .9;\
}\
.thumbnail#selected {\
  opacity: 1;\
}\
.thumbnail::before {\
  counter-increment: thumbnails;\
  content: counter(thumbnails);\
  color: #FFF;\
  font-weight: 700;\
  padding: 3px;\
  position: absolute;\
  top: 0;\
  right: 0;\
  text-shadow: 0 0 3px #000, 0 0 8px #000;\
}\
.thumbnail.drag {\
  box-shadow: 0 0 10px rgba(0,0,0,.5);\
}\
.thumbnail.over {\
  border-color: #FFF;\
}\
.thumbnail > span {\
  color: #FFF;\
}\
.remove {\
  background: none;\
  color: #E00;\
  font-weight: 700;\
  padding: 3px;\
}\
.remove:hover::after {\
  content: " Remove";\
}\
.thumbnail > label {\
  background: rgba(0,0,0,.5);\
  color: #FFF;\
  right: 0; bottom: 0; left: 0;\
  position: absolute;\
  text-align: center;\
}\
.thumbnail > label > input {\
  margin: 0;\
}\
#addReply {\
  color: #333;\
  font-size: 3.5em;\
  line-height: 100px;\
}\
#addReply:hover, #addReply:focus {\
  color: #000;\
}\
.field {\
  border: 1px solid #CCC;\
  box-sizing: border-box;\
  -moz-box-sizing: border-box;\
  color: #333;\
  font: 13px sans-serif;\
  margin: 0;\
  padding: 2px 4px 3px;\
  -webkit-transition: color .25s, border .25s;\
  -moz-transition: color .25s, border .25s;\
  -o-transition: color .25s, border .25s;\
  transition: color .25s, border .25s;\
}\
.field:-moz-placeholder,\
.field:hover:-moz-placeholder {\
  color: #AAA;\
}\
.field:hover, .field:focus {\
  border-color: #999;\
  color: #000;\
  outline: none;\
}\
#qr > form > div:first-child > .field:not(#dump) {\
  width: 30%;\
}\
#qr textarea.field {\
  display: -webkit-box;\
  min-height: 160px;\
  min-width: 100%;\
}\
#qr.captcha textarea.field {\
  min-height: 120px;\
}\
.textarea {\
  position: relative;\
}\
#charCount {\
  color: #000;\
  background: hsla(0, 0%, 100%, .5);\
  font-size: 8pt;\
  margin: 1px;\
  position: absolute;\
  bottom: 0;\
  right: 0;\
  pointer-events: none;\
}\
#charCount.warning {\
  color: red;\
}\
.captchainput > .field {\
  min-width: 100%;\
}\
.captchaimg {\
  background: #FFF;\
  outline: 1px solid #CCC;\
  outline-offset: -1px;\
  text-align: center;\
}\
.captchaimg > img {\
  display: block;\
  height: 57px;\
  width: 300px;\
}\
#qr [type=file] {\
  margin: 1px 0;\
  width: 70%;\
}\
#qr [type=submit] {\
  margin: 1px 0;\
  padding: 1px; /* not Gecko */\
  width: 30%;\
}\
.gecko #qr [type=submit] {\
  padding: 0 1px; /* Gecko does not respect box-sizing: border-box */\
}\
\
.fileText:hover .fntrunc,\
.fileText:not(:hover) .fnfull {\
  display: none;\
}\
.fitwidth img[data-md5] + img {\
  max-width: 100%;\
}\
.gecko  .fitwidth img[data-md5] + img,\
.presto .fitwidth img[data-md5] + img {\
  width: 100%;\
}\
\
#qr, #qp, #updater, #stats, #ihover, #overlay, #navlinks {\
  position: fixed;\
}\
\
#ihover {\
  max-height: 97%;\
  max-width: 75%;\
  padding-bottom: 18px;\
}\
\
#navlinks {\
  font-size: 16px;\
  top: 25px;\
  right: 5px;\
}\
\
body {\
  box-sizing: border-box;\
  -moz-box-sizing: border-box;\
}\
body.unscroll {\
  overflow: hidden;\
}\
#overlay {\
  top: 0;\
  left: 0;\
  width: 100%;\
  height: 100%;\
  text-align: center;\
  background: rgba(0,0,0,.5);\
  z-index: 1;\
}\
#overlay::after {\
  content: "";\
  display: inline-block;\
  height: 100%;\
  vertical-align: middle;\
}\
#options {\
  box-sizing: border-box;\
  -moz-box-sizing: border-box;\
  display: inline-block;\
  padding: 5px;\
  position: relative;\
  text-align: left;\
  vertical-align: middle;\
  width: 600px;\
  max-width: 100%;\
  height: 500px;\
  max-height: 100%;\
}\
#credits {\
  float: right;\
}\
#options ul {\
  padding: 0;\
}\
#options article li {\
  margin: 10px 0 10px 2em;\
}\
#options code {\
  background: hsla(0, 0%, 100%, .5);\
  color: #000;\
  padding: 0 1px;\
}\
#options label {\
  text-decoration: underline;\
}\
#content {\
  overflow: auto;\
  position: absolute;\
  top: 2.5em;\
  right: 5px;\
  bottom: 5px;\
  left: 5px;\
}\
#content textarea {\
  font-family: monospace;\
  min-height: 350px;\
  resize: vertical;\
  width: 100%;\
}\
\
#updater {\
  text-align: right;\
}\
#updater:not(:hover) {\
  border: none;\
  background: transparent;\
}\
#updater input[type=number] {\
  width: 4em;\
}\
.new {\
  background: lime;\
}\
\
#watcher {\
  padding-bottom: 5px;\
  position: absolute;\
  overflow: hidden;\
  white-space: nowrap;\
}\
#watcher:not(:hover) {\
  max-height: 220px;\
}\
#watcher > div {\
  max-width: 200px;\
  overflow: hidden;\
  padding-left: 5px;\
  padding-right: 5px;\
  text-overflow: ellipsis;\
}\
#watcher > .move {\
  padding-top: 5px;\
  text-decoration: underline;\
}\
\
#qp {\
  padding: 2px 2px 5px;\
}\
#qp .post {\
  border: none;\
  margin: 0;\
  padding: 0;\
}\
#qp img {\
  max-height: 300px;\
  max-width: 500px;\
}\
.qphl {\
  box-shadow: 0 0 0 2px rgba(216, 94, 49, .7);\
}\
.quotelink.deadlink {\
  text-decoration: underline !important;\
}\
.deadlink:not(.quotelink) {\
  text-decoration: none !important;\
}\
.inlined {\
  opacity: .5;\
}\
.inline {\
  background-color: rgba(255, 255, 255, 0.15);\
  border: 1px solid rgba(128, 128, 128, 0.5);\
  display: table;\
  margin: 2px;\
  padding: 2px;\
}\
.inline .post {\
  background: none;\
  border: none;\
  margin: 0;\
  padding: 0;\
}\
div.opContainer {\
  display: block !important;\
}\
.opContainer.filter_highlight {\
  box-shadow: inset 5px 0 rgba(255, 0, 0, .5);\
}\
.opContainer.filter_highlight.qphl {\
  box-shadow: inset 5px 0 rgba(255, 0, 0, .5),\
              0 0 0 2px rgba(216, 94, 49, .7);\
}\
.filter_highlight > .reply {\
  box-shadow: -5px 0 rgba(255, 0, 0, .5);\
}\
.filter_highlight > .reply.qphl {\
  box-shadow: -5px 0 rgba(255, 0, 0, .5),\
              0 0 0 2px rgba(216, 94, 49, .7)\
}\
.filtered,\
.quotelink.filtered {\
  text-decoration: underline;\
  text-decoration: line-through !important;\
}\
.quotelink.forwardlink,\
.backlink.forwardlink {\
  text-decoration: none;\
  border-bottom: 1px dashed;\
}\
.threadContainer {\
  margin-left: 20px;\
  border-left: 1px solid black;\
}\
#xupdater {\
  margin-bottom: 2px;\
}\
.youtubeTitle {\
  background: transparent url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAMCAYAAABr5z2BAAABIklEQVQoz53LvUrDUBjG8bOoOammSf1IoBSvoCB4JeIqOHgBLt6AIMRBBQelWurQ2kERnMRBsBUcIp5FJSBI5oQsJVkkUHh8W0o5nhaFHvjBgef/Mq+Q46RJBMkI/vE+aOus956tnEswIZe1LV0QyJ5sE2GzgZfVMtRNIdiDpccEssdlB1mW4bvTwdvWJtRdErM7U+8S/FJykCRJX5qm+KpVce8UMNLRLbulz4iSjTAMh6Iowsd5BeNadp3nUF0VlxAEwZBotXC0Usa4ll3meZdA1iguwvf9vpvDA2wvmKgYGtSud8suDB4TyGr2PF49D/vra9jRZ1BVdknMzgwuCGSnZEObwu6sBnVTCHZiaC7BhFx2PKdxUidiAH/4lLo9Mv0DELVs9qsOHXwAAAAASUVORK5CYII=") center left no-repeat!important;\
  padding-left: 18px;\
}\
.vimeoTitle {\
  background: transparent url("data:image/gif;base64,R0lGODlhEAAQAMQfAAuUuQynzzu83u/09Ryy2Su320rC4IbW6mKOngqHq5GvuoO3xhVbc0m92zV7keDo60R8j8Hc5KHEzwuawGSluaTg8Ah1lfD5/BmPsJPI13fR6LLd6f///wuavg2t1gAAACH5BAEAAB8ALAAAAAAQABAAAAVu4NeNZFmKgqeurCqMbbzCbrEWh0ao9MFdNgNnWOF1CJUhR+PZDIYRY2MRGWYIFsVQYgRYHNBAc4gwqiaPoUfIkQDMKsnwkB5YZp0VRTmEsGgeGHwIb3grAVoDCAktgB4WEAyMjY4AYpQiJpojHyEAOw==") center left no-repeat!important;\
  padding-left: 18px;\
}\
.soundcloudTitle {\
  background:transparent url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABsklEQVQ4y5WTy2pUQRCGv2rbzDjJeAlIBmOyipGIIJqFEBDElwh4yULGeRFXPoEIBl/AvQ/gC2RnxCAoxijiwks852S6+3dxzslcHJCpTXVX11/Xv0097gLPgVNMJxnQNfX4zsqleWbnpoMf/oa9d988MM9MC/rp+E0a+A0dsVobMNMCOO8B6McRoABJI+A6gJmN3D2A8jgEBCEkSEMBrcrsDAzDWWn3AjgKFaDMmgRqniGFgsaDp1jrLOngDf1XT1D+A1dFc4MKAkkiCVKjjVu7g9+4Rzx4i1u6hjXbuMWr0O5QPNvCu7IaCZwEKQukLGDrm5x8uI0tr6MkiGlkiv7yLfzN+6S5i6QsIMABkEfcxhbWWYMkVAOjxvYAjc3HNHrbKI9VBQBFwF25XQKSBjqIf1YBuAurEMrczgDygD6/x2LCpFLXLUyQ+PoldphhBhYfIX09XU1+Flaukz7uYqs3SHs7cG4BmTsmkBUF9mmXEwa28BNLPaQPLepuNcbGSWQquQC2/Kdcox1FUGkcB0ykck1nA2+wTzMs8stGnP4rbWGw74EuS/GFQWfK7/wF6P4F7fzIAYkdmdEAAAAASUVORK5CYII=") center left no-repeat!important;\
  padding-left: 18px;\
}\
.embed {\
  position: static !important;\
  width: auto !important;\
  height: auto !important;\
  overflow: visible !important;\
}\
'
  };

  Main.init();

}).call(this);

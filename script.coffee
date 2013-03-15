Config =
  main:
    Enhancing:
      'Disable 4chan\'s extension':   [true,  'Avoid conflicts between 4chan X and 4chan\'s inline extension']
      'Catalog Links':                [true,  'Turn Navigation links into links to each board\'s catalog']
      '404 Redirect':                 [true,  'Redirect dead threads and images']
      'Keybinds':                     [true,  'Binds actions to keys']
      'Time Formatting':              [true,  'Arbitrarily formatted timestamps, using your local time']
      'Relative Post Dates':          [false, 'Display dates as "3 minutes ago" f.e., tooltip shows the timestamp']
      'File Info Formatting':         [true,  'Reformats the file information']
      'Comment Expansion':            [true,  'Expand too long comments']
      'Thread Expansion':             [true,  'View all replies']
      'Index Navigation':             [true,  'Navigate to previous / next thread']
      'Reply Navigation':             [false, 'Navigate to top / bottom of thread']
      'Check for Updates':            [true,  'Check for updated versions of 4chan X']
      'Check for Bans':               [false, 'Obtain ban status and prepend it to the top of the page']
      'Check for Bans constantly':    [false, 'Obtain ban status on every refresh. Note that this will cause delay on getting the result']
    Linkification:
      'Linkify':                      [true,  'Convert text into links where applicable']
      'Embed':                        [true,  'Add a link to supported linkified video and audio links']
      'Youtube':                      [true,  'Replace youtube links with its title']
      'Vimeo':                        [true,  'Replace vimeo links']
      'Soundcloud':                   [true,  'Replace soundcloud links']
      'Show FavIcons':                [true,  'Prepend the site\'s favicon to a replaced title']
    Filtering:
      'Anonymize':                    [false, 'Make everybody anonymous']
      'Filter':                       [true,  'Self-moderation placebo']
      'Recursive Filtering':          [true,  'Filter replies of filtered posts, recursively']
      'Reply Hiding':                 [true,  'Hide single replies']
      'Thread Hiding':                [true,  'Hide entire threads']
      'Show Stubs':                   [false, 'Of hidden threads / replies']
    Imaging:
      'Image Expansion':              [true,  'Expand images']
      'Image Hover':                  [true,  'Show full image on mouseover']
      'Sauce':                        [true,  'Add sauce to images']
      'Reveal Spoilers':              [false, 'Replace spoiler thumbnails by the original thumbnail']
      'Don\'t Expand Spoilers':       [true,  'Don\'t expand spoilers when using ImageExpand']
      'Expand From Current':          [false, 'Expand images from current position to thread end']
      'Prefetch':                     [false, 'Prefetch images']
      'Replace GIF':                  [false, 'Replace thumbnail of gifs with its actual image']
      'Replace PNG':                  [false, 'Replace pngs']
      'Replace JPG':                  [false, 'Replace jpgs']
    Menu:
      'Menu':                         [true,  'Add a drop-down menu in posts']
      'Report Link':                  [true,  'Add a report link to the menu']
      'Delete Link':                  [true,  'Add post and image deletion links to the menu']
      'Download Link':                [true,  'Add a download with original filename link to the menu. Chrome-only currently']
      'Archive Link':                 [true,  'Add an archive link to the menu']
      'Embed Link':                   [true,  'Add an embed link to the menu to embed all supported formats in a post']
    Monitoring:
      'Thread Updater':               [true,  'Update threads. Has more options in its own dialog.']
      'Dynamic Increase':             [false, 'Increase update timings based on a threads activity']
      'Interval per board':           [false, 'Change the intervals of updates on a board-by-board basis.']
      'Unread Count':                 [true,  'Show unread post count in tab title']
      'Unread Favicon':               [true,  'Show a different favicon when there are unread posts']
      'Post in Title':                [true,  'Show the op\'s post in the tab title']
      'Thread Stats':                 [true,  'Display reply and image count']
      'Thread Watcher':               [false, 'Bookmark threads']
      'Auto Watch':                   [false, 'Automatically watch threads that you start']
      'Auto Watch Reply':             [false, 'Automatically watch threads that you reply to']
      'Color user IDs':               [true,  'Assign unique colors to user IDs on boards that use them']
      'Remove Spoilers':              [false, 'Remove all spoilers in text']
    Posting:
      'Quick Reply':                  [true,  'Reply without leaving the page']
      'Focus on Alert':               [true,  'Switch to tab if an error occurs']
      'Cooldown':                     [true,  'Prevent "flood detected" errors']
      'Validate CAPTCHA':             [true,  'Validate cached CAPTCHAs']
      'Persistent QR':                [false, 'The Quick reply won\'t disappear after posting']
      'Auto Hide QR':                 [false, 'Automatically hide the quick reply when posting']
      'Open Reply in New Tab':        [false, 'Open replies in a new tab that are made from the main board']
      'Per Board Persona':            [false, 'Remember Name, Email, Subject, etc per board instead of globally']
      'Remember QR size':             [false, 'Remember the size of the Quick reply (Firefox only)']
      'Remember Subject':             [false, 'Remember the subject field, instead of resetting after posting']
      'Remember Spoiler':             [false, 'Remember the spoiler state, instead of resetting after posting']
      'Remember Sage':                [false, 'Remember email even if it contains sage']
      'Hide Original Post Form':      [true,  'Replace the normal post form with a shortcut to open the QR']
      'Markdown':                     [false, 'Code, italic, bold, italic bold, double struck - `, *, **, ***, ||, respectively. _ can be used instead of *']
    Quoting:
      'Quote Backlinks':              [true,  'Add quote backlinks']
      'OP Backlinks':                 [true,  'Add backlinks to the OP']
      'Quote Highlighting':           [true,  'Highlight the previewed post']
      'Quote Inline':                 [true,  'Show quoted post inline on quote click']
      'Quote Inline on index':        [false, 'Only activate Quote Inline on board index']
      'Quote Preview':                [true,  'Show quote content on hover']
      'Resurrect Quotes':             [true,  'Linkify dead quotes to archives']
      'Indicate OP quote':            [true,  'Add \'(OP)\' to OP quotes']
      'Indicate Quotes of You':       [true,  'Add \'(You)\' to your quotes']
      'Indicate Cross-thread Quotes': [true,  'Add \'(Cross-thread)\' to cross-threads quotes']
      'Forward Hiding':               [true,  'Hide original posts of inlined backlinks']
  filter:
    name: """
# Filter any namefags:
#/^(?!Anonymous$)/
"""

    uniqueid: """
# Filter a specific ID:
#/Txhvk1Tl/
"""

    tripcode: """
# Filter any tripfags
#/^!/
"""

    mod: """
# Set a custom class for mods:
#/Mod$/;highlight:mod;op:yes
# Set a custom class for moot:
#/Admin$/;highlight:moot;op:yes
"""

    email: """
# Filter any e-mails that are not `sage` on /a/ and /jp/:
#/^(?!sage$)/;boards:a,jp
"""

    subject: """
# Filter Generals on /v/:
#/general/i;boards:v;op:only'
"""

    comment: """
# Filter Stallman copypasta on /g/:
#/what you\'re refer+ing to as linux/i;boards:g
"""

    country: ''

    filename: ''

    dimensions: """
# Highlight potential wallpapers:
#/1920x1080/;op:yes;highlight;top:no;boards:w,wg
"""

    filesize: ''

    md5: ''

  sauces: """
http://iqdb.org/?url=$1
http://www.google.com/searchbyimage?image_url=$1
#http://tineye.com/search?url=$1
#http://saucenao.com/search.php?db=999&url=$1
#http://3d.iqdb.org/?url=$1
#http://regex.info/exif.cgi?imgurl=$2
# uploaders:
#http://imgur.com/upload?url=$2;text:Upload to imgur
#http://omploader.org/upload?url1=$2;text:Upload to omploader
# "View Same" in archives:
#http://archive.foolz.us/_/search/image/$3/;text:View same on foolz
#http://archive.foolz.us/$4/search/image/$3/;text:View same on foolz /$4/
#https://archive.installgentoo.net/$4/image/$3;text:View same on installgentoo /$4/
"""
  time: '%m/%d/%y(%a)%H:%M'
  backlink: '>>%id'
  fileInfo: '%L (%p%s, %r)'
  favicon: 'ferongr'
  updateIncrease: '5,10,15,20,30,60,90,120,240,300'
  updateIncreaseB: '5,10,15,20,30,60,90,120,240,300'
  hotkeys:
    # QR & Options
    openQR:          ['i',      'Open QR with post number inserted']
    openEmptyQR:     ['I',      'Open QR without post number inserted']
    openOptions:     ['ctrl+o', 'Open Options']
    close:           ['Esc',    'Close Options or QR']
    spoiler:         ['ctrl+s', 'Quick spoiler tags']
    math:            ['ctrl+m', 'Quick math tags']
    eqn:             ['ctrl+e', 'Quick eqn tags']
    code:            ['alt+c',  'Quick code tags']
    sageru:          ['alt+n',  'Sage keybind']
    submit:          ['alt+s',  'Submit post']
    hideQR:          ['alt+h',  'Toggle hide status of QR']
    toggleCatalog:   ['alt+t',  'Toggle links in nav bar']
    # Thread related
    watch:           ['w',      'Watch thread']
    update:          ['u',      'Update now']
    unreadCountTo0:  ['z',      'Reset unread status']
    # Images
    expandImage:     ['m',      'Expand selected image']
    expandAllImages: ['M',      'Expand all images']
    # Board Navigation
    zero:            ['0',      'Jump to page 0']
    nextPage:        ['L',      'Jump to the next page']
    previousPage:    ['H',      'Jump to the previous page']
    # Thread Navigation
    nextThread:      ['n',      'See next thread']
    previousThread:  ['p',      'See previous thread']
    expandThread:    ['e',      'Expand thread']
    openThreadTab:   ['o',      'Open thread in new tab']
    openThread:      ['O',      'Open thread in current tab']
    # Reply Navigation
    nextReply:       ['J',      'Select next reply']
    previousReply:   ['K',      'Select previous reply']
    hide:            ['x',      'Hide thread']
  updater:
    checkbox:
      'Beep':        [false, 'Beep on new post to completely read thread']
      'Scrolling':   [false, 'Scroll updated posts into view. Only enabled at bottom of page.']
      'Scroll BG':   [false, 'Scroll background tabs']
      'Verbose':     [true,  'Show countdown timer, new post count']
      'Auto Update': [true,  'Automatically fetch new posts']
    'Interval': 30
    'BGInterval': 60
  embedWidth:  640
  embedHeight: 390

Conf = {}
d = document
g = {}

UI =
  dialog: (id, position, html) ->
    el = d.createElement 'div'
    el.className = 'reply dialog'
    el.innerHTML = html
    el.id        = id
    el.style.cssText = localStorage.getItem("#{Main.namespace}#{id}.position") or position
    el.querySelector('.move').addEventListener 'mousedown', UI.dragstart, false
    el
  dragstart: (e) ->
    #prevent text selection
    e.preventDefault()
    UI.el = el = @parentNode
    d.addEventListener 'mousemove', UI.drag,    false
    d.addEventListener 'mouseup',   UI.dragend, false
    # distance from pointer to el edge is constant; calculate it here.
    rect      = el.getBoundingClientRect()
    UI.dx     = e.clientX - rect.left
    UI.dy     = e.clientY - rect.top
    UI.width  = d.documentElement.clientWidth  - rect.width
    UI.height = d.documentElement.clientHeight - rect.height
  drag: (e) ->
    left = e.clientX - UI.dx
    top  = e.clientY - UI.dy
    left =
      if left < 10 then '0px'
      else if UI.width - left < 10 then null
      else left + 'px'
    top =
      if top < 10 then '0px'
      else if UI.height - top < 10 then null
      else top + 'px'
    #using null instead of '' is 4% faster
    #these 4 statements are 40% faster than 1 style.cssText
    {style} = UI.el
    style.left   = left
    style.top    = top
    style.right  = if left is null then '0px' else null
    style.bottom = if top  is null then '0px' else null
  dragend: ->
    localStorage.setItem "#{Main.namespace}#{UI.el.id}.position", UI.el.style.cssText
    d.removeEventListener 'mousemove', UI.drag,    false
    d.removeEventListener 'mouseup',   UI.dragend, false
    delete UI.el
  hover: (e) ->
    {clientX, clientY} = e
    {style} = UI.el
    {clientHeight, clientWidth} = d.documentElement
    height = UI.el.offsetHeight

    top = clientY - 120
    style.top =
      if clientHeight <= height or top <= 0
        '0px'
      else if top + height >= clientHeight
        clientHeight - height + 'px'
      else
        top + 'px'

    if clientX <= clientWidth - 400
      style.left  = clientX + 45 + 'px'
      style.right = null
    else
      style.left  = null
      style.right = clientWidth - clientX + 45 + 'px'
  hoverend: ->
    $.rm UI.el
    delete UI.el

###
loosely follows the jquery api:
http://api.jquery.com/
not chainable
###
$ = (selector, root=d.body) ->
  root.querySelector selector

$.extend = (object, properties) ->
  for key, val of properties
    object[key] = val
  return

$.extend $,
  SECOND: 1000
  MINUTE: 1000*60
  HOUR  : 1000*60*60
  DAY   : 1000*60*60*24
  engine: /WebKit|Presto|Gecko/.exec(navigator.userAgent)[0].toLowerCase()
  log:
    # XXX GreaseMonkey can't into console.log.bind
    console.log.bind? console
  ready: (fc) ->
    if /interactive|complete/.test d.readyState
      # Execute the functions in parallel.
      # If one fails, do not stop the others.
      return setTimeout fc
    cb = ->
      $.off d, 'DOMContentLoaded', cb
      fc()
    $.on d, 'DOMContentLoaded', cb
  sync: (key, cb) ->
    key = Main.namespace + key
    $.on window, 'storage', (e) ->
      cb JSON.parse e.newValue if e.key is key
  id: (id) ->
    d.getElementById id
  formData: (arg) ->
    if arg instanceof HTMLFormElement
      fd = new FormData arg
    else
      fd = new FormData()
      for key, val of arg
        fd.append key, val if val
    fd
  ajax: (url, callbacks, opts={}) ->
    {type, headers, upCallbacks, form} = opts
    r = new XMLHttpRequest()
    r.overrideMimeType 'text/html' unless $.engine is 'webkit'
    type or= form and 'post' or 'get'
    r.open type, url, true
    for key, val of headers
      r.setRequestHeader key, val
    $.extend r, callbacks
    $.extend r.upload, upCallbacks
    r.withCredentials = true if type is 'post'
    r.send form
    r
  crossAjax: (url, callbacks, opts={}) ->
    if typeof GM_xmlhttpRequest != 'undefined'
      gmopts =
        url:     url
        data:    opts.form
        method:  if opts.form then 'POST' else 'GET'
        onload:  callbacks.onload
        onabort: callbacks.onabort
        onerror: callbacks.onerror
        headers:
          Accept: 'text/html'
      GM_xmlhttpRequest gmopts
    else
      if callbacks.onload
        newonload = ->
          callbacks.onload
            readyState:   @readyState
            responseText: @responseText
            status:       @status
            statusText:   @statusText
        callbacks.onload = newonload
      $.ajax url, callbacks, opts
  cache: (url, cb) ->
    if req = $.cache.requests[url]
      if req.readyState is 4
        cb.call req
      else
        req.callbacks.push cb
    else
      req = $.ajax url,
        onload:  -> cb.call @ for cb in @callbacks
        onabort: -> delete $.cache.requests[url]
        onerror: -> delete $.cache.requests[url]
      req.callbacks = [cb]
      $.cache.requests[url] = req
  cb:
    checked: ->
      $.set @name, @checked
      Conf[@name] = @checked
    value: ->
      $.set @name, @value.trim()
      Conf[@name] = @value
  addStyle: (css) ->
    style = $.el 'style',
      textContent: css
    # That's terrible.
    # XXX tmp fix for scriptish:
    # https://github.com/scriptish/scriptish/issues/16
    f = ->
      # XXX Only Chrome has no d.head on document-start.
      if root = d.head or d.documentElement
        $.add root, style
      else
        setTimeout f, 20
    f()
    style
  x: (path, root=d.body) ->
    # XPathResult.ANY_UNORDERED_NODE_TYPE is 8
    d.evaluate(path, root, null, 8, null).
      singleNodeValue
  addClass: (el, className) ->
    el.classList.add className
  rmClass: (el, className) ->
    el.classList.remove className
  rm: (el) ->
    el.parentNode.removeChild el
  tn: (s) ->
    d.createTextNode s
  nodes: (nodes) ->
    # In (at least) Chrome, elements created inside different
    # scripts/window contexts inherit from unequal prototypes.
    # window_ext1.Node !== window_ext2.Node
    unless nodes instanceof Array
      return nodes
    frag = d.createDocumentFragment()
    for node in nodes
      frag.appendChild node
    frag
  add: (parent, children) ->
    parent.appendChild $.nodes children
  prepend: (parent, children) ->
    parent.insertBefore $.nodes(children), parent.firstChild
  after: (root, el) ->
    root.parentNode.insertBefore $.nodes(el), root.nextSibling
  before: (root, el) ->
    root.parentNode.insertBefore $.nodes(el), root
  replace: (root, el) ->
    root.parentNode.replaceChild $.nodes(el), root
  el: (tag, properties) ->
    el = d.createElement tag
    $.extend el, properties if properties
    el
  on: (el, events, handler) ->
    for event in events.split ' '
      el.addEventListener event, handler, false
    return
  off: (el, events, handler) ->
    for event in events.split ' '
      el.removeEventListener event, handler, false
    return
  open: (url) ->
    (GM_openInTab or window.open) location.protocol + url, '_blank'
  event: (el, e) ->
    el.dispatchEvent e
  globalEval: (code) ->
    script = $.el 'script', textContent: code
    $.add d.head, script
    $.rm script
  bytesToString: (size) ->
    unit = 0 # Bytes
    while size >= 1024
      size /= 1024
      unit++
    # Remove trailing 0s.
    size =
      if unit > 1
        # Keep the size as a float if the size is greater than 2^20 B.
        # Round to hundredth.
        Math.round(size * 100) / 100
      else
        # Round to an integer otherwise.
        Math.round size
    "#{size} #{['B', 'KB', 'MB', 'GB'][unit]}"
  # a function that will execute at most every 'wait' ms. executes immediately
  # if possible, else discards invocation
  debounce: (wait, fn) ->
    timeout = null
    return ->
      if timeout
        # stop current reset
        clearTimeout timeout
      else
        fn.apply this, arguments

      # after wait, let next invocation execute immediately
      timeout = setTimeout (-> timeout = null), wait

$.cache.requests = {}

$.extend $,
  if GM_deleteValue?
    delete: (name) ->
      name = Main.namespace + name
      GM_deleteValue name
    get: (name, defaultValue) ->
      name = Main.namespace + name
      if value = GM_getValue name
        JSON.parse value
      else
        defaultValue
    set: (name, value) ->
      name = Main.namespace + name
      # for `storage` events
      localStorage.setItem name, JSON.stringify value
      GM_setValue name, JSON.stringify value
  else
    delete: (name) ->
      localStorage.removeItem Main.namespace + name
    get: (name, defaultValue) ->
      if value = localStorage.getItem Main.namespace + name
        JSON.parse value
      else
        defaultValue
    set: (name, value) ->
      localStorage.setItem Main.namespace + name, JSON.stringify value

$$ = (selector, root=d.body) ->
  Array::slice.call root.querySelectorAll selector

Markdown =
  format: (text) ->
    tag_patterns =
      bi: /(\*\*\*|___)(?=\S)([^\r\n]*?\S)\1/g
      b: /(\*\*|__)(?=\S)([^\r\n]*?\S)\1/g
      i: /(\*|_)(?=\S)([^\r\n]*?\S)\1/g
      code: /(`)(?=\S)([^\r\n]*?\S)\1/g
      ds: /(\|\||__)(?=\S)([^\r\n]*?\S)\1/g

    for tag, pattern of tag_patterns
      text =
        if text
          text.replace pattern, Markdown.unicode_convert
        else
          '\u0020'
    text

  unicode_convert: (str, tag, inner) ->
    fmt =
      if tag in ['_', '*']
        'i'
      else if tag in ['__', '**']
        'b'
      else if tag in ['___', '***']
        'bi'
      else if tag is '||'
        'ds'
      else if tag in ['`', '```']
        'code'

    # Unicode codepoints for the characters '0', 'A', and 'a'
    # http://en.wikipedia.org/wiki/Mathematical_Alphanumeric_Symbols
    codepoints =
      b:    [ 0x1D7CE, 0x1D400, 0x1D41A ] # MATHEMATICAL BOLD
      i:    [ 0x1D7F6, 0x1D434, 0x1D44E ] # MATHEMATICAL ITALIC
      bi:   [ 0x1D7CE, 0x1D468, 0x1D482 ] # MATHEMATICAL BOLD ITALIC
      code: [ 0x1D7F6, 0x1D670, 0x1D68A ] # MATHEMATICAL MONOSPACE
      ds:   [ 0x1D7D8, 0x1D538, 0x1D552 ] # I FUCKING LOVE CAPS LOCK

    charcodes = (inner.charCodeAt i for c, i in inner)

    codes = for charcode in charcodes
      if charcode >= 48 and charcode <= 57
        charcode - 48 + codepoints[fmt][0]
      else if charcode >= 65 and charcode <= 90
        charcode - 65 + codepoints[fmt][1]
      else if charcode >= 97 and charcode <= 122
        if charcode is 104 and tag is 'i'
          # http://blogs.msdn.com/b/michkap/archive/2006/04/21/580328.aspx
          # mathematical small h -> planck constant
          0x210E
        else
          charcode - 97 + codepoints[fmt][2]
      else
        charcode

    unicode_text = codes.map(Markdown.ucs2_encode).join ''
    unicode_text = unicode_text.replace /\x20/g, '\xA0'  if tag is 'code'
    unicode_text

  ucs2_encode: (value) ->
    # translates Unicode codepoint integers directly into text. Javascript does this in an ugly fashion by default.
    ###
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
    ###
    output = ''
    if value > 0xFFFF
      value -= 0x10000
      output += String.fromCharCode value >>> 10 & 0x3FF | 0xD800
      value = 0xDC00 | value & 0x3FF
    output += String.fromCharCode value

Filter =
  filters: {}
  init: ->
    for key of Config.filter
      @filters[key] = []
      for filter in Conf[key].split '\n'
        continue if filter[0] is '#'

        unless regexp = filter.match /\/(.+)\/(\w*)/
          continue

        # Don't mix up filter flags with the regular expression.
        filter = filter.replace regexp[0], ''

        # Do not add this filter to the list if it's not a global one
        # and it's not specifically applicable to the current board.
        # Defaults to global.
        boards = filter.match(/boards:([^;]+)/)?[1].toLowerCase() or 'global'
        if boards isnt 'global' and boards.split(',').indexOf(g.BOARD) is -1
          continue

        if key is 'md5'
          # MD5 filter will use strings instead of regular expressions.
          regexp = regexp[1]
        else
          try
            # Please, don't write silly regular expressions.
            regexp = RegExp regexp[1], regexp[2]
          catch err
            # I warned you, bro.
            alert err.message
            continue

        # Filter OPs along with their threads, replies only, or both.
        # Defaults to replies only.
        op = filter.match(/[^t]op:(yes|no|only)/)?[1] or 'no'

        # Overrule the `Show Stubs` setting.
        # Defaults to stub showing.
        stub = switch filter.match(/stub:(yes|no)/)?[1]
          when 'yes'
            true
          when 'no'
            false
          else
            Conf['Show Stubs']

        # Highlight the post, or hide it.
        # If not specified, the highlight class will be filter_highlight.
        # Defaults to post hiding.
        if hl = /highlight/.test filter
          hl  = filter.match(/highlight:(\w+)/)?[1] or 'filter_highlight'
          # Put highlighted OP's thread on top of the board page or not.
          # Defaults to on top.
          top = filter.match(/top:(yes|no)/)?[1] or 'yes'
          top = top is 'yes' # Turn it into a boolean

        @filters[key].push @createFilter regexp, op, stub, hl, top

      # Only execute filter types that contain valid filters.
      unless @filters[key].length
        delete @filters[key]

    if Object.keys(@filters).length
      Main.callbacks.push @node

  createFilter: (regexp, op, stub, hl, top) ->
    test =
      if typeof regexp is 'string'
        # MD5 checking
        (value) -> regexp is value
      else
        (value) -> regexp.test value
    settings =
      hide:  !hl
      stub:  stub
      class: hl
      top:   top
    (value, isOP) ->
      if isOP and op is 'no' or !isOP and op is 'only'
        return false
      unless test value
        return false
      settings

  node: (post) ->
    return if post.isInlined
    isOP = post.ID is post.threadID
    {root} = post
    for key of Filter.filters
      value = Filter[key] post
      if value is false
        # Continue if there's nothing to filter (no tripcode for example).
        continue
      for filter in Filter.filters[key]
        unless result = filter value, isOP
          continue

        # Hide
        if result.hide
          if isOP
            unless g.REPLY
              ThreadHiding.hide root.parentNode, result.stub
            else
              continue
          else
            ReplyHiding.hide root, result.stub
          return

        # Highlight
        $.addClass root, result.class
        if isOP and result.top and not g.REPLY
          # Put the highlighted OPs' thread on top of the board page...
          thisThread = root.parentNode
          # ...before the first non highlighted thread.
          if firstThread = $ 'div[class="postContainer opContainer"]'
            unless firstThread is root
              $.before firstThread.parentNode, [thisThread, thisThread.nextElementSibling]

  name: (post) ->
    $('.name', post.el).textContent
  uniqueid: (post) ->
    if uid = $ '.posteruid', post.el
      return uid.textContent[5...-1]
    false
  tripcode: (post) ->
    if trip = $ '.postertrip', post.el
      return trip.textContent
    false
  mod: (post) ->
    if mod = $ '.capcode', post.el
      return mod.textContent
    false
  email: (post) ->
    if mail = $ '.useremail', post.el
      # remove 'mailto:'
      # decode %20 into space for example
      return decodeURIComponent mail.href[7..]
    false
  subject: (post) ->
    if subject = $ '.postInfo .subject', post.el
      return subject.textContent
    false
  comment: (post) ->
    text = []
    # XPathResult.ORDERED_NODE_SNAPSHOT_TYPE is 7
    nodes = d.evaluate './/br|.//text()', post.blockquote, null, 7, null
    for i in [0...nodes.snapshotLength]
      text.push if data = nodes.snapshotItem(i).data then data else '\n'
    text.join ''
  country: (post) ->
    if flag = $ '.countryFlag', post.el
      return flag.title
    false
  filename: (post) ->
    {fileInfo} = post
    if fileInfo
      if file = $ '.fileText > span', fileInfo
        return file.title
      else
        return fileInfo.firstElementChild.dataset.filename
    false
  dimensions: (post) ->
    {fileInfo} = post
    if fileInfo and match = fileInfo.textContent.match /\d+x\d+/
      return match[0]
    false
  filesize: (post) ->
    {img} = post
    if img
      return img.alt.replace 'Spoiler Image, ', ''
    false
  md5: (post) ->
    {img} = post
    if img
      return img.dataset.md5
    false

  menuInit: ->
    div = $.el 'div',
      textContent: 'Filter'

    entry =
      el: div
      open: -> true
      children: []

    for type in [
      ['Name',             'name']
      ['Unique ID',        'uniqueid']
      ['Tripcode',         'tripcode']
      ['Admin/Mod',        'mod']
      ['E-mail',           'email']
      ['Subject',          'subject']
      ['Comment',          'comment']
      ['Country',          'country']
      ['Filename',         'filename']
      ['Image dimensions', 'dimensions']
      ['Filesize',         'filesize']
      ['Image MD5',        'md5']
    ]
      # Add a sub entry for each filter type.
      entry.children.push Filter.createSubEntry type[0], type[1]

    Menu.addEntry entry

  createSubEntry: (text, type) ->
    el = $.el 'a',
      href: 'javascript:;'
      textContent: text
    # Define the onclick var outside of open's scope to $.off it properly.
    onclick = null

    open = (post) ->
      value = Filter[type] post
      return false if value is false
      $.off el, 'click', onclick
      onclick = ->
        # Convert value -> regexp, unless type is md5
        re = if type is 'md5' then value else value.replace ///
          /
          | \\
          | \^
          | \$
          | \n
          | \.
          | \(
          | \)
          | \{
          | \}
          | \[
          | \]
          | \?
          | \*
          | \+
          | \|
          ///g, (c) ->
            if c is '\n'
              '\\n'
            else if c is '\\'
              '\\\\'
            else
              "\\#{c}"

        re =
          if type is 'md5'
            "/#{value}/"
          else
            "/^#{re}$/"
        if /\bop\b/.test post.class
          re += ';op:yes'

        # Add a new line before the regexp unless the text is empty.
        save = if save = $.get type, '' then "#{save}\n#{re}" else re
        $.set type, save

        # Open the options and display & focus the relevant filter textarea.
        Options.dialog()
        select = $ 'select[name=filter]', $.id 'options'
        select.value = type
        $.event select, new Event 'change'
        $.id('filter_tab').checked = true
        ta = select.nextElementSibling
        tl = ta.textLength
        ta.setSelectionRange tl, tl
        ta.focus()
      $.on el, 'click', onclick
      true

    return el: el, open: open

StrikethroughQuotes =
  init: ->
    Main.callbacks.push @node
  node: (post) ->
    return if post.isInlined
    for quote in post.quotes
      continue unless (el = $.id quote.hash[1..]) and quote.hostname is 'boards.4chan.org' and !/catalog$/.test(quote.pathname) and el.hidden
      $.addClass quote, 'filtered'
      if Conf['Recursive Filtering'] and post.ID isnt post.threadID
        show_stub = !!$.x 'preceding-sibling::div[contains(@class,"stub")]', el
        ReplyHiding.hide post.root, show_stub
    return

ExpandComment =
  init: ->
    for a in $$ '.abbr'
      $.on a.firstElementChild, 'click', ExpandComment.expand
    return
  expand: (e) ->
    e.preventDefault()
    [_, threadID, replyID] = @href.match /(\d+)#p(\d+)/
    @textContent = "Loading No.#{replyID}..."
    a = @
    $.cache "//api.4chan.org#{@pathname}.json", -> ExpandComment.parse @, a, threadID, replyID
  parse: (req, a, threadID, replyID) ->
    if req.status isnt 200
      a.textContent = "#{req.status} #{req.statusText}"
      return

    posts = JSON.parse(req.response).posts
    if spoilerRange = posts[0].custom_spoiler
      Build.spoilerRange[g.BOARD] = spoilerRange
    replyID = +replyID

    for post in posts
      break if post.no is replyID
    if post.no isnt replyID
      a.textContent = 'No.#{replyID} not found.'
      return

    bq = $.id "m#{replyID}"
    clone = bq.cloneNode false
    clone.innerHTML = post.com
    quotes = clone.getElementsByClassName 'quotelink'
    for quote in quotes
      href = quote.getAttribute 'href'
      continue if href[0] is '/' # Cross-board quote
      quote.href = "res/#{href}" # Fix pathnames
    post =
      blockquote: clone
      threadID:   threadID
      quotes:     quotes
      backlinks:  []
    if Conf['Linkify']
      Linkify.node        post
    if Conf['Resurrect Quotes']
      Quotify.node        post
    if Conf['Quote Preview']
      QuotePreview.node   post
    if Conf['Quote Inline']
      QuoteInline.node    post
    if Conf['Indicate OP quote']
      QuoteOP.node        post
    if Conf['Indicate Quotes of You']
      QuoteYou.node       post
    if Conf['Indicate Cross-thread Quotes']
      QuoteCT.node        post
    $.replace bq, clone
    Main.prettify clone

ExpandThread =
  init: ->
    for span in $$ '.summary'
      a = $.el 'a',
        textContent: "+ #{span.textContent}"
        className: 'summary desktop'
        href: 'javascript:;'
      $.on a, 'click', -> ExpandThread.toggle @parentNode
      $.replace span, a

  toggle: (thread) ->
    url = "//api.4chan.org/#{g.BOARD}/res/#{thread.id[1..]}.json"
    a   = $ '.summary', thread

    switch a.textContent[0]
      when '+'
        a.textContent = a.textContent.replace '+', '× Loading...'
        $.cache url, -> ExpandThread.parse @, thread, a

      when '×'
        a.textContent = a.textContent.replace '× Loading...', '+'
        $.cache.requests[url].abort()

      when '-'
        a.textContent = a.textContent.replace '-', '+'
        #goddamit moot
        num = switch g.BOARD
          when 'b', 'vg', 'q' then 3
          when 't' then 1
          else 5
        replies = $$ '.replyContainer', thread
        replies.splice replies.length - num, num
        for reply in replies
          $.rm reply
    return

  parse: (req, thread, a) ->
    if req.status isnt 200
      a.textContent = "#{req.status} #{req.statusText}"
      $.off a, 'click', ExpandThread.cb.toggle
      return

    a.textContent = a.textContent.replace '× Loading...', '-'

    posts = JSON.parse(req.response).posts
    if spoilerRange = posts[0].custom_spoiler
      Build.spoilerRange[g.BOARD] = spoilerRange

    replies  = posts[1..]
    threadID = thread.id[1..]
    nodes    = []
    for reply in replies
      post = Build.postFromObject reply, g.BOARD
      id   = reply.no
      link = $ 'a[title="Highlight this post"]', post
      link.href = "res/#{threadID}#p#{id}"
      link.nextSibling.href = "res/#{threadID}#q#{id}"
      nodes.push post
    # eat everything, then replace with fresh full posts
    for post in $$ '.summary ~ .replyContainer', a.parentNode
      $.rm post
    for backlink in $$ '.backlink', a.previousElementSibling
      # Keep backlinks from other threads.
      $.rm backlink unless $.id backlink.hash[1..]
    $.after a, nodes

ThreadHiding =
  init: ->
    hiddenThreads = ThreadHiding.sync()
    return if g.CATALOG
    for thread in $$ '.thread'
      a = $.el 'a',
        className: 'hide_thread_button'
        innerHTML: '<span>[ - ]</span>'
        href: 'javascript:;'
      $.on a, 'click', ThreadHiding.cb
      $.prepend thread, a

      if thread.id[1..] of hiddenThreads
        ThreadHiding.hide thread
    return

  sync: ->
    hiddenThreads = $.get "hiddenThreads/#{g.BOARD}/", {}
    hiddenThreadsCatalog = JSON.parse(localStorage.getItem "4chan-hide-t-#{g.BOARD}") or {}
    if g.CATALOG
      for id of hiddenThreads
        hiddenThreadsCatalog[id] = true
      localStorage.setItem "4chan-hide-t-#{g.BOARD}", JSON.stringify hiddenThreadsCatalog
    else
      for id of hiddenThreadsCatalog
        unless id of hiddenThreads
          hiddenThreads[id] = Date.now()
      $.set "hiddenThreads/#{g.BOARD}/", hiddenThreads
    hiddenThreads

  cb: ->
    ThreadHiding.toggle $.x 'ancestor::div[parent::div[@class="board"]]', @

  toggle: (thread) ->
    hiddenThreads = $.get "hiddenThreads/#{g.BOARD}/", {}
    id = thread.id[1..]
    if thread.hidden or /\bhidden_thread\b/.test thread.firstChild.className
      ThreadHiding.show thread
      delete hiddenThreads[id]
    else
      ThreadHiding.hide thread
      hiddenThreads[id] = Date.now()
    $.set "hiddenThreads/#{g.BOARD}/", hiddenThreads

  hide: (thread, show_stub=Conf['Show Stubs']) ->
    unless show_stub
      thread.hidden = true
      thread.nextElementSibling.hidden = true
      return

    return if /\bhidden_thread\b/.test thread.firstChild.className # already hidden once by the filter

    num     = 0
    if span = $ '.summary', thread
      num   = Number span.textContent.match /\d+/
    num    += $$('.opContainer ~ .replyContainer', thread).length
    text    = if num is 1 then '1 reply' else "#{num} replies"
    opInfo  = $('.desktop > .nameBlock', thread).textContent

    stub = $.el 'div',
      className: 'hide_thread_button hidden_thread'
      innerHTML: '<a href="javascript:;"><span>[ + ]</span> </a>'
    a = stub.firstChild
    $.on  a, 'click', ThreadHiding.cb
    $.add a, $.tn "#{opInfo} (#{text})"
    if Conf['Menu']
      menuButton = Menu.a.cloneNode true
      $.on menuButton, 'click', Menu.toggle
      $.add stub, [$.tn(' '), menuButton]
    $.prepend thread, stub

  show: (thread) ->
    if stub = $ '.hidden_thread', thread
      $.rm stub
    thread.hidden = false
    thread.nextElementSibling.hidden = false

ReplyHiding =
  init: ->
    Main.callbacks.push @node

  node: (post) ->
    return if post.isInlined or post.ID is post.threadID
    side = $ '.sideArrows', post.root
    $.addClass side, 'hide_reply_button'
    side.innerHTML = '<a href="javascript:;"><span>[ - ]</span></a>'
    $.on side.firstChild, 'click', ReplyHiding.toggle

    if post.ID of g.hiddenReplies
      ReplyHiding.hide post.root

  toggle: ->
    button = @parentNode
    root   = button.parentNode
    id     = root.id[2..]
    quotes = $$ ".quotelink[href$='#p#{id}'], .backlink[href$='#p#{id}']"
    if /\bstub\b/.test button.className
      ReplyHiding.show root
      $.rmClass root, 'hidden'
      for quote in quotes
        $.rmClass quote, 'filtered'
      delete g.hiddenReplies[id]
    else
      ReplyHiding.hide root
      for quote in quotes
        $.addClass quote, 'filtered'
      g.hiddenReplies[id] = Date.now()
    $.set "hiddenReplies/#{g.BOARD}/", g.hiddenReplies

  hide: (root, show_stub=Conf['Show Stubs']) ->
    side = $ '.sideArrows', root
    $.addClass side.parentNode, 'hidden'
    return if side.hidden # already hidden once by the filter
    side.hidden = true
    el = side.nextElementSibling
    el.hidden = true

    return unless show_stub

    stub = $.el 'div',
      className: 'hide_reply_button stub'
      innerHTML: '<a href="javascript:;"><span>[ + ]</span> </a>'
    a = stub.firstChild
    $.on  a, 'click', ReplyHiding.toggle
    $.add a, $.tn if Conf['Anonymize'] then 'Anonymous' else $('.desktop > .nameBlock', el).textContent
    if Conf['Menu']
      menuButton = Menu.a.cloneNode true
      $.on menuButton, 'click', Menu.toggle
      $.add stub, [$.tn(' '), menuButton]
    $.prepend root, stub

  show: (root) ->
    if stub = $ '.stub', root
      $.rm stub
    $('.sideArrows', root).hidden = false
    $('.post',       root).hidden = false

Menu =
  entries: []
  init: ->
    @a = $.el 'a',
      className: 'menu_button'
      href:      'javascript:;'
      innerHTML: '[<span></span>]'
    @el = $.el 'div',
      className: 'reply dialog'
      id:        'menu'
      tabIndex:  0
    $.on @el, 'click',   (e) -> e.stopPropagation()
    $.on @el, 'keydown', @keybinds

    # Doc here: https://github.com/MayhemYDG/4chan-x/wiki/Menu-API
    $.on d, 'AddMenuEntry', (e) -> Menu.addEntry e.detail

    Main.callbacks.push @node
  node: (post) ->
    if post.isInlined and !post.isCrosspost
      a = $ '.menu_button', post.el
    else
      a = Menu.a.cloneNode true
      # \u00A0 is nbsp
      $.add $('.postInfo', post.el), [$.tn('\u00A0'), a]
    $.on a, 'click', Menu.toggle

  toggle: (e) ->
    e.preventDefault()
    e.stopPropagation()

    if Menu.el.parentNode
      # Close if it's already opened.
      # Reopen if we clicked on another button.
      {lastOpener} = Menu
      Menu.close()
      return if lastOpener is @

    Menu.lastOpener = @
    post =
      if /\bhidden_thread\b/.test @parentNode.className
        $.x 'ancestor::div[parent::div[@class="board"]]/child::div[contains(@class,"opContainer")]', @
      else
        $.x 'ancestor::div[contains(@class,"postContainer")][1]', @
    Menu.open @, Main.preParse post
  open: (button, post) ->
    {el} = Menu
    # XXX GM/Scriptish require setAttribute
    el.setAttribute 'data-id', post.ID
    el.setAttribute 'data-rootid', post.root.id

    funk = (entry, parent) ->
      {children} = entry
      return unless entry.open post
      $.add parent, entry.el

      return unless children
      if subMenu = $ '.subMenu', entry.el
        # Reset sub menu, remove irrelevant entries.
        $.rm subMenu
      subMenu = $.el 'div',
        className: 'reply dialog subMenu'
      $.add entry.el, subMenu
      for child in children
        funk child, subMenu
      return
    for entry in Menu.entries
      funk entry, el

    Menu.focus $ '.entry', Menu.el
    $.on d, 'click', Menu.close
    $.add d.body, el

    # Position
    mRect = el.getBoundingClientRect()
    bRect = button.getBoundingClientRect()
    bTop  = d.documentElement.scrollTop  + d.body.scrollTop  + bRect.top
    bLeft = d.documentElement.scrollLeft + d.body.scrollLeft + bRect.left
    el.style.top =
      if bRect.top + bRect.height + mRect.height < d.documentElement.clientHeight
        bTop + bRect.height + 2 + 'px'
      else
        bTop - mRect.height - 2 + 'px'
    el.style.left =
      if bRect.left + mRect.width < d.documentElement.clientWidth
        bLeft + 'px'
      else
        bLeft + bRect.width - mRect.width + 'px'

    el.focus()
  close: ->
    {el} = Menu
    $.rm el
    for focused in $$ '.focused.entry', el
      $.rmClass focused, 'focused'
    el.innerHTML = null
    el.removeAttribute 'style'
    delete Menu.lastOpener
    delete Menu.focusedEntry
    $.off d, 'click', Menu.close

  keybinds: (e) ->
    el = Menu.focusedEntry

    switch Keybinds.keyCode(e) or e.keyCode
      when 'Esc'
        Menu.lastOpener.focus()
        Menu.close()
      when 13, 32 # 'Enter', 'Space'
        el.click()
      when 'Up'
        if next = el.previousElementSibling
          Menu.focus next
      when 'Down'
        if next = el.nextElementSibling
          Menu.focus next
      when 'Right'
        if (subMenu = $ '.subMenu', el) and next = subMenu.firstElementChild
          Menu.focus next
      when 'Left'
        if next = $.x 'parent::*[contains(@class,"subMenu")]/parent::*', el
          Menu.focus next
      else
        return

    e.preventDefault()
    e.stopPropagation()
  focus: (el) ->
    if focused = $.x 'parent::*/child::*[contains(@class,"focused")]', el
      $.rmClass focused, 'focused'
    for focused in $$ '.focused', el
      $.rmClass focused, 'focused'
    Menu.focusedEntry = el
    $.addClass el, 'focused'

  addEntry: (entry) ->
    funk = (entry) ->
      {el, children} = entry
      $.addClass el, 'entry'
      $.on el, 'focus mouseover', (e) ->
        e.stopPropagation()
        Menu.focus @
      return unless children
      $.addClass el, 'hasSubMenu'
      for child in children
        funk child
      return
    funk entry
    Menu.entries.push entry

Keybinds =
  init: ->
    for node in $$ '[accesskey]'
      node.removeAttribute 'accesskey'
    $.on d, 'keydown',  Keybinds.keydown

  keydown: (e) ->
    return unless key = Keybinds.keyCode e
    {target} = e
    if /TEXTAREA|INPUT/.test target.nodeName
      return unless (key is 'Esc') or (/\+/.test key)

    thread = Nav.getThread()
    switch key
      # QR & Options
      when Conf.openQR
        Keybinds.qr thread, true
      when Conf.openEmptyQR
        Keybinds.qr thread
      when Conf.openOptions
        Options.dialog() unless $.id 'overlay'
      when Conf.close
        if o = $.id 'overlay'
          Options.close.call o
        else if QR.el
          if Conf['Persistent QR']
            unless ($ '#autohide', QR.el).checked
              QR.hide()
            else QR.unhide()
          else
            QR.close()
      when Conf.submit
        QR.submit() if QR.el and !QR.status()
      when Conf.hideQR
        unless ($ '#autohide', QR.el).checked
          QR.hide()
        else QR.unhide()
      when Conf.toggleCatalog
        CatalogLinks.toggle()
      when Conf.spoiler
        return unless ($ '[name=spoiler]') and target.nodeName is 'TEXTAREA'
        Keybinds.tags 'spoiler', target
      when Conf.math
        return unless (!! $ 'script[src^="//boards.4chan.org/jsMath/"]', d.head) and target.nodeName is 'TEXTAREA'
        Keybinds.tags 'math', target
      when Conf.eqn
        return unless (!! $ 'script[src^="//boards.4chan.org/jsMath/"]', d.head) and target.nodeName is 'TEXTAREA'
        Keybinds.tags 'eqn', target
      when Conf.code
        return unless Main.hasCodeTags and target.nodeName is 'TEXTAREA'
        Keybinds.tags 'code', target
      when Conf.sageru
        $("[name=email]", QR.el).value = "sage"
        QR.selected.email = "sage"
      # Thread related
      when Conf.watch
        Watcher.toggle thread
      when Conf.update
        Updater.update()
      when Conf.unreadCountTo0
        Unread.replies = []
        Unread.update true
      # Images
      when Conf.expandImage
        Keybinds.img thread
      when Conf.expandAllImages
        Keybinds.img thread, true
      # Board Navigation
      when Conf.zero
        window.location = "/#{g.BOARD}/0#delform"
      when Conf.nextPage
        if form = $ '.next form'
          window.location = form.action
      when Conf.previousPage
        if form = $ '.prev form'
          window.location = form.action
      # Thread Navigation
      when Conf.nextThread
        return if g.REPLY
        Nav.scroll +1
      when Conf.previousThread
        return if g.REPLY
        Nav.scroll -1
      when Conf.expandThread
        ExpandThread.toggle thread
      when Conf.openThread
        Keybinds.open thread
      when Conf.openThreadTab
        Keybinds.open thread, true
      # Reply Navigation
      when Conf.nextReply
        Keybinds.hl +1, thread
      when Conf.previousReply
        Keybinds.hl -1, thread
      when Conf.hide
        ThreadHiding.toggle thread if /\bthread\b/.test thread.className
      else
        return
    e.preventDefault()

  keyCode: (e) ->
    key = switch kc = e.keyCode
      when 8
        ''
      when 13
        'Enter'
      when 27
        'Esc'
      when 37
        'Left'
      when 38
        'Up'
      when 39
        'Right'
      when 40
        'Down'
      when 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90 #0-9, A-Z
        c = String.fromCharCode kc
        if e.shiftKey then c else c.toLowerCase()
      else
        null
    if key
      if e.altKey  then key = 'alt+'  + key
      if e.ctrlKey then key = 'ctrl+' + key
      if e.metaKey then key = 'meta+' + key
    key

  tags: (tag, ta) ->
    value    = ta.value
    selStart = ta.selectionStart
    selEnd   = ta.selectionEnd

    ta.value =
      value[...selStart] +
      "[#{tag}]" + value[selStart...selEnd] + "[/#{tag}]" +
      value[selEnd..]

    range = "[#{tag}]".length + selEnd
    # Move the caret to the end of the selection.
    ta.setSelectionRange range, range

    # Fire the 'input' event
    $.event ta, new Event 'input'

  img: (thread, all) ->
    if all
      $.id('imageExpand').click()
    else
      thumb = $ 'img[data-md5]', $('.post.highlight', thread) or thread
      ImageExpand.toggle thumb.parentNode

  qr: (thread, quote) ->
    if quote
      QR.quote.call $ 'a[title="Quote this post"]', $('.post.highlight', thread) or thread
    else
      QR.open()
    $('textarea', QR.el).focus()

  open: (thread, tab) ->
    return if g.REPLY
    id = thread.id[1..]
    url = "//boards.4chan.org/#{g.BOARD}/res/#{id}"
    if tab
      $.open url
    else
      location.href = url

  hl: (delta, thread) ->
    if post = $ '.reply.highlight', thread
      $.rmClass post, 'highlight'
      post.removeAttribute 'tabindex'
      rect = post.getBoundingClientRect()
      if rect.bottom >= 0 and rect.top <= d.documentElement.clientHeight # We're at least partially visible
        next = $.x 'child::div[contains(@class,"post reply")]',
          if delta is +1 then post.parentNode.nextElementSibling else post.parentNode.previousElementSibling
        unless next
          @focus post
          return
        return unless g.REPLY or $.x('ancestor::div[parent::div[@class="board"]]', next) is thread
        rect = next.getBoundingClientRect()
        if rect.top < 0 or rect.bottom > d.documentElement.clientHeight
          next.scrollIntoView delta is -1
        @focus next
        return

    replies = $$ '.reply', thread
    replies.reverse() if delta is -1
    for reply in replies
      rect = reply.getBoundingClientRect()
      if delta is +1 and rect.top >= 0 or delta is -1 and rect.bottom <= d.documentElement.clientHeight
        @focus reply
        return

  focus: (post) ->
    $.addClass post, 'highlight'
    post.tabIndex = 0
    post.focus()

Nav =
  # ◀ ▶
  init: ->
    span = $.el 'span',
      id: 'navlinks'
    prev = $.el 'a',
      textContent: '▲'
      href: 'javascript:;'
    next = $.el 'a',
      textContent: '▼'
      href: 'javascript:;'

    $.on prev, 'click', @prev
    $.on next, 'click', @next

    $.add span, [prev, $.tn(' '), next]
    $.add d.body, span

  prev: ->
    if g.REPLY
      window.scrollTo 0, 0
    else
      Nav.scroll -1

  next: ->
    if g.REPLY
      window.scrollTo 0, d.body.scrollHeight
    else
      Nav.scroll +1

  getThread: (full) ->
    Nav.threads = $$ '.thread:not([hidden])'
    for thread, i in Nav.threads
      rect = thread.getBoundingClientRect()
      {bottom} = rect
      if bottom > 0 #we have not scrolled past
        if full
          return [thread, i, rect]
        return thread
    return $ '.board'

  scroll: (delta) ->
    [thread, i, rect] = Nav.getThread true
    {top} = rect

    # unless we're not at the beginning of the current thread
    # (and thus wanting to move to beginning)
    # or we're above the first thread and don't want to skip it
    unless (delta is -1 and Math.ceil(top) < 0) or (delta is +1 and top > 1)
      i += delta

    {top} = Nav.threads[i]?.getBoundingClientRect()
    window.scrollBy 0, top

BanChecker =
  init: ->
    @now = Date.now()
    return if not Conf['Check for Bans constantly'] and $.get 'isBanned'
      @prepend()
    else if Conf['Check for Bans constantly'] or $.get('lastBanCheck', 0) < @now - 6*$.HOUR
      @load()

  load: ->
    @url = 'https://www.4chan.org/banned'
    $.ajax @url,
      onloadend: ->
        if @status is 200 or 304
          $.set 'lastBanCheck', BanChecker.now unless Conf['Check for Bans constantly']
          doc = d.implementation.createHTMLDocument ''
          doc.documentElement.innerHTML = @response
          if /no entry in our database/i.test (msg = $('.boxcontent', doc).textContent.trim())
            $.delete 'isBanned'
            return $.rm $.id 'banChecker'
          $.set 'isBanned',
            if /This ban will not expire/i.test msg
              'You are banned, forever! ;_;'
            else
              'You are banned! ;_;'
          BanChecker.prepend()

  prepend: ->
    @text = $.get('isBanned')
    el = $.el 'h2',
      innerHTML:
        "<span>#{@text.match /^.*(?=banned)/}</span><a href=#{BanChecker.url} title='Click to find out why.' target=_blank>banned</a><span>#{@text.match(/banned.*$/).toString().replace /^banned/, ''}</span>"
      title:  'Click to recheck.'
      id:     'banChecker'
    for text in [el.firstChild, el.lastChild]
      $.on text, 'click', ->
        $.delete 'lastBanCheck' unless Conf['Check for Bans constantly']
        $.delete 'isBanned'
        @parentNode.style.opacity = '.5'
        BanChecker.load()
    if h2 = $.id 'banChecker'
      $.replace h2, el
    else if h1 = $ 'h1'
      $.after h1, el
    else
      $.before $.id('postForm'), el

QR =
  init: ->
    return unless $.id 'postForm'
    Main.callbacks.push @node
    setTimeout @asyncInit

  asyncInit: ->
    if Conf['Hide Original Post Form']
      link = $.el 'h1', innerHTML: "<a href=javascript:;>#{if g.REPLY then 'Reply to Thread' else 'Start a Thread'}</a>"
      $.on link.firstChild, 'click', ->
        QR.open()
        unless g.REPLY
          QR.threadSelector.value =
            if g.BOARD is 'f'
              '9999'
            else
              'new'
        $('textarea', QR.el).focus()
      $.before $.id('postForm'), link
    BanChecker.init() if Conf['Check for Bans']

    if Conf['Persistent QR']
      QR.dialog()
      QR.hide() if Conf['Auto Hide QR']
    $.on d, 'dragover',          QR.dragOver
    $.on d, 'drop',              QR.dropFile
    $.on d, 'dragstart dragend', QR.drag

  node: (post) ->
    $.on $('a[title="Quote this post"]', $('.postInfo', post.el)), 'click', QR.quote

  open: ->
    if QR.el
      QR.el.hidden = false
      QR.unhide()
    else
      QR.dialog()
  close: ->
    QR.el.hidden = true
    QR.abort()
    d.activeElement.blur()
    $.rmClass QR.el, 'dump'
    for i in QR.replies
      QR.replies[0].rm()
    QR.cooldown.auto = false
    QR.status()
    QR.resetFileInput()
    if not Conf['Remember Spoiler'] and (spoiler = $.id 'spoiler').checked
      spoiler.click()
    QR.cleanError()
  hide: ->
    d.activeElement.blur()
    $.addClass QR.el, 'autohide'
    $.id('autohide').checked = true
  unhide: ->
    $.rmClass QR.el, 'autohide'
    $.id('autohide').checked = false
  toggleHide: ->
    @checked and QR.hide() or QR.unhide()

  error: (err) ->
    el = $ '.warning', QR.el
    if typeof err is 'string'
      el.textContent = err
    else
      el.innerHTML = null
      $.add el, err
    QR.open()
    if QR.captcha.isEnabled and /captcha|verification/i.test el.textContent
      # Focus the captcha input on captcha error.
      $('[autocomplete]', QR.el).focus()
    alert el.textContent if Conf['Focus on Alert'] and d.hidden
  cleanError: ->
    $('.warning', QR.el).textContent = null

  status: (data={}) ->
    return unless QR.el
    if g.dead
      value    = 404
      disabled = true
      QR.cooldown.auto = false
    value = data.progress or QR.cooldown.seconds or value
    {input} = QR.status
    input.value =
      if QR.cooldown.auto and Conf['Cooldown']
        if value then "Auto #{value}" else 'Auto'
      else
        value or 'Submit'
    input.disabled = disabled or false

  cooldown:
    init: ->
      return unless Conf['Cooldown']
      QR.cooldown.types =
        thread: switch g.BOARD
          when 'q' then 86400
          when 'b', 'soc', 'r9k' then 600
          else 300
        sage: if g.BOARD is 'q' then 600 else 60
        file: if g.BOARD is 'q' then 300 else 30
        post: if g.BOARD is 'q' then 60  else 30
      QR.cooldown.cooldowns = $.get "#{g.BOARD}.cooldown", {}
      QR.cooldown.start()
      $.sync "#{g.BOARD}.cooldown", QR.cooldown.sync
    start: ->
      return if QR.cooldown.isCounting
      QR.cooldown.isCounting = true
      QR.cooldown.count()
    sync: (cooldowns) ->
      # Add each cooldowns, don't overwrite everything in case we
      # still need to purge one in the current tab to auto-post.
      for id of cooldowns
        QR.cooldown.cooldowns[id] = cooldowns[id]
      QR.cooldown.start()
    set: (data) ->
      return unless Conf['Cooldown']
      start = Date.now()
      if data.delay
        cooldown = delay: data.delay
      else
        isSage  = /sage/i.test data.post.email
        hasFile = !!data.post.file
        isReply = data.isReply
        type =
          unless isReply
            'thread'
          else if isSage
            'sage'
          else if hasFile
            'file'
          else
            'post'
        cooldown =
          isReply: isReply
          isSage:  isSage
          hasFile: hasFile
          timeout: start + QR.cooldown.types[type] * $.SECOND
      QR.cooldown.cooldowns[start] = cooldown
      $.set "#{g.BOARD}.cooldown", QR.cooldown.cooldowns
      QR.cooldown.start()
    unset: (id) ->
      delete QR.cooldown.cooldowns[id]
      $.set "#{g.BOARD}.cooldown", QR.cooldown.cooldowns
    count: ->
      if Object.keys(QR.cooldown.cooldowns).length
        setTimeout QR.cooldown.count, 1000
      else
        $.delete "#{g.BOARD}.cooldown"
        delete QR.cooldown.isCounting
        delete QR.cooldown.seconds
        QR.status()
        return

      if (isReply = if g.REPLY then true else QR.threadSelector.value isnt 'new')
        post    = QR.replies[0]
        isSage  = /sage/i.test post.email
        hasFile = !!post.file
      now     = Date.now()
      seconds = null
      {types, cooldowns} = QR.cooldown

      for start, cooldown of cooldowns
        if 'delay' of cooldown
          if cooldown.delay
            seconds = Math.max seconds, cooldown.delay--
          else
            seconds = Math.max seconds, 0
            QR.cooldown.unset start
          continue

        if isReply is cooldown.isReply
          # Only cooldowns relevant to this post can set the seconds value.
          # Unset outdated cooldowns that can no longer impact us.
          type =
            unless isReply
              'thread'
            else if isSage and cooldown.isSage
              'sage'
            else if hasFile and cooldown.hasFile
              'file'
            else
              'post'
          elapsed = Math.floor (now - start) / 1000
          if elapsed >= 0 # clock changed since then?
            seconds = Math.max seconds, types[type] - elapsed
        unless start <= now <= cooldown.timeout
          QR.cooldown.unset start

      # Update the status when we change posting type.
      # Don't get stuck at some random number.
      # Don't interfere with progress status updates.
      update = seconds isnt null or !!QR.cooldown.seconds
      QR.cooldown.seconds = seconds
      QR.status() if update
      QR.submit() if seconds is 0 and QR.cooldown.auto

  quote: (e) ->
    e?.preventDefault()
    QR.open()
    ta = $ 'textarea', QR.el
    unless g.REPLY or ta.value
      QR.threadSelector.value = $.x('ancestor::div[parent::div[@class="board"]]', @).id[1..]
    # Make sure we get the correct number, even with XXX censors
    id   = @previousSibling.hash[2..]
    text = ">>#{id}\n"

    sel = d.getSelection()
    if (s = sel.toString().trim()) and id is $.x('ancestor-or-self::blockquote', sel.anchorNode)?.id.match(/\d+$/)[0]
      # XXX Opera doesn't retain `\n`s?
      s = s.replace /\n/g, '\n>'
      text += ">#{s}\n"

    caretPos = ta.selectionStart
    # Replace selection for text.
    ta.value = ta.value[...caretPos] + text + ta.value[ta.selectionEnd..]
    # Move the caret to the end of the new quote.
    range = caretPos + text.length
    ta.setSelectionRange range, range
    ta.focus()

    # Fire the 'input' event
    $.event ta, new Event 'input'

  characterCount: ->
    counter = QR.charaCounter
    count   = @textLength
    counter.textContent = count
    counter.hidden      = count < 1000
    (if count > 1500 then $.addClass else $.rmClass) counter, 'warning'

  drag: (e) ->
    # Let it drag anything from the page.
    toggle = if e.type is 'dragstart' then $.off else $.on
    toggle d, 'dragover', QR.dragOver
    toggle d, 'drop',     QR.dropFile
  dragOver: (e) ->
    e.preventDefault()
    e.dataTransfer.dropEffect = 'copy' # cursor feedback
  dropFile: (e) ->
    # Let it only handle files from the desktop.
    return unless e.dataTransfer.files.length
    e.preventDefault()
    QR.open()
    QR.fileInput.call e.dataTransfer
    $.addClass QR.el, 'dump'
  fileInput: ->
    QR.cleanError()
    # Set or change current reply's file.
    if @files.length is 1
      file = @files[0]
      if file.size > @max
        QR.error 'File too large.'
        QR.resetFileInput()
      else if -1 is QR.mimeTypes.indexOf file.type
        QR.error 'Unsupported file type.'
        QR.resetFileInput()
      else
        QR.selected.setFile file
      return
    # Create new replies with these files.
    for file in @files
      if file.size > @max
        QR.error "File #{file.name} is too large."
        break
      else if -1 is QR.mimeTypes.indexOf file.type
        QR.error "#{file.name}: Unsupported file type."
        break
      unless QR.replies[QR.replies.length - 1].file
        # set last reply's file
        QR.replies[QR.replies.length - 1].setFile file
      else
        new QR.reply().setFile file
    $.addClass QR.el, 'dump'
    QR.resetFileInput() # reset input
  resetFileInput: ->
    $('[type=file]', QR.el).value = null

  replies: []
  reply: class
    constructor: ->
      # set values, or null, to avoid 'undefined' values in inputs
      prev     = QR.replies[QR.replies.length-1]
      persona  = $.get 'persona',
        global: {}
      unless persona[key = if Conf['Per Board Persona'] then g.BOARD else 'global']
        persona[key] = persona.global
      @name    = if prev then prev.name else persona[key].name or null
      @email   = if prev and (Conf["Remember Sage"] or !/^sage$/.test prev.email) then prev.email else persona[key].email or null
      @sub     = if prev and Conf['Remember Subject'] then prev.sub else if Conf['Remember Subject'] then persona[key].sub else null
      @spoiler = if prev and Conf['Remember Spoiler'] then prev.spoiler else false
      @com     = null

      @el = $.el 'a',
        className: 'thumbnail'
        draggable: true
        href: 'javascript:;'
        innerHTML: '<a class=remove>×</a><label hidden><input type=checkbox> Spoiler</label><span></span>'
      $('input', @el).checked = @spoiler
      $.on @el,               'click',      => @select()
      $.on $('.remove', @el), 'click',  (e) =>
        e.stopPropagation()
        @rm()
      $.on $('label',   @el), 'click',  (e) => e.stopPropagation()
      $.on $('input',   @el), 'change', (e) =>
        @spoiler = e.target.checked
        $.id('spoiler').checked = @spoiler if @el.id is 'selected'
      $.before $('#addReply', QR.el), @el

      $.on @el, 'dragstart', @dragStart
      $.on @el, 'dragenter', @dragEnter
      $.on @el, 'dragleave', @dragLeave
      $.on @el, 'dragover',  @dragOver
      $.on @el, 'dragend',   @dragEnd
      $.on @el, 'drop',      @drop

      QR.replies.push @
    setFile: (@file) ->
      @el.title = "#{file.name} (#{$.bytesToString file.size})"
      $('label', @el).hidden = false if QR.spoiler
      unless /^image/.test file.type
        @el.style.backgroundImage = null
        return
      # XXX Opera does not support window.URL
      return unless url = window.URL or window.webkitURL
      url.revokeObjectURL @url

      # Create a redimensioned thumbnail.
      fileUrl = url.createObjectURL file
      img     = $.el 'img'

      $.on img, 'load', =>
        # Generate thumbnails only if they're really big.
        # Resized pictures through canvases look like ass,
        # so we generate thumbnails `s` times bigger then expected
        # to avoid crappy resized quality.
        s = 90*3
        if img.height < s or img.width < s
          @url = fileUrl
          @el.style.backgroundImage = "url(#{@url})"
          return
        if img.height <= img.width
          img.width  = s / img.height * img.width
          img.height = s
        else
          img.height = s / img.width  * img.height
          img.width  = s
        c = $.el 'canvas'
        c.height = img.height
        c.width  = img.width
        c.getContext('2d').drawImage img, 0, 0, img.width, img.height
        # Support for toBlob fucking when?
        data = atob c.toDataURL().split(',')[1]

        # DataUrl to Binary code from Aeosynth's 4chan X repo
        l = data.length
        ui8a = new Uint8Array l
        for i in  [0...l]
          ui8a[i] = data.charCodeAt i

        @url = url.createObjectURL new Blob [ui8a], type: 'image/png'
        @el.style.backgroundImage = "url(#{@url})"
        url.revokeObjectURL? fileUrl

      img.src = fileUrl
    rmFile: ->
      QR.resetFileInput()
      delete @file
      @el.title = null
      @el.style.backgroundImage = null
      $('label', @el).hidden = true if QR.spoiler
      (window.URL or window.webkitURL).revokeObjectURL? @url
    select: ->
      QR.selected?.el.id = null
      QR.selected = @
      @el.id = 'selected'
      # Scroll the list to center the focused reply.
      rectEl   = @el.getBoundingClientRect()
      rectList = @el.parentNode.getBoundingClientRect()
      @el.parentNode.scrollLeft += rectEl.left + rectEl.width/2 - rectList.left - rectList.width/2
      # Load this reply's values.
      for data in ['name', 'email', 'sub', 'com']
        $("[name=#{data}]", QR.el).value = @[data]
      QR.characterCount.call $ 'textarea', QR.el
      $('#spoiler', QR.el).checked = @spoiler
    dragStart: ->
      $.addClass @, 'drag'
    dragEnter: ->
      $.addClass @, 'over'
    dragLeave: ->
      $.rmClass @, 'over'
    dragOver: (e) ->
      e.preventDefault()
      e.dataTransfer.dropEffect = 'move'
    drop: ->
      el    = $ '.drag', @parentNode
      index = (el) -> Array::slice.call(el.parentNode.children).indexOf el
      oldIndex = index el
      newIndex = index @
      if oldIndex < newIndex
        $.after  @, el
      else
        $.before @, el
      reply = QR.replies.splice(oldIndex, 1)[0]
      QR.replies.splice newIndex, 0, reply
    dragEnd: ->
      $.rmClass @, 'drag'
      if el = $ '.over', @parentNode
        $.rmClass el, 'over'
    rm: ->
      QR.resetFileInput()
      $.rm @el
      index = QR.replies.indexOf @
      if QR.replies.length is 1
        new QR.reply().select()
      else if @el.id is 'selected'
        (QR.replies[index-1] or QR.replies[index+1]).select()
      QR.replies.splice index, 1
      (window.URL or window.webkitURL).revokeObjectURL? @url

  captcha:
    init: ->
      return if -1 isnt d.cookie.indexOf 'pass_enabled='
      return unless @isEnabled = !!$.id 'captchaFormPart'
      if $.id 'recaptcha_challenge_field_holder'
        @ready()
      else
        @onready = => @ready()
        $.on $.id('recaptcha_widget_div'), 'DOMNodeInserted', @onready
    ready: ->
      if @challenge = $.id 'recaptcha_challenge_field_holder'
        $.off $.id('recaptcha_widget_div'), 'DOMNodeInserted', @onready
        delete @onready
      else
        return
      $.addClass QR.el, 'captcha'
      $.after $('.textarea', QR.el), $.el 'div',
        className: 'captchaimg'
        title: 'Reload'
        innerHTML: '<img>'
      $.after $('.captchaimg', QR.el), $.el 'div',
        className: 'captchainput'
        innerHTML: '<input title=Verification class=field autocomplete=off size=1>'
      @img   = $ '.captchaimg > img', QR.el
      @input = $ '.captchainput > input', QR.el
      $.on @img.parentNode, 'click',              @reload
      $.on @input,          'keydown',            @keydown
      $.on @challenge,      'DOMNodeInserted', => @load()
      $.sync 'captchas', (arr) => @count arr.length
      @count $.get('captchas', []).length
      # start with an uncached captcha
      @reload()
    addCaptcha: (challenge, response) ->
      captchas = $.get 'captchas', []
      # Remove old captchas.
      while (captcha = captchas[0]) and captcha.time < Date.now()
        captchas.shift()
      captchas.push
        challenge: challenge
        response:  response
        time:      @timeout
      $.set 'captchas', captchas
      @count captchas.length
    validateCaptcha: (challenge, response) ->
      opts =
        form: $.formData
          recaptcha_challenge_field: challenge
          recaptcha_response_field: response
      callbacks =
        onload: (data) ->
          doc = d.implementation.createHTMLDocument ''
          doc.documentElement.innerHTML = data.responseText
          if ta = $ 'textarea', doc
            key = ta.textContent
            QR.cleanError()
            QR.captcha.addCaptcha key, 'manual_challenge'
          else if $ '#recaptcha_response_field', doc
            QR.error 'Bad CAPTCHA'
          else
            $.log 'Could not understand response from CAPTCHA validator:', data.responseText
            QR.error 'Validation connection failed; adding CAPTCHA anyway'
            QR.captcha.addCaptcha challenge, response
        onerror: ->
          QR.error 'Validation connection failed; adding CAPTCHA anyway'
          QR.captcha.addCaptcha challenge, response
      $.crossAjax '//www.google.com/recaptcha/api/noscript?k=6Ldp2bsSAAAAAAJ5uyx_lx34lJeEpTLVkP5k04qc', callbacks, opts
    save: ->
      return unless response = @input.value
      challenge = @challenge.firstChild.value
      if Conf['Validate CAPTCHA']
        @validateCaptcha challenge, response
      else
        @addCaptcha challenge, response
      @reload()
    load: ->
      # Timeout is available at RecaptchaState.timeout in seconds.
      # We use 5-1 minutes to give upload some time.
      @timeout  = Date.now() + 4*$.MINUTE
      challenge = @challenge.firstChild.value
      @img.alt  = challenge
      @img.src  = "//www.google.com/recaptcha/api/image?c=#{challenge}"
      @img.onload = =>
        @img.style.visibility = 'visible'
        @input.value = null
    count: (count) ->
      @input.placeholder = switch count
        when 0
          'Verification (Shift + Enter to cache)'
        when 1
          'Verification (1 cached captcha)'
        else
          "Verification (#{count} cached captchas)"
      @input.alt = count # For XTRM RICE.
    reload: (focus) ->
      QR.captcha.input.value = null
      QR.captcha.img.style.visibility = 'hidden'
      # the "t" argument prevents the input from being focused
      $.globalEval 'javascript:Recaptcha.reload("t")'
      # Focus if we meant to.
      QR.captcha.input.focus() if focus
    keydown: (e) ->
      c = QR.captcha
      if e.keyCode is 8 and not c.input.value
        c.reload()
      else if e.keyCode is 13 and e.shiftKey
        c.save()
      else
        return
      e.preventDefault()

  dialog: ->
    QR.el = UI.dialog 'qr', 'top:0;right:0;', '
<div class=move>
  Quick Reply <input type=checkbox id=autohide title=Auto-hide>
  <span> <a class=close title=Close>×</a></span>
</div>
<form>
  <div><input id=dump type=button title="Dump list" value=+ class=field><input name=name title=Name placeholder=Name class=field size=1><input name=email title=E-mail placeholder=E-mail class=field size=1><input name=sub title=Subject placeholder=Subject class=field size=1></div>
  <div id=replies><div><a id=addReply href=javascript:; title="Add a reply">+</a></div></div>
  <div class=textarea><textarea name=com title=Comment placeholder=Comment class=field></textarea><span id=charCount></span></div>
  <div><input type=file title="Shift+Click to remove the selected file." multiple size=16><input type=submit></div>
  <label id=spoilerLabel><input type=checkbox id=spoiler> Spoiler Image</label>
  <div class=warning></div>
</form>'

    if Conf['Remember QR size'] and $.engine is 'gecko'
      $.on ta = $('textarea', QR.el), 'mouseup', ->
        $.set 'QR.size', @style.cssText
      ta.style.cssText = $.get 'QR.size', ''

    # Allow only this board's supported files.
    mimeTypes = $('ul.rules').firstElementChild.textContent.trim().match(/: (.+)/)[1].toLowerCase().replace /\w+/g, (type) ->
      switch type
        when 'jpg'
          'image/jpeg'
        when 'pdf'
          'application/pdf'
        when 'swf'
          'application/x-shockwave-flash'
        else
          "image/#{type}"
    QR.mimeTypes = mimeTypes.split ', '
    # Add empty mimeType to avoid errors with URLs selected in Window's file dialog.
    QR.mimeTypes.push ''
    fileInput        = $ 'input[type=file]', QR.el
    fileInput.max    = $('input[name=MAX_FILE_SIZE]').value
    fileInput.accept = mimeTypes if $.engine isnt 'presto' # Opera's accept attribute is fucked up

    QR.spoiler     = !!$ 'input[name=spoiler]'
    spoiler        = $ '#spoilerLabel', QR.el
    spoiler.hidden = !QR.spoiler

    QR.charaCounter = $ '#charCount', QR.el
    ta              = $ 'textarea',    QR.el

    unless g.REPLY
      # Make a list with visible threads and an option to create a new one.
      threads = '<option value=new>New thread</option>'
      for thread in $$ '.thread'
        id = thread.id[1..]
        threads += "<option value=#{id}>Thread #{id}</option>"
      QR.threadSelector =
        if g.BOARD is 'f'
          $('select[name=filetag]').cloneNode true
        else
          $.el 'select',
            innerHTML: threads
            title: 'Create a new thread / Reply to a thread'
      $.prepend $('.move > span', QR.el), QR.threadSelector
      $.on QR.threadSelector,   'mousedown', (e) -> e.stopPropagation()
    $.on $('#autohide', QR.el), 'change',    QR.toggleHide
    $.on $('.close',    QR.el), 'click',     QR.close
    $.on $('#dump',     QR.el), 'click',     -> QR.el.classList.toggle 'dump'
    $.on $('#addReply', QR.el), 'click',     -> new QR.reply().select()
    $.on $('form',      QR.el), 'submit',    QR.submit
    $.on ta,                    'input',     -> QR.selected.el.lastChild.textContent = @value
    $.on ta,                    'input',     QR.characterCount
    $.on fileInput,             'change',    QR.fileInput
    $.on fileInput,             'click',     (e) -> if e.shiftKey then QR.selected.rmFile() or e.preventDefault()
    $.on spoiler.firstChild,    'change',    -> $('input', QR.selected.el).click()
    $.on $('.warning',  QR.el), 'click',     QR.cleanError

    new QR.reply().select()
    # save selected reply's data
    for name in ['name', 'email', 'sub', 'com']
      # The input event replaces keyup, change and paste events.
      $.on $("[name=#{name}]", QR.el), 'input', ->
        QR.selected[@name] = @value
        # Disable auto-posting if you're typing in the first reply
        # during the last 5 seconds of the cooldown.
        if QR.cooldown.auto and QR.selected is QR.replies[0] and 0 < QR.cooldown.seconds <= 5
          QR.cooldown.auto = false

    QR.status.input = $ 'input[type=submit]', QR.el
    QR.status()
    QR.cooldown.init()
    QR.captcha.init()
    $.add d.body, QR.el

    # Create a custom event when the QR dialog is first initialized.
    # Use it to extend the QR's functionalities, or for XTRM RICE.
    $.event QR.el, new CustomEvent 'QRDialogCreation',
      bubbles: true

  submit: (e) ->
    e?.preventDefault()
    if QR.cooldown.seconds
      QR.cooldown.auto = !QR.cooldown.auto
      QR.status()
      return
    QR.abort()

    reply = QR.replies[0]
    if g.BOARD is 'f' and not g.REPLY
      filetag  = QR.threadSelector.value
      threadID = 'new'
    else
      threadID = g.THREAD_ID or QR.threadSelector.value

    # prevent errors
    if threadID is 'new'
      threadID = null
      if g.BOARD in ['vg', 'q'] and !reply.sub
        err = 'New threads require a subject.'
      else unless reply.file or textOnly = !!$ 'input[name=textonly]', $.id 'postForm'
        err = 'No file selected.'
      else if g.BOARD is 'f' and filetag is '9999'
        err = 'Invalid tag specified.'
    else unless reply.com or reply.file
        err = 'No file selected.'

    if QR.captcha.isEnabled and !err
      # get oldest valid captcha
      captchas = $.get 'captchas', []
      # remove old captchas
      while (captcha = captchas[0]) and captcha.time < Date.now()
        captchas.shift()
      if captcha  = captchas.shift()
        challenge = captcha.challenge
        response  = captcha.response
      else
        challenge   = QR.captcha.img.alt
        if response = QR.captcha.input.value then QR.captcha.reload()
      $.set 'captchas', captchas
      QR.captcha.count captchas.length
      unless response
        err = 'No valid captcha.'
      else
        response = response.trim()
        # one-word-captcha:
        # If there's only one word, duplicate it.
        response = "#{response} #{response}" unless /\s|_/.test response

    if err
      # stop auto-posting
      QR.cooldown.auto = false
      QR.status()
      QR.error err
      return
    QR.cleanError()

    # Enable auto-posting if we have stuff to post, disable it otherwise.
    QR.cooldown.auto = QR.replies.length > 1
    if Conf['Auto Hide QR'] and not QR.cooldown.auto
      QR.hide()
    if not QR.cooldown.auto and $.x 'ancestor::div[@id="qr"]', d.activeElement
      # Unfocus the focused element if it is one within the QR and we're not auto-posting.
      d.activeElement.blur()

    # Starting to upload might take some time.
    # Provide some feedback that we're starting to submit.
    QR.status progress: '...'

    post =
      resto:    threadID
      name:     reply.name
      email:    reply.email
      sub:      reply.sub
      com:      if Conf['Markdown'] then Markdown.format reply.com else reply.com
      upfile:   reply.file
      filetag:  filetag
      spoiler:  reply.spoiler
      textonly: textOnly
      mode:     'regist'
      pwd:      if m = d.cookie.match(/4chan_pass=([^;]+)/) then decodeURIComponent m[1] else $('input[name=pwd]').value
      recaptcha_challenge_field: challenge
      recaptcha_response_field:  response

    callbacks =
      onload: ->
        QR.response @response
      onerror: ->
        # Connection error, or
        # CORS disabled error on www.4chan.org/banned
        QR.cooldown.auto = false
        QR.status()
        QR.error $.el 'a',
          href: '//www.4chan.org/banned',
          target: '_blank',
          textContent: 'Connection error, or you are banned.'
        if Conf['Check for Bans']
          $.delete 'lastBanCheck'
          BanChecker.init()
    opts =
      form: $.formData post
      upCallbacks:
        onload: ->
          # Upload done, waiting for response.
          QR.status progress: '...'
        onprogress: (e) ->
          # Uploading...
          QR.status progress: "#{Math.round e.loaded / e.total * 100}%"

    QR.ajax = $.ajax $.id('postForm').parentNode.action, callbacks, opts

  response: (html) ->
    doc = d.implementation.createHTMLDocument ''
    doc.documentElement.innerHTML = html
    if ban  = $ '.banType', doc # banned/warning
      board = $('.board', doc).innerHTML
      err   = $.el 'span'
      if ban.textContent.toLowerCase() is 'banned'
        if Conf['Check for Bans']
          $.delete 'lastBanCheck'
          BanChecker.init()
        err.innerHTML =
          "You are banned on #{board}! ;_;<br>" +
          "Click <a href=//www.4chan.org/banned target=_blank>here</a> to see the reason."
      else
        err.innerHTML =
          "You were issued a warning on #{board} as #{$('.nameBlock', doc).innerHTML}.<br>" +
          "Reason: #{$('.reason', doc).innerHTML}"
    else if err = doc.getElementById 'errmsg' # error!
      $('a', err)?.target = '_blank' # duplicate image link
    else if doc.title isnt 'Post successful!'
      err = 'Connection error with sys.4chan.org.'

    if err
      if /captcha|verification/i.test(err.textContent) or err is 'Connection error with sys.4chan.org.'
        # Remove the obnoxious 4chan Pass ad.
        if /mistyped/i.test err.textContent
          err.textContent = 'Error: You seem to have mistyped the CAPTCHA.'
        # Enable auto-post if we have some cached captchas.
        QR.cooldown.auto =
          if QR.captcha.isEnabled
            !!$.get('captchas', []).length
          else if err is 'Connection error with sys.4chan.org.'
            true
          else
            # Something must've gone terribly wrong if you get captcha errors without captchas.
            # Don't auto-post indefinitely in that case.
            false
        # Too many frequent mistyped captchas will auto-ban you!
        # On connection error, the post most likely didn't go through.
        QR.cooldown.set delay: 2
      else # stop auto-posting
        QR.cooldown.auto = false
      QR.status()
      QR.error err
      return

    reply = QR.replies[0]

    persona = $.get 'persona',
      global: {}
    persona[key = if Conf['Per Board Persona'] then g.BOARD else 'global'] =
      name:  reply.name
      email:
        if !Conf["Remember Sage"] and /^sage$/.test reply.email
          if /^sage$/.test persona[key].email
            null
          else
            persona[key].email
        else
          reply.email
      sub:   if Conf['Remember Subject']  then reply.sub     else null
    $.set 'persona', persona

    [_, threadID, postID] = doc.body.lastChild.textContent.match /thread:(\d+),no:(\d+)/

    # Post/upload confirmed as successful.
    $.event QR.el, new CustomEvent 'QRPostSuccessful',
      bubbles: true
      detail:
        threadID: threadID
        postID:   postID

    QR.cooldown.set
      post:    reply
      isReply: threadID isnt '0'

    if threadID is '0' # new thread
      # auto-noko
      location.pathname = "/#{g.BOARD}/res/#{postID}"
    else
      # Enable auto-posting if we have stuff to post, disable it otherwise.
      QR.cooldown.auto = QR.replies.length > 1
      if Conf['Open Reply in New Tab'] and !g.REPLY and !QR.cooldown.auto
        $.open "//boards.4chan.org/#{g.BOARD}/res/#{threadID}#p#{postID}"

    if Conf['Persistent QR'] or QR.cooldown.auto
      reply.rm()
    else
      QR.close()

    QR.status()
    QR.resetFileInput()

  abort: ->
    QR.ajax?.abort()
    delete QR.ajax
    QR.status()

Options =
  init: ->
    $.ready Options.initReady
  initReady: ->
    for settings in ['navtopright', 'navbotright']
      a = $.el 'a',
        href: 'javascript:;'
        className: 'settingsWindowLink'
        textContent: '4chan X Settings'
      $.on a, 'click', Options.dialog
      setting = $.id(settings)
      if Conf['Disable 4chan\'s extension']
        $.replace setting.childNodes[1], a
        continue
      $.prepend setting, [$.tn('['), a, $.tn('] ')]
    unless $.get 'firstrun'
      $.set 'firstrun', true
      # Prevent race conditions
      Favicon.init() unless Favicon.el
      Options.dialog()

  dialog: ->
    dialog = Options.el = $.el 'div',
      id: 'options'
      className: 'reply dialog'
      innerHTML: '<div id=optionsbar>
  <div id=credits>
    <a target=_blank href=http://ihavenoface.github.com/4chan-x/>4chan X</a>
    | <a target=_blank href=https://raw.github.com/ihavenoface/4chan-x/master/changelog>' + Main.version + '</a>
    | <a target=_blank href=http://ihavenoface.github.com/4chan-x/#bug-report>Issues</a>
  </div>
  <div>
    <label for=main_tab>Main</label>
    | <label for=filter_tab>Filter</label>
    | <label for=sauces_tab>Sauce</label>
    | <label for=rice_tab>Rice</label>
    | <label for=keybinds_tab>Keybinds</label>
    | <label onclick="document.location.reload()">Refresh</label>
  </div>
</div>
<hr>
<div id=content>
  <input type=radio name=tab hidden id=main_tab checked>
  <div>
    <div class=imp-exp>
      <button class=export>Export settings</button>
      <button class=import>Import settings</button>
      <input type=file style="visibility:hidden">
    </div>
    <p class=imp-exp-result></p>
  </div>
  <input type=radio name=tab hidden id=sauces_tab>
  <div>
    <div class=warning><code>Sauce</code> is disabled.</div>
    Lines starting with a <code>#</code> will be ignored.<br>
    You can specify a certain display text by appending <code>;text:[text]</code> to the url.
    <ul>These parameters will be replaced by their corresponding values:
      <li>$1: Thumbnail url.</li>
      <li>$2: Full image url.</li>
      <li>$3: MD5 hash.</li>
      <li>$4: Current board.</li>
    </ul>
    <textarea name=sauces id=sauces class=field></textarea>
  </div>
  <input type=radio name=tab hidden id=filter_tab>
  <div>
    <div class=warning><code>Filter</code> is disabled.</div>
    <select name=filter>
      <option value=guide>Guide</option>
      <option value=name>Name</option>
      <option value=uniqueid>Unique ID</option>
      <option value=tripcode>Tripcode</option>
      <option value=mod>Admin/Mod</option>
      <option value=email>E-mail</option>
      <option value=subject>Subject</option>
      <option value=comment>Comment</option>
      <option value=country>Country</option>
      <option value=filename>Filename</option>
      <option value=dimensions>Image dimensions</option>
      <option value=filesize>Filesize</option>
      <option value=md5>Image MD5 (uses exact string matching, not regular expressions)</option>
    </select>
  </div>
  <input type=radio name=tab hidden id=rice_tab>
  <div>
    Select an Archiver for this board<br>
    <select name=archiver></select><br>
    <div class=warning><code>Quote Backlinks</code> are disabled.</div>
    <ul>
      Backlink formatting
      <li><input name=backlink class=field> : <span id=backlinkPreview></span></li>
    </ul>
    <div class=warning><code>Time Formatting</code> is disabled.</div>
    <ul>
      Time formatting
      <li><input name=time class=field> : <span id=timePreview></span></li>
      <li>Supported <a href=http://en.wikipedia.org/wiki/Date_%28Unix%29#Formatting>format specifiers</a>:</li>
      <li>Day: %a, %A, %d, %e</li>
      <li>Month: %m, %b, %B</li>
      <li>Year: %y</li>
      <li>Hour: %k, %H, %l (lowercase L), %I (uppercase i), %p, %P</li>
      <li>Minutes: %M</li>
      <li>Seconds: %S</li>
    </ul>
    <div class=warning><code>File Info Formatting</code> is disabled.</div>
    <ul>
      File Info Formatting
      <li><input name=fileInfo class=field> : <span id=fileInfoPreview class=fileText></span></li>
      <li>Link: %l (lowercase L, truncated), %L (untruncated), %t (Unix timestamp)</li>
      <li>Original file name: %n (truncated), %N (untruncated), %T (Unix timestamp)</li>
      <li>Spoiler indicator: %p</li>
      <li>Size: %B (Bytes), %K (KB), %M (MB), %s (4chan default)</li>
      <li>Resolution: %r (Displays PDF on /po/, for PDFs)</li>
    </ul>
    <ul>
      <div class=warning><code>Unread Favicon</code> is disabled.</div>
      Unread favicons<br>
      <select name=favicon>
        <option value=ferongr>ferongr</option>
        <option value=xat->xat-</option>
        <option value=Mayhem>Mayhem</option>
        <option value=Original>Original</option>
      </select>
    <span></span>
    </ul>
    <ul>
      Specify size of video embeds<br>
      Width: <input name=embedWidth type=number />px | Heigth: <input name=embedHeight type=number />px <button name=resetSize>Reset</button>
    </ul>
    <ul>
      Amounts for Optional Increase<br>
      Visible tab<br>
      <input name=updateIncrease class=field>
      <br>Background tab<br>
      <input name=updateIncreaseB class=field>
    </ul>
    <div class=warning><code>Per Board Persona</code> is disabled.</div>
    <div id=persona>
      <select name=personaboards></select>
      <ul>
        <li>
          <div class=option>
            Name:
          </div>
        </li>
        <li>
          <div class=option>
            <input name=name>
          </div>
        </li>
        <li>
          <div class=option>
            Email:
          </div>
        </li>
        <li>
          <div class=option>
            <input name=email>
          </div>
        </li>
        <li>
          <div class=option>
            Subject:
          </div>
        </li>
        <li>
          <div class=option>
            <input name=sub>
          </div>
        </li>
        <li>
          <button></button>
        </li>
      </ul>
    </div>
  </div>
  <input type=radio name=tab hidden id=keybinds_tab>
  <div>
    <div class=warning><code>Keybinds</code> are disabled.</div>
    <div>Allowed keys: Ctrl, Alt, Meta, a-z, A-Z, 0-9, Up, Down, Right, Left.</div>
    <table><tbody>
      <tr><th>Actions</th><th>Keybinds</th></tr>
    </tbody></table>
  </div>
</div>'

    $.on $('#main_tab + div .export', dialog), 'click',  Options.export
    $.on $('#main_tab + div .import', dialog), 'click',  Options.import
    $.on $('#main_tab + div input',   dialog), 'change', Options.onImport

    #main
    for key, obj of Config.main
      ul = $.el 'ul',
        textContent: key
      for key, arr of obj
        checked = if $.get(key, Conf[key]) then 'checked' else ''
        description = arr[1]
        li = $.el 'li',
          innerHTML: "<label><input type=checkbox name=\"#{key}\" #{checked}>#{key}</label><span class=description>: #{description}</span>"
        $.on $('input', li), 'click', $.cb.checked
        $.add ul, li
      $.add $('#main_tab + div', dialog), ul


    hiddenThreads = $.get "hiddenThreads/#{g.BOARD}/", {}
    hiddenNum = Object.keys(g.hiddenReplies).length + Object.keys(hiddenThreads).length
    li = $.el 'li',
      innerHTML: "<button>hidden: #{hiddenNum}</button> <span class=description>: Forget all hidden posts. Useful if you accidentally hide a post and have \"Show Stubs\" disabled."
    $.on $('button', li), 'click', Options.clearHidden
    $.add $('ul:nth-child(3)', dialog), li

    #filter
    filter = $ 'select[name=filter]', dialog
    $.on filter, 'change', Options.filter

    #archiver
    archiver = $ 'select[name=archiver]', dialog
    unless (toSelect = Redirect.select(g.BOARD))[0]
      toSelect = ['No archive available.']
    for name in toSelect
      break if archiver.length >= toSelect.length
      $.add archiver, $.el 'option',
        textContent: name
    if toSelect[1]
      archiver.value = $.get (value = "archiver/#{g.BOARD}/"), toSelect[0]
      $.on archiver, 'mouseup', ->
        if Redirect.archive[g.BOARD]
           Redirect.archive[g.BOARD] = @value
        if @value is toSelect[0]
          $.delete value
        else
          $.set value, @value

    #sauce
    sauce = $ '#sauces', dialog
    sauce.value = $.get sauce.name, Conf[sauce.name]
    $.on sauce, 'change', $.cb.value

    #rice
    (back     = $ '[name=backlink]', dialog).value = $.get 'backlink', Conf['backlink']
    (time     = $ '[name=time]',     dialog).value = $.get 'time',     Conf['time']
    (fileInfo = $ '[name=fileInfo]', dialog).value = $.get 'fileInfo', Conf['fileInfo']
    $.on back,     'input', $.cb.value
    $.on back,     'input', Options.backlink
    $.on time,     'input', $.cb.value
    $.on time,     'input', Options.time
    $.on fileInfo, 'input', $.cb.value
    $.on fileInfo, 'input', Options.fileInfo
    favicon = $ 'select[name=favicon]', dialog
    favicon.value = $.get 'favicon', Conf['favicon']
    $.on favicon, 'change', $.cb.value
    $.on favicon, 'change', Options.favicon

    (updateIncrease = $ '[name=updateIncrease]', dialog).value = $.get 'updateIncrease', Conf['updateIncrease']
    $.on updateIncrease, 'input', $.cb.value
    (updateIncreaseB = $ '[name=updateIncreaseB]', dialog).value = $.get 'updateIncreaseB', Conf['updateIncreaseB']
    $.on updateIncreaseB, 'input', $.cb.value

    (width  = $ '[name=embedWidth]',  dialog).value = $.get 'embedWidth',  Conf['embedWidth']
    (height = $ '[name=embedHeight]', dialog).value = $.get 'embedHeight', Conf['embedHeight']
    $.on width,  'input', $.cb.value
    $.on height, 'input', $.cb.value
    $.on $('[name=resetSize]', dialog), 'click', ->
      $.set 'embedWidth',  width.value  = Config.embedWidth
      $.set 'embedHeight', height.value = Config.embedHeight

    #persona
    Options.persona.select = $ '[name=personaboards]', dialog
    Options.persona.button = $ '#persona button', dialog
    Options.persona.data = $.get 'persona',
      global: {}
    unless Options.persona.data[g.BOARD]
      Options.persona.data[g.BOARD] = Options.persona.data.global
    for name of Options.persona.data
      Options.persona.select.innerHTML += "<option value=#{name}>#{name}</option>"
    Options.persona.select.value = if Conf['Per Board Persona'] then g.BOARD else 'global'
    Options.persona.init()
    $.on Options.persona.select, 'change', Options.persona.change

    #keybinds
    for key, arr of Config.hotkeys
      tr = $.el 'tr',
        innerHTML: "<td>#{arr[1]}</td><td><input name=#{key} class=field></td>"
      input = $ 'input', tr
      input.value = $.get key, Conf[key]
      $.on input, 'keydown', Options.keybind
      $.add $('#keybinds_tab + div tbody', dialog), tr

    #indicate if the settings require a feature to be enabled
    indicators = {}
    for indicator in $$ '.warning', dialog
      key = indicator.firstChild.textContent
      indicator.hidden = $.get key, Conf[key]
      indicators[key] = indicator
      $.on $("[name='#{key}']", dialog), 'click', ->
        indicators[@name].hidden = @checked

    overlay = $.el 'div', id: 'overlay'
    $.on overlay, 'click', Options.close
    $.on dialog,  'click', (e) -> e.stopPropagation()
    $.add overlay, dialog
    $.add d.body, overlay
    d.body.style.setProperty 'width', "#{d.body.clientWidth}px", null
    $.addClass d.body, 'unscroll'

    Options.filter.call   filter
    Options.backlink.call back
    Options.time.call     time
    Options.fileInfo.call fileInfo
    Options.favicon.call  favicon

  persona:
    init: ->
      key = if Conf['Per Board Persona'] then g.BOARD else 'global'
      Options.persona.newButton()
      for item in Options.persona.array
        input = $ "input[name=#{item}]", Options.el
        input.value = @data[key][item] or ""

        $.on input, 'blur input', ->
          pers = Options.persona
          pers.data[pers.select.value][@name] = @value
          $.set 'persona', pers.data

      $.on Options.persona.button, 'click', Options.persona.copy

    array: ['name', 'email', 'sub']

    change: ->
      key = @value
      Options.persona.newButton()
      for item in Options.persona.array
        input = $ "input[name=#{item}]", Options.el
        input.value = Options.persona.data[key][item]

    copy: ->
      {select, data, change} = Options.persona
      if select.value is 'global'
        data.global = data[select.value]
      else
        data[select.value] = data.global
      $.set 'persona', Options.persona.data = data
      change.call select

    newButton: ->
      Options.persona.button.textContent = "Copy from #{if Options.persona.select.value is 'global' then 'current board' else 'global'}"

  close: ->
    $.rm this
    d.body.style.removeProperty 'width'
    $.rmClass d.body, 'unscroll'

  clearHidden: ->
    #'hidden' might be misleading; it's the number of IDs we're *looking* for,
    # not the number of posts actually hidden on the page.
    $.delete "hiddenReplies/#{g.BOARD}/"
    $.delete "hiddenThreads/#{g.BOARD}/"
    @textContent = "hidden: 0"
    g.hiddenReplies = {}
  keybind: (e) ->
    return if e.keyCode is 9
    e.preventDefault()
    e.stopPropagation()
    return unless (key = Keybinds.keyCode e)?
    @value = key
    $.cb.value.call @
  filter: ->
    el = @nextSibling

    if (name = @value) isnt 'guide'
      ta = $.el 'textarea',
        name: name
        className: 'field'
        value: $.get name, Conf[name]
      $.on ta, 'change', $.cb.value
      $.replace el, ta
      return

    $.rm el if el
    $.after @, $.el 'article',
      innerHTML: '<p>Use <a href=https://developer.mozilla.org/en/JavaScript/Guide/Regular_Expressions>regular expressions</a>, one per line.<br>
  Lines starting with a <code>#</code> will be ignored.<br>
  For example, <code>/weeaboo/i</code> will filter posts containing the string `<code>weeaboo</code>`, case-insensitive.</p>
  <ul>You can use these settings with each regular expression, separate them with semicolons:
    <li>
      Per boards, separate them with commas. It is global if not specified.<br>
      For example: <code>boards:a,jp;</code>.
    </li>
    <li>
      Filter OPs only along with their threads (`only`), replies only (`no`, this is default), or both (`yes`).<br>
      For example: <code>op:only;</code>, <code>op:no;</code> or <code>op:yes;</code>.
    </li>
    <li>
      Overrule the `Show Stubs` setting if specified: create a stub (`yes`) or not (`no`).<br>
      For example: <code>stub:yes;</code> or <code>stub:no;</code>.
    </li>
    <li>
      Highlight instead of hiding. You can specify a class name to use with a userstyle.<br>
      For example: <code>highlight;</code> or <code>highlight:wallpaper;</code>.
    </li>
    <li>
      Highlighted OPs will have their threads put on top of board pages by default.<br>
      For example: <code>top:yes;</code> or <code>top:no;</code>.
    </li>
  </ul>'
  time: ->
    Time.foo()
    Time.date = new Date()
    $.id('timePreview').textContent = Time.funk Time
  backlink: ->
    $.id('backlinkPreview').textContent = Conf['backlink'].replace /%id/, '123456789'
  fileInfo: ->
    FileInfo.data =
      link:       '//images.4chan.org/g/src/1334437723720.jpg'
      spoiler:    true
      size:       '276'
      unit:       'KB'
      resolution: '1280x720'
      fullname:   'd9bb2efc98dd0df141a94399ff5880b7.jpg'
      shortname:  'd9bb2efc98dd0df141a94399ff5880(...).jpg'
    FileInfo.setFormats()
    $.id('fileInfoPreview').innerHTML = FileInfo.funk FileInfo
  favicon: ->
    Favicon.switch()
    Unread.update true
    @nextElementSibling.innerHTML = "<img src=#{Favicon.unreadSFW}> <img src=#{Favicon.unreadNSFW}> <img src=#{Favicon.unreadDead}>"

  export: ->
    now  = Date.now()
    data =
      version: Main.version
      date: now
      Conf: Conf
      WatchedThreads: $.get('watched', {})
    a = $.el 'a',
      className: 'warning'
      textContent: 'Save me!'
      download: "4chan X v#{Main.version}-#{now}.json"
      href: "data:application/json;base64,#{btoa unescape encodeURIComponent JSON.stringify data}"
      target: '_blank'
    if $.engine isnt 'gecko'
      a.click()
      return
    # XXX Firefox won't let us download automatically.
    output = @parentNode.nextElementSibling
    output.innerHTML = null
    $.add output, a
  import: ->
    @nextElementSibling.click()
  onImport: ->
    return unless file = @files[0]
    output = @parentNode.nextElementSibling
    unless confirm 'Your current settings will be entirely overwritten, are you sure?'
      output.textContent = 'Import aborted.'
      return
    reader = new FileReader()
    reader.onload = (e) ->
      try
        data = JSON.parse decodeURIComponent escape e.target.result
        Options.loadSettings data
        if confirm 'Import successful. Refresh now?'
          window.location.reload()
      catch err
        output.textContent = 'Import failed due to an error.'
    reader.readAsText file
  loadSettings: (data) ->
    for key, val of data.Conf
      $.set key, val
    $.set 'watched', data.WatchedThreads

Updater =
  init: ->
    @getInput()
    html = '<div class=move><span id=count></span> <span id=timer></span></div>'
    {checkbox} = Config.updater
    for name of checkbox
      title = checkbox[name][1]
      checked = if Conf[name] then 'checked' else ''
      html += "<div><label title='#{title}'>#{name}<input name='#{name}' type=checkbox #{checked}></label></div>"

    checked = if Conf['Auto Update'] then 'checked' else ''
    html += "
      <div><label title='Controls whether *this* thread automatically updates or not'>Auto Update This<input name='Auto Update This' type=checkbox #{checked}></label></div>
      <div><label>Interval (s)<input type=number name=Interval#{if Conf['Interval per board'] then "_#{g.BOARD}" else ''} class=field min=1></label></div>
      <div><label>BGInterval<input type=number name=BGInterval#{if Conf['Interval per board'] then "_#{g.BOARD}" else ''} class=field min=1></label></div>
      <div><input value='Update Now' type=button name='Update Now'></div>"

    dialog = UI.dialog 'updater', 'bottom: 0; right: 0;', html

    @count  = $ '#count', dialog
    @timer  = $ '#timer', dialog
    @thread = $.id "t#{g.THREAD_ID}"
    @save   = []

    @checkPostCount = 0
    @unsuccessfulFetchCount = 0
    @lastModified = '0'

    @name = if Conf['Interval per board']
      if d.hidden then "Interval_#{g.BOARD}" else "BGInterval_#{g.BOARD}"
    else
      if d.hidden then 'BGInterval' else 'Interval'

    for input in $$ 'input', dialog
      if input.type is 'checkbox'
        $.on input, 'click', $.cb.checked
      switch input.name
        when 'Scroll BG'
          $.on input, 'click', @cb.scrollBG
          @cb.scrollBG.call input
        when 'Verbose'
          $.on input, 'click', @cb.verbose
          @cb.verbose.call input
        when 'Auto Update This'
          $.on input, 'click', @cb.autoUpdate
          @cb.autoUpdate.call input
        when 'Interval', 'BGInterval', "Interval_#{g.BOARD}", "BGInterval_#{g.BOARD}"
          input.value = Conf[input.name]
          $.on input, 'change', @cb.interval
          @cb.interval.call input
        when 'Update Now'
          $.on input, 'click', @update

    $.add d.body, dialog

    $.on d, 'QRPostSuccessful', (e) ->
      Updater.cb.post()
      Updater.postID = e.detail.postID
    $.on d, 'visibilitychange', @cb.visibility

  ###
  http://freesound.org/people/pierrecartoons1979/sounds/90112/
  cc-by-nc-3.0
  ###
  audio: $.el('audio', src: 'data:audio/wav;base64,UklGRjQDAABXQVZFZm10IBAAAAABAAEAgD4AAIA+AAABAAgAc21wbDwAAABBAAADAAAAAAAAAAA8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABkYXRhzAIAAGMms8em0tleMV4zIpLVo8nhfSlcPR102Ki+5JspVEkdVtKzs+K1NEhUIT7DwKrcy0g6WygsrM2k1NpiLl0zIY/WpMrjgCdbPhxw2Kq+5Z4qUkkdU9K1s+K5NkVTITzBwqnczko3WikrqM+l1NxlLF0zIIvXpsnjgydZPhxs2ay95aIrUEkdUdC3suK8N0NUIjq+xKrcz002WioppdGm091pK1w0IIjYp8jkhydXPxxq2K295aUrTkoeTs65suK+OUFUIzi7xqrb0VA0WSoootKm0t5tKlo1H4TYqMfkiydWQBxm16+85actTEseS8y7seHAPD9TIza5yKra01QyWSson9On0d5wKVk2H4DYqcfkjidUQB1j1rG75KsvSkseScu8seDCPz1TJDW2yara1FYxWSwnm9Sn0N9zKVg2H33ZqsXkkihSQR1g1bK65K0wSEsfR8i+seDEQTxUJTOzy6rY1VowWC0mmNWoz993KVc3H3rYq8TklSlRQh1d1LS647AyR0wgRMbAsN/GRDpTJTKwzKrX1l4vVy4lldWpzt97KVY4IXbUr8LZljVPRCxhw7W3z6ZISkw1VK+4sMWvXEhSPk6buay9sm5JVkZNiLWqtrJ+TldNTnquqbCwilZXU1BwpKirrpNgWFhTaZmnpquZbFlbVmWOpaOonHZcXlljhaGhpZ1+YWBdYn2cn6GdhmdhYGN3lp2enIttY2Jjco+bnJuOdGZlZXCImJqakHpoZ2Zug5WYmZJ/bGlobX6RlpeSg3BqaW16jZSVkoZ0bGtteImSk5KIeG5tbnaFkJKRinxxbm91gY2QkIt/c3BwdH6Kj4+LgnZxcXR8iI2OjIR5c3J0e4WLjYuFe3VzdHmCioyLhn52dHR5gIiKioeAeHV1eH+GiYqHgXp2dnh9hIiJh4J8eHd4fIKHiIeDfXl4eHyBhoeHhH96eHmA')

  cb:
    post: ->
      return unless Conf['Auto Update This']
      Updater.unsuccessfulFetchCount = 0
      setTimeout Updater.update, 500
    checkpost: (status) ->
      if status isnt 404 and Updater.save.join(' ').indexOf(Updater.postID) is -1 and Updater.checkPostCount < 10
        return ( -> setTimeout Updater.update, @ ).call ++Updater.checkPostCount * 500
      Updater.save = []
      Updater.checkPostCount = 0
      delete Updater.postID
    visibility: ->
      if d.hidden
        Updater.name = if Conf['Interval per board']
          "BGInterval_#{g.BOARD}"
        else
          'BGInterval'
        return
      Updater.name = if Conf['Interval per board']
          "Interval_#{g.BOARD}"
        else
          'Interval'
      # Reset the counter when we focus this tab.
      Updater.unsuccessfulFetchCount = 0
      if Updater.timer.textContent < -Conf[Updater.name]
        Updater.set 'timer', -Updater.getInterval()
    interval: ->
      @value = parseInt @value, 10
      $.cb.value.call @
      Updater.set 'timer', -Updater.getInterval()
    verbose: ->
      if Conf['Verbose']
        Updater.set 'count', '+0'
        Updater.timer.hidden = false
      else
        Updater.set 'count', 'Thread Updater'
        Updater.count.className = ''
        Updater.timer.hidden = true
    autoUpdate: ->
      if Conf['Auto Update This'] = @checked
        Updater.timeoutID = setTimeout Updater.timeout, 1000
      else
        clearTimeout Updater.timeoutID
    scrollBG: ->
      Updater.scrollBG =
        if @checked
          -> true
        else
          -> ! d.hidden
    load: ->
      switch @status
        when 404
          $.event d, new CustomEvent 'theThreadisDead'
          Updater.set 'timer', ''
          Updater.set 'count', 404
          Updater.count.className = 'warning'
          clearTimeout Updater.timeoutID
          g.dead = true
          if Conf['Unread Count']
            Unread.title = Unread.title.match(/^.+-/)[0] + ' 404'
          else
            d.title = d.title.match(/^.+-/)[0] + ' 404'
          Unread.update true
          QR.abort()
        # XXX 304 -> 0 in Opera
        when 0, 304
          ###
          Status Code 304: Not modified
          By sending the `If-Modified-Since` header we get a proper status code, and no response.
          This saves bandwidth for both the user and the servers and avoid unnecessary computation.
          ###
          Updater.unsuccessfulFetchCount++
          Updater.set 'timer', -Updater.getInterval()
          if Conf['Verbose']
            Updater.set 'count', '+0'
            Updater.count.className = null
        when 200
          Updater.lastModified = @getResponseHeader 'Last-Modified'
          Updater.cb.update JSON.parse(@response).posts
          Updater.set 'timer', -Updater.getInterval()
        else
          Updater.unsuccessfulFetchCount++
          Updater.set 'timer', -Updater.getInterval()
          if Conf['Verbose']
            Updater.set 'count', @statusText
            Updater.count.className = 'warning'
      if Updater.postID
        Updater.cb.checkpost @status
      delete Updater.request
    update: (posts) ->
      if spoilerRange = posts[0].custom_spoiler
        Build.spoilerRange[g.BOARD] = spoilerRange

      lastPost = Updater.thread.lastElementChild
      id = +lastPost.id[2..]
      nodes = []
      for post in posts.reverse()
        break if post.no <= id # Make sure to not insert older posts.
        nodes.push Build.postFromObject post, g.BOARD
        Updater.save.push post.no if Updater.postID

      count = nodes.length
      if Conf['Verbose']
        Updater.set 'count', "+#{count}"
        Updater.count.className = if count then 'new' else null

      if count
        if Conf['Beep'] and d.hidden and (Unread.replies.length is 0)
          Updater.audio.play()
        Updater.unsuccessfulFetchCount = 0
      else
        Updater.unsuccessfulFetchCount++
        return

      scroll = Conf['Scrolling'] and Updater.scrollBG() and
        lastPost.getBoundingClientRect().bottom - d.documentElement.clientHeight < 25
      $.add Updater.thread, nodes.reverse()
      if scroll and nodes
        nodes[0].scrollIntoView()

  set: (name, text) ->
    el = Updater[name]
    if node = el.firstChild
      # Prevent the creation of a new DOM Node
      # by setting the text node's data.
      node.data = text
    else
      el.textContent = text

  getInput: ->
    for type in ['updateIncrease', 'updateIncreaseB']
      split = Conf[type].split ','
      while split.length < 10
        split.push split[split.length - 1]
      Updater[type] =
        for input in [0...10]
          input = split[input]
          parseInt input, 10
    return

  getInterval: ->
    i = +Conf[Updater.name]
    unless Conf['Dynamic Increase']
      return i
    j = Math.min @unsuccessfulFetchCount, 9
    Math.max i, (if !d.hidden then Updater.updateIncrease else Updater.updateIncreaseB)[j]

  timeout: ->
    Updater.timeoutID = setTimeout Updater.timeout, 1000
    n = 1 + Number Updater.timer.firstChild.data

    if n is 0
      Updater.update()
    else if n >= Updater.getInterval()
      Updater.unsuccessfulFetchCount++
      Updater.set 'count', 'Retry'
      Updater.count.className = null
      Updater.update()
    else
      Updater.set 'timer', n

  update: ->
    Updater.set 'timer', 0
    {request} = Updater
    if request
      # Don't reset the counter when aborting.
      request.onloadend = null
      request.abort()
    url = "//api.4chan.org/#{g.BOARD}/res/#{g.THREAD_ID}.json"
    Updater.request = $.ajax url, onloadend: Updater.cb.load,
      headers: 'If-Modified-Since': Updater.lastModified

Watcher =
  init: ->
    html = '<div class=move>Thread Watcher</div>'
    @dialog = UI.dialog 'watcher', 'top: 50px; left: 0px;', html
    $.add d.body, @dialog

    #add watch buttons
    for input in $$ '.op input'
      favicon = $.el 'img',
        className: 'favicon'
      $.on favicon, 'click', @cb.toggle
      $.before input, favicon

    if g.THREAD_ID is $.get 'autoWatch', 0
      @watch g.THREAD_ID
      $.delete 'autoWatch'
    else
      #populate watcher, display watch buttons
      @refresh()

    $.on d, 'QRPostSuccessful', @cb.post
    $.sync 'watched', @refresh

  refresh: (watched) ->
    watched or= $.get 'watched', {}
    nodes = []
    for board of watched
      for id, props of watched[board]
        x = $.el 'a',
          textContent: '×'
          href: 'javascript:;'
        $.on x, 'click', Watcher.cb.x
        link = $.el 'a', props
        link.title = link.textContent

        div = $.el 'div'
        $.add div, [x, $.tn(' '), link]
        nodes.push div

    for div in $$ 'div:not(.move)', Watcher.dialog
      $.rm div
    $.add Watcher.dialog, nodes

    watchedBoard = watched[g.BOARD] or {}
    for favicon in $$ '.favicon'
      id = favicon.nextSibling.name
      if id of watchedBoard
        favicon.src = Favicon.default
      else
        favicon.src = Favicon.empty
    return

  cb:
    toggle: ->
      Watcher.toggle @parentNode
    x: ->
      thread = @nextElementSibling.pathname.split '/'
      Watcher.unwatch thread[3], thread[1]
    post: (e) ->
      {postID, threadID} = e.detail
      if threadID is '0'
        if Conf['Auto Watch']
          $.set 'autoWatch', postID
      else if Conf['Auto Watch Reply']
        Watcher.watch threadID

  toggle: (thread) ->
    id = $('.favicon + input', thread).name
    Watcher.watch(id) or Watcher.unwatch id, g.BOARD

  unwatch: (id, board) ->
    watched = $.get 'watched', {}
    delete watched[board][id]
    $.set 'watched', watched
    Watcher.refresh()

  watch: (id) ->
    thread = $.id "t#{id}"
    return false if $('.favicon', thread).src is Favicon.default

    watched = $.get 'watched', {}
    watched[g.BOARD] or= {}
    watched[g.BOARD][id] =
      href: "/#{g.BOARD}/res/#{id}"
      textContent: Get.title thread
    $.set 'watched', watched
    Watcher.refresh()
    true

Anonymize =
  init: ->
    Main.callbacks.push @node
  node: (post) ->
    return if post.isInlined and not post.isCrosspost
    name = $ '.postInfo .name', post.el
    name.textContent = 'Anonymous'
    if (trip = name.nextElementSibling) and trip.className is 'postertrip'
      $.rm trip
    if (parent = name.parentNode).className is 'useremail' and not /^mailto:sage$/i.test parent.href
      $.replace parent, name

Sauce =
  init: ->
    return if g.BOARD is 'f'
    @links = []
    for link in Conf['sauces'].split '\n'
      continue if link[0] is '#'
      # XXX .trim() is there to fix Opera reading two different line breaks.
      @links.push @createSauceLink link.trim()
    return unless @links.length
    Main.callbacks.push @node

  createSauceLink: (link) ->
    link = link.replace /(\$\d)/g, (parameter) ->
      switch parameter
        when '$1'
          "' + (isArchived ? img.firstChild.src : 'http://thumbs.4chan.org' + img.pathname.replace(/src(\\/\\d+).+$/, 'thumb$1s.jpg')) + '"
        when '$2'
          "' + encodeURIComponent(img.href) + '"
        when '$3'
          "' + encodeURIComponent(img.firstChild.dataset.md5) + '"
        when '$4'
          g.BOARD
        else
          parameter
    domain = if m = link.match(/;text:(.+)$/) then m[1] else link.match(/(\w+)\.\w+\//)[1]
    href = link.replace /;text:.+$/, ''
    href = Function 'img', 'isArchived', "return '#{href}'"
    el = $.el 'a',
      target: '_blank'
      textContent: domain
    (img, isArchived) ->
      a = el.cloneNode true
      a.href = href img, isArchived
      a

  node: (post) ->
    {img} = post
    return if post.isInlined and not post.isCrosspost or not img
    img   = img.parentNode
    nodes = []
    for link in Sauce.links
      # \u00A0 is nbsp
      nodes.push $.tn('\u00A0'), link img, post.isArchived
    $.add post.fileInfo, nodes

RevealSpoilers =
  init: ->
    Main.callbacks.push @node
  node: (post) ->
    {img} = post
    if not (img and /^Spoiler/.test img.alt) or post.isInlined and not post.isCrosspost or post.isArchived
      return
    img.removeAttribute 'style'
    # revealed spoilers do not have height/width set, this fixes auto-gifs dimensions.
    s = img.style
    s.maxHeight = s.maxWidth = if /\bop\b/.test post.class then '250px' else '125px'
    img.src = "//thumbs.4chan.org#{img.parentNode.pathname.replace /src(\/\d+).+$/, 'thumb$1s.jpg'}"

RemoveSpoilers =
  init: ->
    Main.callbacks.push @node
  node: (post) ->
    spoilers = $$ 's', post.el
    for spoiler in spoilers
      $.replace spoiler, $.tn spoiler.textContent
    return

Time =
  init: ->
    Time.foo()
    Main.callbacks.push @node
  node: (post) ->
    return if post.isInlined and not post.isCrosspost
    node             = $ '.postInfo > .dateTime', post.el
    Time.date        = new Date node.dataset.utc * 1000
    node.textContent = Time.funk Time
  foo: ->
    code = Conf['time'].replace /%([A-Za-z])/g, (s, c) ->
      if c of Time.formatters
        "' + Time.formatters.#{c}() + '"
      else
        s
    Time.funk = Function 'Time', "return '#{code}'"
  day: [
    'Sunday'
    'Monday'
    'Tuesday'
    'Wednesday'
    'Thursday'
    'Friday'
    'Saturday'
  ]
  month: [
    'January'
    'February'
    'March'
    'April'
    'May'
    'June'
    'July'
    'August'
    'September'
    'October'
    'November'
    'December'
  ]
  zeroPad: (n) -> if n < 10 then '0' + n else n
  formatters:
    a: -> Time.day[Time.date.getDay()][...3]
    A: -> Time.day[Time.date.getDay()]
    b: -> Time.month[Time.date.getMonth()][...3]
    B: -> Time.month[Time.date.getMonth()]
    d: -> Time.zeroPad Time.date.getDate()
    e: -> Time.date.getDate()
    H: -> Time.zeroPad Time.date.getHours()
    I: -> Time.zeroPad Time.date.getHours() % 12 or 12
    k: -> Time.date.getHours()
    l: -> Time.date.getHours() % 12 or 12
    m: -> Time.zeroPad Time.date.getMonth() + 1
    M: -> Time.zeroPad Time.date.getMinutes()
    p: -> if Time.date.getHours() < 12 then 'AM' else 'PM'
    P: -> if Time.date.getHours() < 12 then 'am' else 'pm'
    S: -> Time.zeroPad Time.date.getSeconds()
    y: -> Time.date.getFullYear() - 2000

RelativeDates =
  INTERVAL: $.MINUTE
  init: ->
    Main.callbacks.push @node

    # flush when page becomes visible again
    $.on d, 'visibilitychange', @flush
  node: (post) ->
    dateEl = $ '.postInfo > .dateTime', post.el

    # Show original absolute time as tooltip so users can still know exact times
    # Since "Time Formatting" runs `node` before us, the title tooltip will
    # pick up the user-formatted time instead of 4chan time when enabled.
    dateEl.title = dateEl.textContent

    # convert data-utc to milliseconds
    utc = dateEl.dataset.utc * 1000

    diff = Date.now() - utc

    dateEl.textContent = RelativeDates.relative diff
    RelativeDates.setUpdate dateEl, utc, diff

    # Main calls @node whenever a DOM node is added (update, inline post,
    # whatever), so use also this reflow opportunity to flush any other dates
    # flush is debounced, so this won't burn too much cpu
    RelativeDates.flush()

  # diff is milliseconds from now
  relative: (diff) ->
    unit = if (number = (diff / $.DAY)) > 1
      'day'
    else if (number = (diff / $.HOUR)) > 1
      'hour'
    else if (number = (diff / $.MINUTE)) > 1
      'minute'
    else
      number = diff / $.SECOND
      'second'

    rounded = Math.round number
    unit += 's' if rounded isnt 1 # pluralize

    "#{rounded} #{unit} ago"

  # changing all relative dates as soon as possible incurs many annoying
  # redraws and scroll stuttering. Thus, sacrifice accuracy for UX/CPU economy,
  # and perform redraws when the DOM is otherwise being manipulated (and scroll
  # stuttering won't be noticed), falling back to INTERVAL while the page
  # is visible.
  #
  # each individual dateTime element will add its update() function to the stale list
  # when it to be called.
  stale: []
  flush: $.debounce($.SECOND, ->
    # no point in changing the dates until the user sees them
    return if d.hidden

    now = Date.now()
    update now for update in RelativeDates.stale
    RelativeDates.stale = []

    # reset automatic flush
    clearTimeout RelativeDates.timeout
    RelativeDates.timeout = setTimeout RelativeDates.flush, RelativeDates.INTERVAL)

  # create function `update()`, closed over dateEl and diff, that, when called
  # from `flush()`, updates the element, and re-calls `setOwnTimeout()` to
  # re-add `update()` to the stale list later.
  setUpdate: (dateEl, utc, diff) ->
    setOwnTimeout = (diff) ->
      delay = if diff < $.MINUTE
        $.SECOND - (diff + $.SECOND / 2) % $.SECOND
      else if diff < $.HOUR
        $.MINUTE - (diff + $.MINUTE / 2) % $.MINUTE
      else
        $.HOUR - (diff + $.HOUR / 2) % $.HOUR
      setTimeout markStale, delay

    update = (now) ->
      if d.contains dateEl # not removed from DOM
        diff = now - utc
        dateEl.textContent = RelativeDates.relative diff
        setOwnTimeout diff

    markStale = -> RelativeDates.stale.push update

    # kick off initial timeout with current diff
    setOwnTimeout diff

FileInfo =
  init: ->
    return if g.BOARD is 'f'
    @setFormats()
    Main.callbacks.push @node
  node: (post) ->
    return if post.isInlined and not post.isCrosspost or not post.fileInfo
    node = post.fileInfo.firstElementChild
    alt  = post.img.alt
    filename = $('span', node)?.title or node.title
    FileInfo.data =
      link:       post.img.parentNode.href
      spoiler:    /^Spoiler/.test alt
      size:       alt.match(/\d+\.?\d*/)[0]
      unit:       alt.match(/\w+$/)[0]
      resolution: node.textContent.match(/\d+x\d+|PDF/)[0]
      fullname:   filename
      shortname:  Build.shortFilename filename, post.ID is post.threadID
    # XXX GM/Scriptish
    node.setAttribute 'data-filename', filename
    node.innerHTML = FileInfo.funk FileInfo
  setFormats: ->
    code = Conf['fileInfo'].replace /%(.)/g, (s, c) ->
      if c of FileInfo.formatters
        "' + f.formatters.#{c}() + '"
      else
        s
    @funk = Function 'f', "return '#{code}'"
  convertUnit: (unitT) ->
    size  = @data.size
    unitF = @data.unit
    if unitF isnt unitT
      units = ['B', 'KB', 'MB']
      i     = units.indexOf(unitF) - units.indexOf unitT
      unitT = 'Bytes' if unitT is 'B'
      if i > 0
        size *= 1024 while i-- > 0
      else if i < 0
        size /= 1024 while i++ < 0
      if size < 1 and size.toString().length > size.toFixed(2).length
        size = size.toFixed 2
    "#{size} #{unitT}"
  formatters:
    t: -> FileInfo.data.link.match(/\d+\..+$/)[0]
    T: -> "<a href=#{FileInfo.data.link} target=_blank>#{@t()}</a>"
    l: -> "<a href=#{FileInfo.data.link} target=_blank>#{@n()}</a>"
    L: -> "<a href=#{FileInfo.data.link} target=_blank>#{@N()}</a>"
    n: ->
      if FileInfo.data.fullname is FileInfo.data.shortname
        FileInfo.data.fullname
      else
        "<span class=fntrunc>#{FileInfo.data.shortname}</span><span class=fnfull>#{FileInfo.data.fullname}</span>"
    N: -> FileInfo.data.fullname
    p: -> if FileInfo.data.spoiler then 'Spoiler, ' else ''
    s: -> "#{FileInfo.data.size} #{FileInfo.data.unit}"
    B: -> FileInfo.convertUnit 'B'
    K: -> FileInfo.convertUnit 'KB'
    M: -> FileInfo.convertUnit 'MB'
    r: -> FileInfo.data.resolution

Get =
  post: (board, threadID, postID, root, cb) ->
    if board is g.BOARD and post = $.id "pc#{postID}"
      $.add root, Get.cleanPost post.cloneNode true
      return

    root.textContent = "Loading post No.#{postID}..."
    if threadID
      $.cache "//api.4chan.org/#{board}/res/#{threadID}.json", ->
        Get.parsePost @, board, threadID, postID, root, cb
    else if url = Redirect.post board, postID
      $.cache url, ->
        Get.parseArchivedPost @, board, postID, root, cb
  parsePost: (req, board, threadID, postID, root, cb) ->
    {status} = req
    if status isnt 200
      # The thread can die by the time we check a quote.
      if url = Redirect.post board, postID
        $.cache url, ->
          Get.parseArchivedPost @, board, postID, root, cb
      else
        $.addClass root, 'warning'
        root.textContent =
          if status is 404
            "Thread No.#{threadID} 404'd."
          else
            "Error #{req.status}: #{req.statusText}."
      return

    posts = JSON.parse(req.response).posts
    if spoilerRange = posts[0].custom_spoiler
      Build.spoilerRange[board] = spoilerRange
    postID = +postID
    for post in posts
      break if post.no is postID # we found it!
      if post.no > postID
        # The post can be deleted by the time we check a quote.
        if url = Redirect.post board, postID
          $.cache url, ->
            Get.parseArchivedPost @, board, postID, root, cb
        else
          $.addClass root, 'warning'
          root.textContent = "Post No.#{postID} was not found."
        return

    $.replace root.firstChild, Get.cleanPost Build.postFromObject post, board
    cb() if cb
  parseArchivedPost: (req, board, postID, root, cb) ->
    data = JSON.parse req.response
    if data.error
      $.addClass root, 'warning'
      root.textContent = data.error
      return

    # convert comment to html
    bq = $.el 'blockquote', textContent: data.comment # set this first to convert text to HTML entities
    # https://github.com/eksopl/fuuka/blob/master/Board/Yotsuba.pm#L415-L459
    # https://github.com/eksopl/asagi/blob/master/src/main/java/net/easymodo/asagi/Yotsuba.java#L113-L150
    bq.innerHTML = bq.innerHTML.replace ///
      \n
      | \[/?b\]
      | \[/?spoiler\]
      | \[/?code\]
      | \[/?moot\]
      | \[/?banned\]
      ///g, (text) ->
        switch text
          when '\n'
            '<br>'
          when '[b]'
            '<b>'
          when '[/b]'
            '</b>'
          when '[spoiler]'
            '<s>'
          when '[/spoiler]'
            '</s>'
          when '[code]'
            '<pre class=prettyprint>'
          when '[/code]'
            '</pre>'
          when '[moot]'
            '<div style="padding:5px;margin-left:.5em;border-color:#faa;border:2px dashed rgba(255,0,0,.1);border-radius:2px">'
          when '[/moot]'
            '</div>'
          when '[banned]'
            '<b style="color: red;">'
          when '[/banned]'
            '</b>'
    # greentext
    comment = bq.innerHTML.replace /(^|>)(&gt;[^<$]*)(<|$)/g, '$1<span class=quote>$2</span>$3'
    # quotes
    comment = comment.replace /((&gt;){2}(&gt;\/[a-z\d]+\/)?\d+)/g, '<span class=deadlink>$1</span>'

    o =
      # id
      postID:   postID
      threadID: data.thread_num
      board:    board
      # info
      name:     data.name_processed
      capcode:  switch data.capcode
        when 'M' then 'mod'
        when 'A' then 'admin'
        when 'D' then 'developer'
      tripcode: data.trip
      uniqueID: data.poster_hash
      email:    if data.email then encodeURI data.email else ''
      subject:  data.title_processed
      flagCode: data.poster_country
      flagName: data.poster_country_name_processed
      date:     data.fourchan_date
      dateUTC:  data.timestamp
      comment:  comment
      # file
    if data.media?.media_filename
      o.file =
        name:      data.media.media_filename_processed
        timestamp: data.media.media_orig
        url:       data.media.media_link or data.media.remote_media_link
        height:    data.media.media_h
        width:     data.media.media_w
        MD5:       data.media.media_hash
        size:      data.media.media_size
        turl:      data.media.thumb_link or "//thumbs.4chan.org/#{board}/thumb/#{data.media.preview_orig}"
        theight:   data.media.preview_h
        twidth:    data.media.preview_w
        isSpoiler: data.media.spoiler is '1'

    $.replace root.firstChild, Get.cleanPost Build.post o, true
    cb() if cb
  cleanPost: (root) ->
    post = $ '.post', root
    for child in Array::slice.call root.childNodes
      $.rm child unless child is post

    # Remove inlined posts inside of this post.
    for inline  in $$ '.inline',  post
      $.rm inline
    for inlined in $$ '.inlined', post
      $.rmClass inlined, 'inlined'

    # Don't mess with other features
    now = Date.now()
    els = $$ '[id]', root
    els.push root
    for el in els
      el.id = "#{now}_#{el.id}"

    $.rmClass root, 'forwarded'
    $.rmClass root, 'qphl' # op
    $.rmClass post, 'highlight'
    $.rmClass post, 'qphl' # reply
    root.hidden = post.hidden = false

    root
  title: (thread) ->
    op = $ '.op', thread
    el = $ '.postInfo .subject', op
    unless el.textContent
      el = $ 'blockquote', op
      unless el.textContent
        el = $ '.nameBlock', op
    span = $.el 'span', innerHTML: el.innerHTML.replace /<br>/g, ' '
    "/#{g.BOARD}/ - #{span.textContent.trim()}"

Build =
  spoilerRange: {}
  shortFilename: (filename, isOP) ->
    # FILENAME SHORTENING SCIENCE:
    # OPs have a +10 characters threshold.
    # The file extension is not taken into account.
    threshold = if isOP then 40 else 30
    if filename.length - 4 > threshold
      "#{filename[...threshold - 5]}(...).#{filename[-3..]}"
    else
      filename
  postFromObject: (data, board) ->
    o =
      # id
      postID:   data.no
      threadID: data.resto or data.no
      board:    board
      # info
      name:     data.name
      capcode:  data.capcode
      tripcode: data.trip
      uniqueID: data.id
      email:    if data.email then encodeURI data.email.replace /&quot;/g, '"' else ''
      subject:  data.sub
      flagCode: data.country
      flagName: data.country_name
      date:     data.now
      dateUTC:  data.time
      comment:  data.com
      # thread status
      isSticky: !!data.sticky
      isClosed: !!data.closed
      # file
    if data.ext or data.filedeleted
      o.file =
        name:      data.filename + data.ext
        timestamp: "#{data.tim}#{data.ext}"
        url:       "//images.4chan.org/#{board}/src/#{data.tim}#{data.ext}"
        height:    data.h
        width:     data.w
        MD5:       data.md5
        size:      data.fsize
        turl:      "//thumbs.4chan.org/#{board}/thumb/#{data.tim}s.jpg"
        theight:   data.tn_h
        twidth:    data.tn_w
        isSpoiler: !!data.spoiler
        isDeleted: !!data.filedeleted
    Build.post o
  post: (o, isArchived) ->
    ###
    This function contains code from 4chan-JS (https://github.com/4chan/4chan-JS).
    @license: https://github.com/4chan/4chan-JS/blob/master/LICENSE
    ###
    {
      postID, threadID, board
      name, capcode, tripcode, uniqueID, email, subject, flagCode, flagName, date, dateUTC
      isSticky, isClosed
      comment
      file
    } = o
    isOP = postID is threadID

    staticPath = '//static.4chan.org'

    if email
      emailStart = '<a href="mailto:' + email + '" class="useremail">'
      emailEnd   = '</a>'
    else
      emailStart = ''
      emailEnd   = ''

    subject = "<span class=subject>#{subject or ''}</span>"

    userID =
      if !capcode and uniqueID
        " <span class='posteruid id_#{uniqueID}'>(ID: " +
          "<span class=hand title='Highlight posts by this ID'>#{uniqueID}</span>)</span> "
      else
        ''

    switch capcode
      when 'admin', 'admin_highlight'
        capcodeClass = " capcodeAdmin"
        capcodeStart = " <strong class='capcode hand id_admin'" +
          "title='Highlight posts by the Administrator'>## Admin</strong>"
        capcode      = " <img src='#{staticPath}/image/adminicon.gif' " +
          "alt='This user is the 4chan Administrator.' " +
          "title='This user is the 4chan Administrator.' class=identityIcon>"
      when 'mod'
        capcodeClass = " capcodeMod"
        capcodeStart = " <strong class='capcode hand id_mod' " +
          "title='Highlight posts by Moderators'>## Mod</strong>"
        capcode      = " <img src='#{staticPath}/image/modicon.gif' " +
          "alt='This user is a 4chan Moderator.' " +
          "title='This user is a 4chan Moderator.' class=identityIcon>"
      when 'developer'
        capcodeClass = " capcodeDeveloper"
        capcodeStart = " <strong class='capcode hand id_developer' " +
          "title='Highlight posts by Developers'>## Developer</strong>"
        capcode      = " <img src='#{staticPath}/image/developericon.gif' " +
          "alt='This user is a 4chan Developer.' " +
          "title='This user is a 4chan Developer.' class=identityIcon>"
      else
        capcodeClass = ''
        capcodeStart = ''
        capcode      = ''

    flag =
      if flagCode
       " <img src='#{staticPath}/image/country/#{if board is 'pol' then 'troll/' else ''}" +
        flagCode.toLowerCase() + ".gif' alt=#{flagCode} title='#{flagName}' class=countryFlag>"
      else
        ''

    if file?.isDeleted
      fileHTML =
        if isOP
          "<div class=file id=f#{postID}><div class=fileInfo></div><span class=fileThumb>" +
              "<img src='#{staticPath}/image/filedeleted.gif' alt='File deleted.' class='fileDeleted retina'>" +
          "</span></div>"
        else
          "<div id=f#{postID} class=file><span class=fileThumb>" +
            "<img src='#{staticPath}/image/filedeleted-res.gif' alt='File deleted.' class='fileDeletedRes retina'>" +
          "</span></div>"
    else if file
      ext = file.name[-3..]
      if !file.twidth and !file.theight and ext is 'gif' # wtf ?
        file.twidth  = file.width
        file.theight = file.height

      fileSize = $.bytesToString file.size

      fileThumb = file.turl
      if file.isSpoiler
        fileSize = "Spoiler Image, #{fileSize}"
        unless isArchived
          fileThumb = '//static.4chan.org/image/spoiler'
          if spoilerRange = Build.spoilerRange[board]
            # Randomize the spoiler image.
            fileThumb += "-#{board}" + Math.floor 1 + spoilerRange * Math.random()
          fileThumb += '.png'
          file.twidth = file.theight = 100

      imgSrc = "<a class='fileThumb#{if file.isSpoiler then ' imgspoiler' else ''}' href='#{file.url}' target=_blank>" +
        "<img src='#{fileThumb}' alt='#{fileSize}' data-md5=#{file.MD5} style='width:#{file.twidth}px;height:#{file.theight}px'></a>"

      # Ha Ha filenames.
      # html -> text, translate WebKit's %22s into "s
      a = $.el 'a', innerHTML: file.name
      filename = a.textContent.replace /%22/g, '"'

      # shorten filename, get html
      a.textContent = Build.shortFilename filename
      shortFilename = a.innerHTML

      # get html
      a.textContent = filename
      filename      = a.innerHTML.replace /'/g, '&apos;'

      fileDims = if ext is 'pdf' then 'PDF' else "#{file.width}x#{file.height}"
      fileInfo = "<span class=fileText id=fT#{postID}#{if file.isSpoiler then " title='#{filename}'" else ''}>File: <a href='#{file.url}' target=_blank>#{file.timestamp}</a>" +
        "-(#{fileSize}, #{fileDims}#{
          if file.isSpoiler
            ''
          else
            ", <span title='#{filename}'>#{shortFilename}</span>"
        }" + ")</span>"

      fileHTML = "<div id=f#{postID} class=file><div class=fileInfo>#{fileInfo}</div>#{imgSrc}</div>"
    else
      fileHTML = ''

    tripcode =
      if tripcode
        " <span class=postertrip>#{tripcode}</span>"
      else
        ''

    sticky =
      if isSticky
        ' <img src=//static.4chan.org/image/sticky.gif alt=Sticky title=Sticky style="height:16px;width:16px">'
      else
        ''
    closed =
      if isClosed
        ' <img src=//static.4chan.org/image/closed.gif alt=Closed title=Closed style="height:16px;width:16px">'
      else
        ''

    container = $.el 'div',
      id: "pc#{postID}"
      className: "postContainer #{if isOP then 'op' else 'reply'}Container"
      innerHTML: \
      (if isOP then '' else "<div class=sideArrows id=sa#{postID}>&gt;&gt;</div>") +
      "<div id=p#{postID} class='post #{if isOP then 'op' else 'reply'}#{
        if capcode is 'admin_highlight'
          ' highlightPost'
        else
          ''
        }'>" +

        "<div class='postInfoM mobile' id=pim#{postID}>" +
          "<span class='nameBlock#{capcodeClass}'>" +
              "<span class=name>#{name or ''}</span>" + tripcode +
            capcodeStart + capcode + userID + flag + sticky + closed +
            "<br>#{subject}" +
          "</span><span class='dateTime postNum' data-utc=#{dateUTC}>#{date}" +
          '<br><em>' +
            "<a href=#{"/#{board}/res/#{threadID}#p#{postID}"}>No.</a>" +
            "<a href='#{
              if g.REPLY and g.THREAD_ID is threadID
                "javascript:quote(#{postID})"
              else
                "/#{board}/res/#{threadID}#q#{postID}"
              }'>#{postID}</a>" +
          '</em></span>' +
        '</div>' +

        (if isOP then fileHTML else '') +

        "<div class='postInfo desktop' id=pi#{postID}>" +
          "<input type=checkbox name=#{postID} value=delete> " +
          "#{subject} " +
          "<span class='nameBlock#{capcodeClass}'>" +
            emailStart +
              "<span class=name>#{name or ''}</span>" + tripcode +
            capcodeStart + emailEnd + capcode + userID + flag + sticky + closed +
          ' </span> ' +
          "<span class=dateTime data-utc=#{dateUTC}>#{date}</span> " +
          "<span class='postNum desktop'>" +
            "<a href=#{"/#{board}/res/#{threadID}#p#{postID}"} title='Highlight this post'>No.</a>" +
            "<a href='#{
              if g.REPLY and +g.THREAD_ID is threadID
                "javascript:quote(#{postID})"
              else
                "/#{board}/res/#{threadID}#q#{postID}"
              }' title='Quote this post'>#{postID}</a>" +
          '</span>' +
        '</div>' +

        (if isOP then '' else fileHTML) +

        "<blockquote class=postMessage id=m#{postID}>#{comment or ''}</blockquote> " +

      '</div>'

    for quote in $$ '.quotelink', container
      href = quote.getAttribute 'href'
      continue if href[0] is '/' # Cross-board quote, or board link
      quote.href = "/#{board}/res/#{href}" # Fix pathnames

    container
TitlePost =
  init: ->
    d.title = Get.title()

QuoteBacklink =
  init: ->
    format = Conf['backlink'].replace /%id/g, "' + id + '"
    @funk  = Function 'id', "return '#{format}'"
    Main.callbacks.push @node
  node: (post) ->
    return if post.isInlined
    quotes = {}
    for quote in post.quotes
      # Stop at 'Admin/Mod/Dev Replies:' on /q/
      break if quote.parentNode.parentNode.className is 'capcodeReplies'
      # Don't process >>>/b/.
      if quote.hostname is 'boards.4chan.org' and !/catalog$/.test(quote.pathname) and qid = quote.hash[2..]
        # Duplicate quotes get overwritten.
        quotes[qid] = true
    a = $.el 'a',
      href: "/#{g.BOARD}/res/#{post.threadID}#p#{post.ID}"
      className: if post.el.hidden then 'filtered backlink' else 'backlink'
      textContent: QuoteBacklink.funk post.ID
    for qid of quotes
      # Don't backlink the OP.
      continue if !(el = $.id "pi#{qid}") or !Conf['OP Backlinks'] and /\bop\b/.test el.parentNode.className
      link = a.cloneNode true
      if Conf['Quote Preview']
        $.on link, 'mouseover', QuotePreview.mouseover
      if Conf['Quote Inline'] and not (Conf['Quote Inline on index'] and g.REPLY)
        $.on link, 'click', QuoteInline.toggle
      unless container = $.id "blc#{qid}"
        container = $.el 'span',
          className: 'container'
          id: "blc#{qid}"
        $.add el, container
      $.add container, [$.tn(' '), link]
    return

QuoteInline =
  init: ->
    Main.callbacks.push @node
  node: (post) ->
    return if Conf['Quote Inline on index'] and g.REPLY
    for quote in post.quotes
      continue unless quote.hash and quote.hostname is 'boards.4chan.org' and !/catalog$/.test(quote.pathname) or /\bdeadlink\b/.test quote.className
      $.on quote, 'click', QuoteInline.toggle
    for quote in post.backlinks
      $.on quote, 'click', QuoteInline.toggle
    return
  toggle: (e) ->
    return if e.shiftKey or e.altKey or e.ctrlKey or e.metaKey or e.button isnt 0
    e.preventDefault()
    id = @dataset.id or @hash[2..]
    if /\binlined\b/.test @className
      QuoteInline.rm @, id
    else
      return if $.x "ancestor::div[contains(@id,'p#{id}')]", @
      QuoteInline.add @, id
    @classList.toggle 'inlined'

  add: (q, id) ->
    if q.host is 'boards.4chan.org'
      path     = q.pathname.split '/'
      board    = path[1]
      threadID = path[3]
      postID   = id
    else
      board    = q.dataset.board
      threadID = 0
      postID   = q.dataset.id

    el = if board is g.BOARD then $.id "p#{postID}" else false
    inline = $.el 'div',
      id: "i#{postID}"
      className: if el then 'inline' else 'inline crosspost'

    root =
      if isBacklink = /\bbacklink\b/.test q.className
        q.parentNode
      else
        $.x 'ancestor-or-self::*[parent::blockquote][1]', q
    $.after root, inline
    Get.post board, threadID, postID, inline

    return unless el

    # Will only unhide if there's no inlined backlinks of it anymore.
    if isBacklink and Conf['Forward Hiding']
      $.addClass el.parentNode, 'forwarded'
      ++el.dataset.forwarded or el.dataset.forwarded = 1

    # Decrease the unread count if this post is in the array of unread reply.
    if (i = Unread.replies.indexOf el) isnt -1
      Unread.replies.splice i, 1
      Unread.update true

    if Conf['Color user IDs'] and board in ['b', 'q', 'soc']
      setTimeout -> $.rmClass $('.reply.highlight', inline), 'highlight'

  rm: (q, id) ->
    # select the corresponding inlined quote or loading quote
    div = $.x "following::div[@id='i#{id}']", q
    $.rm div
    return unless Conf['Forward Hiding']
    for inlined in $$ '.backlink.inlined', div
      div = $.id inlined.hash[1..]
      $.rmClass div.parentNode, 'forwarded' unless --div.dataset.forwarded
    if /\bbacklink\b/.test q.className
      div = $.id "p#{id}"
      $.rmClass div.parentNode, 'forwarded' unless --div.dataset.forwarded

QuotePreview =
  init: ->
    Main.callbacks.push @node
  node: (post) ->
    for quote in post.quotes
      continue unless quote.hash and quote.hostname is 'boards.4chan.org' and !/catalog$/.test(quote.pathname) or /\bdeadlink\b/.test quote.className
      $.on quote, 'mouseover', QuotePreview.mouseover
    for quote in post.backlinks
      $.on quote, 'mouseover', QuotePreview.mouseover
    return
  mouseover: (e) ->
    return if /\binlined\b/.test @className

    # Make sure to remove the previous qp
    # in case it got stuck. Opera-only bug?
    if qp = $.id 'qp'
      if qp is UI.el
        delete UI.el
      $.rm qp

    # Don't stop other elements from dragging
    return if UI.el

    if @host is 'boards.4chan.org'
      path     = @pathname.split '/'
      board    = path[1]
      threadID = path[3]
      postID   = @hash[2..]
    else
      board    = @dataset.board
      threadID = 0
      postID   = @dataset.id

    qp = UI.el = $.el 'div',
      id: 'qp'
      className: 'reply dialog'
    UI.hover e
    $.add d.body, qp
    el = $.id "p#{postID}" if board is g.BOARD
    Get.post board, threadID, postID, qp, ->
      bq = $ 'blockquote', qp
      Main.prettify bq
      post =
        el: qp
        blockquote: bq
        isArchived: /\barchivedPost\b/.test qp.className
      if img = $ 'img[data-md5]', qp
        post.fileInfo = img.parentNode.previousElementSibling
        post.img      = img
      if Conf['Reveal Spoilers']
        RevealSpoilers.node post
      if Conf['Time Formatting']
        Time.node           post
      if Conf['File Info Formatting']
        FileInfo.node       post
      if Conf['Linkify']
        Linkify.node        post
      if Conf['Resurrect Quotes']
        Quotify.node        post
      if Conf['Anonymize']
        Anonymize.node      post
      if Conf['Replace GIF'] or Conf['Replace PNG'] or Conf['Replace JPG']
        ImageReplace.node   post
      if Conf['Color user IDs'] and board in ['b', 'q', 'soc']
        IDColor.node        post
      if Conf['RemoveSpoilers']
        RemoveSpoilers.node post

    $.on @, 'mousemove',      UI.hover
    $.on @, 'mouseout click', QuotePreview.mouseout

    return unless el
    if Conf['Indicate Quotes of You'] and /\byourPost\b/.test el.className
      $.rmClass (yourPost = $('.reply.yourPost', qp)), 'yourPost'
      $.addClass qp, 'yourPost'

    if Conf['Quote Highlighting']
      if /\bop\b/.test el.className
        $.addClass el.parentNode, 'qphl'
      else
        $.addClass el, 'qphl'
    quoterID = $.x('ancestor::*[@id][1]', @).id.match(/\d+$/)[0]
    for quote in $$ '.quotelink, .backlink', qp
      if quote.hash[2..] is quoterID
        $.addClass quote, 'forwardlink'
    return
  mouseout: (e) ->
    UI.hoverend()
    if el = $.id @hash[1..]
      $.rmClass el,            'qphl' # reply
      $.rmClass el.parentNode, 'qphl' # op
    $.off @, 'mousemove',      UI.hover
    $.off @, 'mouseout click', QuotePreview.mouseout

QuoteYou =
  init: ->
    $.on d, 'QRPostSuccessful', @post
    $.on d, 'theThreadisDead',  @prune

    @posts = $.get 'yourPosts', {}
    Main.callbacks.push @node

  post: (e) ->
    {postID, threadID} = e.detail
    return if threadID is '0'
    unless posts = QuoteYou.posts[threadID]
      posts = []
    posts.push postID
    QuoteYou.posts[threadID] = posts
    $.set 'yourPosts', QuoteYou.posts

  node: (post) ->
    {posts} = QuoteYou
    posts   = posts[post.threadID]
    return if not posts or post.isInlined and not post.isCrosspost
    if post.ID in posts
      $.addClass post.el, 'yourPost'
    for quote in post.quotes
      if quote.hash[2..] in posts
        $.add quote, $.tn '\u00A0(You)'
    return

  prune: ->
    return unless (posts = QuoteYou.posts)[g.THREAD_ID]
    delete posts[g.THREAD_ID]
    $.set 'yourPosts', posts

QuoteOP =
  init: ->
    Main.callbacks.push @node
  node: (post) ->
    return if post.isInlined and not post.isCrosspost
    for quote in post.quotes
      if quote.hash[2..] is post.threadID
        # \u00A0 is nbsp
        $.add quote, $.tn '\u00A0(OP)'
    return

QuoteCT =
  init: ->
    Main.callbacks.push @node
  node: (post) ->
    return if post.isInlined and not post.isCrosspost
    for quote in post.quotes
      unless quote.hash and quote.hostname is 'boards.4chan.org' and !/catalog$/.test quote.pathname
        # Make sure this isn't a link to the board we're on.
        continue
      path = quote.pathname.split '/'
      # If quote leads to a different thread id and is located on the same board.
      if path[1] is g.BOARD and path[3] isnt post.threadID
        # \u00A0 is nbsp
        $.add quote, $.tn '\u00A0(Cross-thread)'
    return

IDColor =
  init: ->
    return unless g.BOARD in ['b', 'q', 'soc']
    Main.callbacks.push @node

  node: (post) ->
    return unless uid = post.el.getElementsByClassName('hand')[1]
    str = uid.textContent
    if uid.nodeName is 'SPAN'
      uid.style.cssText = IDColor.apply.call str

    unless IDColor.highlight[str]
      IDColor.highlight[str] = []
    if str is $.get "highlightedID/#{g.BOARD}/"
      $.addClass post.el, 'highlight'
      IDColor.highlight.current.push post

    IDColor.highlight[str].push post
    $.on uid, 'click', -> IDColor.idClick str

  ids: {}
  compute: (str) ->
    rgb = []
    hash = @hash str

    rgb[0] = (hash >> 24) & 0xFF
    rgb[1] = (hash >> 16) & 0xFF
    rgb[2] = (hash >> 8)  & 0xFF
    rgb[3] = ((rgb[0] * 0.299) + (rgb[1] * 0.587) + (rgb[2] * 0.114)) > 125

    @ids[str] = rgb
    rgb

  apply: ->
    rgb = IDColor.ids[@] or IDColor.compute @
    "background-color: rgb(#{rgb[0]},#{rgb[1]},#{rgb[2]}); color: " + if rgb[3] then "black;" else "white;"

  hash: (str) ->
    msg = 0
    i = 0
    j = str.length
    while i < j
      msg = ((msg << 5) - msg) + str.charCodeAt i
      ++i
    msg

  highlight:
    current: []

  idClick: (str) ->
    for post in @highlight.current
      $.rmClass post.el, 'highlight'
    last = $.get value = "highlightedID/#{g.BOARD}/", false
    if str is last
      @highlight.current = []
      return $.delete value

    for post in @highlight[str]
      continue if post.isInlined
      $.addClass post.el, 'highlight'
      @highlight.current.push post
    $.set value, str

Linkify =
  init: ->
    Main.callbacks.push @node

  regString:
    ///(((magnet|mailto)\:|(news|(ht|f)tp(s?))\://){1}\S+)///gi

  node: (post) ->
    return if post.isInlined and not post.isCrosspost # Will be repaired later.
    for wbr in $$ 'wbr', post.blockquote
      prev = wbr.previousSibling
      next = wbr.nextSibling
      continue unless (prev and next)? and prev.data and next.data and prev.data.match Linkify.regString
      $.replace prev, $.tn [prev.data + next.data]
      $.rm next
      $.rm wbr

    snapshot = d.evaluate './/text()', post.blockquote, null, 6, null

    for i in [0...snapshot.snapshotLength]
      node = snapshot.snapshotItem i
      data = node.data
      unless links = data.match Linkify.regString
        # Only accept nodes with potentially valid links
        continue

      nodes = []

      for link in links
        index   = data.indexOf link
        if text = data[...index]
          # Potential text before this valid link.
          nodes.push $.tn text
        a = $.el 'a',
          textContent: link
          rel:         'nofollow noreferrer'
          target:      '_blank'
          href:        if link.indexOf(':') < 0 then (if link.indexOf('@') > 0 then 'mailto:' + link else 'http://' + link) else link
        nodes.push a
        data = data[index + link.length..]

      if data
        # Potential text after the last valid link.
        nodes.push $.tn data
      $.replace node, nodes

      $.on a, 'click', Linkify.concat

      continue unless Conf['Embed']

      if linked = Linkify.linked[a.href]
        if linked.title
          if Conf['Show FavIcons']
            a.className   = "#{linked.service.low}Title"
            a.textContent = linked.title
          else
            a.textContent = "[#{linked.service.low}] #{linked.title}"
        Linkify.createToggle a, post.ID
      else
        for key, type of Linkify.types
          unless match = a.href.match type.regExp
            continue
          service =
            low:   key
            name:  key.charAt(0).toUpperCase() + key[1..]
            type:  type
          break
        continue if match is null or not service
        link =
          name:    match[1]
          href:    a.href
          service: service
          posts:   {}
        Linkify.linked[a.href] = link
        Linkify.createToggle a, post.ID
    return

  linked: {}

  createToggle: (node, postID) ->
    embed = $.el 'span',
      innerHTML: '[<a href=javascript:; class=embed>embed</a>]'
    unembed = $.el 'span',
      innerHTML: '[<a href=javascript:; class=unembed>unembed</a>]'

    {href} = node
    $.on embed, 'click', -> Linkify.embed href, postID
    $.after node, [$.tn ' '; embed]
    Linkify.linked[href].posts[postID] = {node, embed, unembed}
    link = Linkify.linked[href]

    if not link.title and Conf[link.service.name] and link.service.type.title
      unless (titles = $.get 'CachedTitles', {})[service = link.service.low]
        titles[service] = {}
        $.set 'CachedTitles', titles

      if cached = Linkify.linked[href].title = titles[service][link.name]
        if Conf['Show FavIcons']
          node.className = "#{service}Title"
          return node.textContent =  cached
        node.textContent = "[#{service}] #{cached}"

      link.service.type.title.call
        node:    node
        name:    link.name
        service: service

  embed: (href, postID) ->
    if typeof href is 'string'
      link = Linkify.linked[href]
      span = link.posts[postID]
      if span.el
        $.rm span.embed
        return $.replace span.node, [span.el, $.tn ' '; span.unembed]
      return unless el = link.service.type.el link, postID
      if (type = link.service.type).style
        for key, value of type.style
          el.style[key]  = value
      else
        el.style.cssText = "border: 0; width: #{$.get 'embedWidth', Config.embedWidth}px; height: #{$.get 'embedHeight', Config.embedHeight}px"
    else # Got callback and something to embed.
      {el, href, postID} = href
      link = Linkify.linked[href]
      span = link.posts[postID]
    Linkify.linked[href].posts[postID].el = el
    $.on span.unembed, 'click', -> Linkify.unembed span
    $.rm span.embed
    $.replace span.node, [span.el, $.tn ' '; span.unembed]

  unembed: (span) ->
    $.rm span.unembed
    $.replace span.el, [span.node, $.tn ' '; span.embed]

  json: (info) ->
    $.cache info.url, ->
      try
        info.status = @status
        info.txt    = @responseText
        Linkify.save info
      catch err

  save: (info) ->
    {node, service, status} = info
    titles = $.get 'CachedTitles', {}
    i = 2000
    while saved = Object.keys(titles[service])[++i]
      delete titles[service][saved]
    node.className   = "#{service}Title" if Conf['Show FavIcons']
    node.textContent = titles[service][info.name] = switch status
      when 200, 304
        Linkify.types[service].text.call info.txt
      when 400, 404
        "Not Found"
      when 403
        "Forbidden or Private"
      else
        "#{status}'d"
    unless Conf['Show FavIcons']
      node.textContent = "[#{service}] #{node.textContent}"
    $.set 'CachedTitles', titles

  types:
    youtube:
      regExp:  /.*(?:youtu.be\/|youtube.*v=|youtube.*\/embed\/|youtube.*\/v\/|youtube.*videos\/)([^#\&\?]*).*/
      el: (link) ->
        $.el 'iframe', src: "//www.youtube.com/embed/#{link.name}"
      title: ->
        @url = "https://gdata.youtube.com/feeds/api/videos/#{@name}?alt=json&fields=title/text(),yt:noembed,app:control/yt:state/@reasonCode"
        Linkify.json @
      text: -> JSON.parse(@).entry.title.$t

    vimeo:
      regExp:  /.*(?:vimeo.com\/)([^#\&\?]*).*/
      el: (link) ->
        $.el 'iframe', src: "//player.vimeo.com/video/#{link.name}"
      title: ->
        @url = "https://vimeo.com/api/oembed.json?url=http://vimeo.com/#{@name}"
        Linkify.json @
      text: -> JSON.parse(@).title

    liveleak:
      regExp:  /.*(?:liveleak.com\/view.+i=)([0-9a-z_]+)/
      el: (link) ->
        $.el 'iframe', src: "http://www.liveleak.com/e/#{link.name}?autostart=true"

    vocaroo:
      regExp:  /.*(?:vocaroo.com\/i\/)([^#\&\?]*).*/
      style:
        border: '0'
        width:  '150px'
        height: '45px'
      el: (link) ->
        $.el 'iframe', src: "http://vocaroo.com/player.swf?playMediaID=#{link.name}&autoplay=0"

    soundcloud:
      regExp:  /.*(?:soundcloud.com\/|snd.sc\/)([^#\&\?]*).*/
      url:     "//soundcloud.com/oembed?show_artwork=false&&maxwidth=500px&show_comments=false&format=json&url="
      el: (link, postID) ->
        {href} = link
        $.cache Linkify.types.soundcloud.url + href, ->
          response =
            el:
              $.el 'div',
                innerHTML: JSON.parse(@responseText).html
            href:   href
            postID: postID
          Linkify.embed response
        false
      title: ->
        @url = Linkify.types.soundcloud.url + @node.href
        Linkify.json @
      text: -> JSON.parse(@).title

    audio:
      regExp:  /(.*\.(mp3|ogg|wav))$/
      style:
        width:  '400px'
        heigth: '30px'
      el: (link) ->
        $.el 'audio',
          controls:    'controls'
          preload:     'auto'
          src:         link.href
          textContent: 'You should get a better browser.'

Quotify =
  init: ->
    Main.callbacks.push @node
  node: (post) ->
    return if post.isInlined and not post.isCrosspost
    for deadlink in $$ '.deadlink', post.blockquote

      if deadlink.parentNode.className is 'prettyprint'
        $.replace deadlink, Array::slice.call deadlink.childNodes
        continue

      quote = deadlink.textContent

      a = $.el 'a',
        # \u00A0 is nbsp
        textContent: "#{quote}\u00A0(Dead)"

      continue unless id = quote.match(/\d+$/)?[0]

      if m = quote.match /^>>>\/([a-z\d]+)/
        board = m[1]
      else if postBoard
        board = postBoard
      else
        # Get the post's board, whether it's inlined or not.
        board = postBoard = $('a[title="Highlight this post"]', post.el).pathname.split('/')[1]

      if board is g.BOARD and $.id "p#{id}"
        a.href      = "#p#{id}"
        a.className = 'quotelink'
      else
        a.href =
          Redirect.to
            board:    board
            threadID: 0
            postID:   id
        a.className = 'deadlink'
        a.target    = '_blank'
        if Redirect.post board, id
          $.addClass a, 'quotelink'
          # XXX WTF Scriptish/Greasemonkey?
          # Setting dataset attributes that way doesn't affect the HTML,
          # but are, I suspect, kept as object key/value pairs and GC'd later.
          # a.dataset.board = board
          # a.dataset.id    = id
          a.setAttribute 'data-board', board
          a.setAttribute 'data-id',    id
      $.replace deadlink, a
    return

DeleteLink =
  init: ->
    div = $.el 'div',
      className: 'delete_link'
      textContent: 'Delete'
    aPost = $.el 'a',
      className: 'delete_post'
      href: 'javascript:;'
    aImage = $.el 'a',
      className: 'delete_image'
      href: 'javascript:;'

    children = []

    children.push
      el: aPost
      open: ->
        aPost.textContent = 'Post'
        $.on aPost, 'click', DeleteLink.delete
        true

    children.push
      el: aImage
      open: (post) ->
        return false unless post.img
        aImage.textContent = 'Image'
        $.on aImage, 'click', DeleteLink.delete
        true

    Menu.addEntry
      el: div
      open: (post) ->
        if post.isArchived
          return false
        node = div.firstChild
        if seconds = DeleteLink.cooldown[post.ID]
          node.textContent = "Delete (#{seconds})"
          DeleteLink.cooldown.el = node
        else
          node.textContent = 'Delete'
          delete DeleteLink.cooldown.el
        true
      children: children

    $.on d, 'QRPostSuccessful', @cooldown.start

  delete: ->
    menu = $.id 'menu'
    {id} = menu.dataset

    if DeleteLink.cooldown[id]
      @textContent = 'Waiting for cooldown...'
      return DeleteLink.cooldown.delete = true

    $.off @, 'click', DeleteLink.delete
    @textContent = 'Deleting...'

    pwd =
      if m = d.cookie.match /4chan_pass=([^;]+)/
        decodeURIComponent m[1]
      else
        $.id('delPassword').value

    board = $('a[title="Highlight this post"]',
      $.id menu.dataset.rootid).pathname.split('/')[1]
    self = @

    form =
      mode: 'usrdel'
      onlyimgdel: /\bdelete_image\b/.test @className
      pwd: pwd
    form[id] = 'delete'

    $.ajax $.id('delform').action.replace("/#{g.BOARD}/", "/#{board}/"), {
        onload:  -> DeleteLink.load  self, @response
        onerror: -> DeleteLink.error self
      }, {
        form: $.formData form
      }
  load: (self, html) ->
    doc = d.implementation.createHTMLDocument ''
    doc.documentElement.innerHTML = html
    if doc.title is '4chan - Banned' # Ban/warn check
      s = 'Banned!'
    else if msg = doc.getElementById 'errmsg' # error!
      s = msg.textContent
      $.on self, 'click', DeleteLink.delete
    else
      s = 'Deleted'
    self.textContent = s
  error: (self) ->
    self.textContent = 'Connection error, please retry.'
    $.on self, 'click', DeleteLink.delete

  cooldown:
    start: (e) ->
      seconds =
        if g.BOARD is 'q'
          600
        else
          30
      DeleteLink.cooldown.count e.detail.postID, seconds, seconds
    count: (postID, seconds, length) ->
      return unless 0 <= seconds <= length
      setTimeout DeleteLink.cooldown.count, 1000, postID, seconds-1, length
      {el} = DeleteLink.cooldown
      if seconds is 0
        el?.textContent = 'Delete'
        delete DeleteLink.cooldown[postID]
        delete DeleteLink.cooldown.el
        if DeleteLink.cooldown.delete
          DeleteLink.cooldown.delete = false
          $.event el?.nextSibling.firstChild, new Event 'click'
        return
      el?.textContent = "Delete (#{seconds})"
      DeleteLink.cooldown[postID] = seconds

ReportLink =
  init: ->
    a = $.el 'a',
      className: 'report_link'
      href: 'javascript:;'
      textContent: 'Report this post'
    $.on a, 'click', @report
    Menu.addEntry
      el: a
      open: (post) ->
        post.isArchived is false
  report: ->
    a   = $ 'a[title="Highlight this post"]', $.id @parentNode.dataset.rootid
    url = "//sys.4chan.org/#{a.pathname.split('/')[1]}/imgboard.php?mode=report&no=#{@parentNode.dataset.id}"
    id  = Date.now()
    set = "toolbar=0,scrollbars=0,location=0,status=1,menubar=0,resizable=1,width=685,height=200"
    window.open url, id, set

DownloadLink =
  init: ->
    # Test for download feature support.
    return if $.el('a').download is undefined
    a = $.el 'a',
      className: 'download_link'
      textContent: 'Download file'
    Menu.addEntry
      el: a
      open: (post) ->
        unless post.img
          return false
        a.href     = post.img.parentNode.href
        fileText   = post.fileInfo.firstElementChild
        a.download =
          if Conf['File Info Formatting']
            fileText.dataset.filename
          else
            $('span', fileText).title
        true

ArchiveLink =
  init: ->
    div = $.el 'div',
      textContent: 'Archive'

    entry =
      el: div
      open: (post) ->
        path = $('a[title="Highlight this post"]', post.el).pathname.split '/'
        if (Redirect.to {board: path[1], threadID: path[3], postID: post.ID}) is "//boards.4chan.org/#{path[1]}/"
          return false
        post.info = [path[1], path[3]]
        true
      children: []

    for type in [
      ['Post',      'apost']
      ['Name',      'name']
      ['Tripcode',  'tripcode']
      ['E-mail',    'email']
      ['Subject',   'subject']
      ['Filename',  'filename']
      ['Image MD5', 'md5']
    ]
      # Add a sub entry for each type.
      entry.children.push @createSubEntry type[0], type[1]

    Menu.addEntry entry

  createSubEntry: (text, type) ->

    el = $.el 'a',
      textContent: text
      target: '_blank'

    open = (post) ->
      if type is 'apost'
        el.href =
          Redirect.to
            board:    post.info[0]
            threadID: post.info[1]
            postID:   post.ID
        return true
      value = Filter[type] post
      # We want to parse the exact same stuff as Filter does already.
      return false unless value
      el.href =
        Redirect.to
          board:    post.info[0]
          type:     type
          value:    value
          isSearch: true

    return el: el, open: open

EmbedLink =
  init: ->
    return # Will be repaired later.
    a = $.el 'a',
      className: 'embed_link'
      textContent: 'Embed all in post'

    Menu.addEntry
      el: a
      open: (post) ->
        if $$('a.embed', post.blockquote).length > 0
          $.on @el, 'click', @toggle
          return true
        if $ 'a.unembed', post.blockquote
          @el.textContent = 'Unembed all in post'
          $.on @el, 'click', @toggle
          return true
        false

      toggle: ->
        blockquote = $.id "m#{@parentNode.getAttribute 'data-id'}"
        if (toggle = $$ 'a.embed', blockquote).length is 0
          @textContent = 'Embed all in post'
          toggle = $$ 'a.unembed', blockquote
        else
          @textContent = 'Unembed all in post'
        for link in toggle
          $.event link, new Event 'click'
        return

ThreadStats =
  init: ->
    dialog = UI.dialog 'stats', 'bottom: 0; left: 0;', '<div class=move><span id=postcount>0</span> / <span id=imagecount>0</span></div>'
    dialog.className = 'dialog'
    $.add d.body, dialog
    @posts = @images = 0
    @imgLimit =
      switch g.BOARD
        when 'a', 'b', 'v', 'co', 'mlp'
          251
        when 'vg'
          376
        else
          151
    Main.callbacks.push @node
  node: (post) ->
    return if post.isInlined
    $.id('postcount').textContent = ++ThreadStats.posts
    return unless post.img
    imgcount = $.id 'imagecount'
    imgcount.textContent = ++ThreadStats.images
    if ThreadStats.images > ThreadStats.imgLimit
      $.addClass imgcount, 'warning'

Unread =
  init: ->
    @title = d.title
    $.on d, 'QRPostSuccessful', @post
    @update()
    $.on window, 'scroll focus', Unread.scroll
    Main.callbacks.push @node

  replies: []
  foresee: []

  post: (e) ->
    Unread.foresee.push e.detail.postID

  node: (post) ->
    if (index = Unread.foresee.indexOf post.ID) isnt -1
      Unread.foresee.splice index, 1
      return
    {el} = post
    return if el.hidden or /\bop\b/.test(post.class) or post.isInlined
    count = Unread.replies.push el
    Unread.update count is 1

  scroll: ->
    height = d.documentElement.clientHeight
    for reply, i in Unread.replies
      {bottom} = reply.getBoundingClientRect()
      if bottom > height #post is not completely read
        break
    return if i is 0

    Unread.replies = Unread.replies[i..]
    Unread.update Unread.replies.length is 0

  setTitle: (count) ->
    if @scheduled
      clearTimeout @scheduled
      delete Unread.scheduled
      @setTitle count
      return
    @scheduled = setTimeout (->
      d.title = "(#{count}) #{Unread.title}"
    ), 5

  update: (updateFavicon) ->
    return unless g.REPLY

    count = @replies.length

    if Conf['Unread Count']
      @setTitle count

    unless Conf['Unread Favicon'] and updateFavicon
      return

    if $.engine is 'presto'
      $.rm Favicon.el

    Favicon.el.href =
      if g.dead
        if count
          Favicon.unreadDead
        else
          Favicon.dead
      else
        if count
          Favicon.unread
        else
          Favicon.default

    if g.dead
      $.addClass    Favicon.el, 'dead'
    else
      $.rmClass Favicon.el, 'dead'
    if count
      $.addClass    Favicon.el, 'unread'
    else
      $.rmClass Favicon.el, 'unread'

    # `favicon.href = href` doesn't work on Firefox
    # `favicon.href = href` isn't enough on Opera
    # Opera won't always update the favicon if the href didn't change
    unless $.engine is 'webkit'
      $.add d.head, Favicon.el

Favicon =
  init: ->
    return if @el # Prevent race condition with options first run
    @el = $ 'link[rel="shortcut icon"]', d.head
    @el.type = 'image/x-icon'
    {href} = @el
    @SFW = /ws.ico$/.test href
    @default = href
    @switch()

  switch: ->
    switch Conf['favicon']
      when 'ferongr'
        @unreadDead = 'data:image/gif;base64,R0lGODlhEAAQAOMHAOgLAnMFAL8AAOgLAukMA/+AgP+rq////////////////////////////////////yH5BAEKAAcALAAAAAAQABAAAARZ8MhJ6xwDWIBv+AM1fEEIBIVRlNKYrtpIECuGzuwpCLg974EYiXUYkUItjGbC6VQ4omXFiKROA6qSy0A8nAo9GS3YCswIWnOvLAi0be23Z1QtdSUaqXcviQAAOw=='
        @unreadSFW  = 'data:image/gif;base64,R0lGODlhEAAQAOMHAADX8QBwfgC2zADX8QDY8nnl8qLp8v///////////////////////////////////yH5BAEKAAcALAAAAAAQABAAAARZ8MhJ6xwDWIBv+AM1fEEIBIVRlNKYrtpIECuGzuwpCLg974EYiXUYkUItjGbC6VQ4omXFiKROA6qSy0A8nAo9GS3YCswIWnOvLAi0be23Z1QtdSUaqXcviQAAOw=='
        @unreadNSFW = 'data:image/gif;base64,R0lGODlhEAAQAOMHAFT+ACh5AEncAFT+AFX/Acz/su7/5v///////////////////////////////////yH5BAEKAAcALAAAAAAQABAAAARZ8MhJ6xwDWIBv+AM1fEEIBIVRlNKYrtpIECuGzuwpCLg974EYiXUYkUItjGbC6VQ4omXFiKROA6qSy0A8nAo9GS3YCswIWnOvLAi0be23Z1QtdSUaqXcviQAAOw=='
      when 'xat-'
        @unreadDead = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA2ElEQVQ4y61TQQrCMBDMQ8WDIEV6LbT2A4og2Hq0veo7fIAH04dY9N4xmyYlpGmI2MCQTWYy3Wy2DAD7B2wWAzWgcTgVeZKlZRxHNYFi2jM18oBh0IcKtC6ixf22WT4IFLs0owxswXu9egm0Ls6bwfCFfNsJYJKfqoEkd3vgUgFVLWObtzNgVKyruC+ljSzr5OEnBzjvjcQecaQhbZgBb4CmGQw+PoMkTUtdbd8VSEPakcGxPOcsoIgUKy0LecY29BmdBrqRfjIwZ93KLs5loHvBnL3cLH/jF+C/+z5dgUysAAAAAElFTkSuQmCC'
        @unreadSFW  = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA30lEQVQ4y2P4//8/AyWYgSoGQMF/GJ7Y11VVUVoyKTM9ey4Ig9ggMWQ1YA1IBvzXm34YjkH8mPyJB+Nqlp8FYRAbmxoMF6ArSNrw6T0Qf8Amh9cFMEWVR/7/A+L/uORxhgEIt5/+/3/2lf//5wAxiI0uj+4CBlBgxVUvOwtydgXQZpDmi2/+/7/0GmIQSAwkB1IDUkuUAZeABlx+g2zAZ9wGlAOjChba+LwAUgNSi2HA5Am9VciBhSsQQWyoWgZiovEDsdGI1QBYQiLJAGQalpSxyWEzAJYWkGm8clTJjQCZ1hkoVG0CygAAAABJRU5ErkJggg=='
        @unreadNSFW = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAA4ElEQVQ4y2P4//8/AyWYgSoGQMF/GJ7YNbGqrKRiUnp21lwQBrFBYshqwBqQDPifdsYYjkH8mInxB+OWx58FYRAbmxoMF6ArKPmU9B6IP2CTw+sCmKKe/5X/gPg/LnmcYQDCs/63/1/9fzYQzwGz0eXRXcAACqy4ZfFnQc7u+V/xD6T55v+LQHwJbBBIDCQHUgNSS5QBt4Cab/2/jDDgMx4DykrKJ8FCG58XQGpAajEMmNw7uQo5sHAFIogNVctATDR+IDYasRoAS0gkGYBMw5IyNjlsBsDSAjKNV44quREAx58Mr9vt5wQAAAAASUVORK5CYII='
      when 'Mayhem'
        @unreadDead = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABIUlEQVQ4jZ2ScWuDMBDFgw4pIkU0WsoQkWAYIkXZH4N9/+/V3dmfXSrKYIFHwt17j8vdGWNMIkgFuaDgzgQnwRs4EQs5KdolUQtagRN0givEDBTEOjgtGs0Zq8F7cKqqusVxrMQLaDUWcjBSrXkn8gs51tpJSWLk9b3HUa0aNIL5gPBR1/V4kJvR7lTwl8GmAm1Gf9+c3S+89qBHa8502AsmSrtBaEBPbIbj0ah2madlNAPEccdgJDfAtWifBjqWKShRBT6KoiH8QlEUn/qt0CCjnNdmPUwmFWzj9Oe6LpKuZXcwqq88z78Pch3aZU3dPwwc2sWlfZKCW5tWluV8kGvXClLm6dYN4/aUqfCbnEOzNDGhGZbNargvxCzvMGfRJD8UaDVvgkzo6QAAAABJRU5ErkJggg=='
        @unreadSFW  = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABCElEQVQ4jZ2S4crCMAxF+0OGDJEPKYrIGKOsiJSx/fJRfSAfTJNyKqXfiuDg0C25N2RJjTGmEVrhTzhw7oStsIEtsVzT4o2Jo9ALThiEM8IdHIgNaHo8mjNWg6/ske8bohPo+63QOLzmooHp8fyAICBSQkVz0QKdsFQEV6WSW/D+7+BbgbIDHcb4Kp61XyjyI16zZ8JemGltQtDBSGxB4/GoN+7TpkkjDCsFArm0IYv3U0BbnYtf8BCy+JytsE0X6VyuKhPPK/GAJ14kvZZDZVV3pZIb8MZr6n4o4PDGKn0S5SdDmyq5PnXQsk+Xbhinp03FFzmHJw6xYRiWm9VxnohZ3vOcxdO8ARmXRvbWdtzQAAAAAElFTkSuQmCC'
        @unreadNSFW = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABCklEQVQ4jZ2S0WrDMAxF/TBCCKWMYhZKCSGYmFJMSNjD/mhf239qJXNcjBdTWODgRLpXKJKNMaYROuFTOHEehFb4gJZYrunwxsSXMApOmIQzwgOciE1oRjyaM1aDj+yR7xuiHvT9VmgcXnPRwO/9+wWCgEgJFc1FCwzCVhFclUpuw/u3g3cFyg50GPOjePZ+ocjPeM2RCXthpbUFwQAzsQ2Nx6PeuE+bJo0w7BQI5NKGLN5XAW11LX7BQ8jia7bCLl2kc7mqTLzuxAOeeJH0Wk6VVf0oldyEN15T948CDm+sMiZRfjK0pZIbUwcd+3TphnF62lR8kXN44hAbhmG5WQNnT8zynucsnuYJhFpBfkMzqD4AAAAASUVORK5CYII='
      when 'Original'
        @unreadDead = 'data:image/gif;base64,R0lGODlhEAAQAKECAAAAAP8AAP///////yH5BAEKAAMALAAAAAAQABAAAAI/nI95wsqygIRxDgGCBhTrwF3Zxowg5H1cSopS6FrGQ82PU1951ckRmYKJVCXizLRC9kAnT0aIiR6lCFT1cigAADs='
        @unreadSFW  = 'data:image/gif;base64,R0lGODlhEAAQAKECAAAAAC6Xw////////yH5BAEKAAMALAAAAAAQABAAAAI/nI95wsqygIRxDgGCBhTrwF3Zxowg5H1cSopS6FrGQ82PU1951ckRmYKJVCXizLRC9kAnT0aIiR6lCFT1cigAADs='
        @unreadNSFW = 'data:image/gif;base64,R0lGODlhEAAQAKECAAAAAGbMM////////yH5BAEKAAMALAAAAAAQABAAAAI/nI95wsqygIRxDgGCBhTrwF3Zxowg5H1cSopS6FrGQ82PU1951ckRmYKJVCXizLRC9kAnT0aIiR6lCFT1cigAADs='
    @unread = if @SFW then @unreadSFW else @unreadNSFW

  empty: 'data:image/gif;base64,R0lGODlhEAAQAJEAAAAAAP///9vb2////yH5BAEAAAMALAAAAAAQABAAAAIvnI+pq+D9DBAUoFkPFnbs7lFZKIJOJJ3MyraoB14jFpOcVMpzrnF3OKlZYsMWowAAOw=='
  dead: 'data:image/gif;base64,R0lGODlhEAAQAKECAAAAAP8AAP///////yH5BAEKAAIALAAAAAAQABAAAAIvlI+pq+D9DAgUoFkPDlbs7lFZKIJOJJ3MyraoB14jFpOcVMpzrnF3OKlZYsMWowAAOw=='

Redirect =
  image: (board, filename) ->
    # Do not use g.BOARD, the image url can originate from a cross-quote.
    switch board
      when 'a', 'jp', 'm', 'q', 'sp', 'tg', 'vg', 'wsg'
        "//archive.foolz.us/#{board}/full_image/#{filename}"
      when 'u'
        "//nsfw.foolz.us/#{board}/full_image/#{filename}"
      when 'ck', 'lit'
        "//fuuka.warosu.org/#{board}/full_image/#{filename}"
      when 'cgl', 'g', 'mu', 'w'
        "//rbt.asia/#{board}/full_image/#{filename}"
      when 'an', 'k', 'toy', 'x'
        "http://archive.heinessen.com/#{board}/full_image/#{filename}"
      when 'e'
        "//www.xn--clich-fsa.net/4chan/cgi-board.pl/#{board}/img/#{filename}"
      when 'c'
        "//archive.nyafuu.org/#{board}/full_image/#{filename}"

  post: (board, postID) ->
    switch board
      when 'a', 'co', 'jp', 'm', 'q', 'sp', 'tg', 'tv', 'v', 'vg', 'wsg', 'dev', 'foolz'
        "//archive.foolz.us/_/api/chan/post/?board=#{board}&num=#{postID}"
      when 'u', 'kuku'
        "//nsfw.foolz.us/_/api/chan/post/?board=#{board}&num=#{postID}"

  archive:    {}

  archiver:
    'Foolz':
      base:    '//archive.foolz.us'
      boards:  ['a', 'co', 'jp', 'm', 'q', 'sp', 'tg', 'tv', 'v', 'vg', 'wsg', 'dev', 'foolz']
      type:    'foolfuuka'
    'NSFWFoolz':
      base:    '//nsfw.foolz.us'
      boards:  ['u', 'kuku']
      type:    'foolfuuka'
    'TheDarkCave':
      base:    'http://archive.thedarkcave.org'
      boards:  ['c', 'int','po']
      type:    'foolfuuka'
    'Warosu':
      base:    '//fuuka.warosu.org'
      boards:  ['cgl', 'ck', 'jp', 'lit', 'q', 'tg']
      type:    'fuuka'
    'RebeccaBlackTech':
      base:    '//rbt.asia'
      boards:  ['cgl', 'g', 'mu', 'w']
      type:    'fuuka_mail'
    'InstallGentoo':
      base:    '//archive.installgentoo.net'
      boards:  ['diy', 'g', 'sci']
      type:    'fuuka'
    'Heinessen':
      base:    'http://archive.heinessen.com'
      boards:  ['an', 'fit', 'k', 'mlp', 'r9k', 'toy', 'x']
      type:    'fuuka'
    'Cliché':
      base: '//www.xn--clich-fsa.net/4chan/cgi-board.pl'
      boards: ['e']
      type: 'fuuka'
    'NyaFuu':
      base: '//archive.nyafuu.org'
      boards: ['c', 'w']
      type: 'fuuka'

  select: (board) ->
    names = []
    for name, type of @archiver
      if type.boards.indexOf(board) is -1
        continue
      names.push name
    names

  to: (data) ->
    if aboard = @archiver[@archive[board = data.board] or @archive[board] = $.get "archiver/#{board}/", @select(board)[0]]
      @path aboard.base, aboard.type, data
    else if not data.isSearch and data.threadID
      "//boards.4chan.org/#{board}/"
    else
      null

  path: (base, archiver, data) ->
    if data.isSearch
      {board, type, value} = data
      type =
        if type is 'name'
          'username'
        else if type is 'md5'
          'image'
        else
          type
      value = encodeURIComponent value
      return if archiver is 'foolfuuka'
        "#{base}/#{board}/search/#{type}/#{value}"
      else if type is 'image'
        "#{base}/#{board}/?task=search2&search_media_hash=#{value}"
      else if /fuuka/.test archiver
        if archiver is 'fuuka_mail' or type isnt 'email'
          "#{base}/#{board}/?task=search2&search_#{type}=#{value}"
        else
          false

    {board, threadID, postID} = data
    # keep the number only if the location.hash was sent f.e.
    postID = postID.match(/\d+/)[0] if postID
    path =
      if threadID
        "#{board}/thread/#{threadID}"
      else
        "#{board}/post/#{postID}"
    if archiver is 'foolfuuka'
      path += '/'
    if threadID and postID
      path +=
        if archiver is 'foolfuuka'
          "##{postID}"
        else
          "#p#{postID}"
    "#{base}/#{path}"

ImageHover =
  init: ->
    Main.callbacks.push @node
  node: (post) ->
    return if (!post.img or post.hasPdf)
    $.on post.img, 'mouseover', ImageHover.mouseover
  mouseover: ->
    # Make sure to remove the previous image hover
    # in case it got stuck. Opera-only bug?
    if el = $.id 'ihover'
      if el is UI.el
        delete UI.el
      $.rm el

    # Don't stop other elements from dragging
    return if UI.el

    el = UI.el = $.el 'img',
      id: 'ihover'
      src: @parentNode.href
    $.add d.body, el
    $.on el, 'load',      ImageHover.load
    $.on el, 'error',     ImageHover.error
    $.on @,  'mousemove', UI.hover
    $.on @,  'mouseout',  ImageHover.mouseout
  load: ->
    return unless @parentNode
    # 'Fake' mousemove event by giving required values.
    {style} = @
    UI.hover
      clientX: - 45 + parseInt style.left
      clientY:  120 + parseInt style.top
  error: ->
    src = @src.split '/'
    unless src[2] is 'images.4chan.org' and url = Redirect.image src[3], src[5]
      return if g.dead
      url = "//images.4chan.org/#{src[3]}/src/#{src[5]}"
    return if $.engine isnt 'webkit' and url.split('/')[2] is 'images.4chan.org'
    timeoutID = setTimeout (=> @src = url), 3000
    # Only Chrome let userscripts do cross domain requests.
    # Don't check for 404'd status in the archivers.
    return if $.engine isnt 'webkit' or url.split('/')[2] isnt 'images.4chan.org'
    $.ajax url, onreadystatechange: (-> clearTimeout timeoutID if @status is 404),
      type: 'head'
  mouseout: ->
    UI.hoverend()
    $.off @, 'mousemove', UI.hover
    $.off @, 'mouseout',  ImageHover.mouseout

Prefetch =
  init: ->
    return if g.BOARD is 'f'
    @dialog()
  dialog: ->
    controls = $.el 'label',
      id: 'prefetch'
      innerHTML:
        "Prefetch Images<input type=checkbox id=prefetch>"
    input = $ 'input', controls
    $.on input, 'change', Prefetch.change

    first = $.id('delform').firstElementChild
    if first.id is 'imgControls'
      $.after first, controls
    else
      $.before first, controls

  change: ->
    $.off @, 'change', Prefetch.change
    for thumb in $$ 'a.fileThumb'
      $.el 'img',
        src: thumb.href
    Main.callbacks.push Prefetch.node

  node: (post) ->
    {img} = post
    return if post.el.hidden or !img
    $.el 'img',
      src: img.parentNode.href

ImageReplace =
  init: ->
    return if g.BOARD is 'f'
    Main.callbacks.push @node

  node: (post) ->
    {img} = post
    return if post.el.hidden or !img or /spoiler/.test img.src
    el = $.el 'img',
      src: img.parentNode.href
    if Conf["Replace #{(el.src.match /\w{3}$/)[0].toUpperCase()}"]
      $.on el, 'load', ->
        img.src = el.src

ImageExpand =
  init: ->
    return if g.BOARD is 'f'
    Main.callbacks.push @node
    @dialog()

  node: (post) ->
    return if (!post.img or post.hasPdf)
    a = post.img.parentNode
    $.on a, 'click', ImageExpand.cb.toggle
    return if Conf['Don\'t Expand Spoilers'] and !Conf['Reveal Spoilers'] and /^Spoiler\ Image/.test a.firstChild.alt
    if ImageExpand.on and !post.el.hidden
      ImageExpand.expand post.img
  cb:
    toggle: (e) ->
      return if e.shiftKey or e.altKey or e.ctrlKey or e.metaKey or e.button isnt 0
      e.preventDefault()
      ImageExpand.toggle @
    all: ->
      ImageExpand.on = @checked
      if ImageExpand.on #expand
        thumbs = $$ 'img[data-md5]'
        if Conf['Expand From Current']
          for thumb, i in thumbs
            if thumb.getBoundingClientRect().top > 0
              break
          thumbs = thumbs[i...]
        for thumb in thumbs
          continue if Conf['Don\'t Expand Spoilers'] and !Conf['Reveal Spoilers'] and /^Spoiler\ Image/.test thumb.alt
          ImageExpand.expand thumb
      else #contract
        for thumb in $$ 'img[data-md5][hidden]'
          ImageExpand.contract thumb
      return
    typeChange: ->
      switch @value
        when 'full'
          klass = ''
        when 'fit width'
          klass = 'fitwidth'
        when 'fit height'
          klass = 'fitheight'
        when 'fit screen'
          klass = 'fitwidth fitheight'
      $.id('delform').className = klass
      if /\bfitheight\b/.test klass
        $.on window, 'resize', ImageExpand.resize
        unless ImageExpand.style
          ImageExpand.style = $.addStyle ''
        ImageExpand.resize()
      else if ImageExpand.style
        $.off window, 'resize', ImageExpand.resize

  toggle: (a) ->
    thumb = a.firstChild
    if thumb.hidden
      rect = a.getBoundingClientRect()
      if rect.bottom > 0 # should be at least partially visible.
        # Scroll back to the thumbnail when contracting the image
        # to avoid being left miles away from the relevant post.
        if $.engine is 'webkit'
          d.body.scrollTop  += rect.top - 42 if rect.top < 0
          d.body.scrollLeft += rect.left     if rect.left < 0
        else
          d.documentElement.scrollTop  += rect.top - 42 if rect.top < 0
          d.documentElement.scrollLeft += rect.left     if rect.left < 0
      ImageExpand.contract thumb
    else
      ImageExpand.expand thumb

  contract: (thumb) ->
    thumb.hidden = false
    thumb.nextSibling.hidden = true
    $.rmClass thumb.parentNode.parentNode.parentNode, 'image_expanded'

  expand: (thumb, src) ->
    # Do not expand images of hidden/filtered replies, or already expanded pictures.
    return if $.x 'ancestor-or-self::*[@hidden]', thumb
    a = thumb.parentNode
    src or= a.href
    return if /\.pdf$/.test src
    thumb.hidden = true
    $.addClass thumb.parentNode.parentNode.parentNode, 'image_expanded'
    if (img = thumb.nextSibling) && img.nodeName is 'IMG'
      # Expand already loaded picture
      img.hidden = false
      return
    img = $.el 'img', { src }
    $.on img, 'error', ImageExpand.error
    $.after thumb, img

  error: ->
    thumb = @previousSibling
    ImageExpand.contract thumb
    $.rm @
    src = @src.split '/'
    unless src[2] is 'images.4chan.org' and url = Redirect.image src[3], src[5]
      return if g.dead
      url = "//images.4chan.org/#{src[3]}/src/#{src[5]}"
    return if $.engine isnt 'webkit' and url.split('/')[2] is 'images.4chan.org'
    timeoutID = setTimeout ImageExpand.expand, 10000, thumb, url
    # Only Chrome let userscripts do cross domain requests.
    # Don't check for 404'd status in the archivers.
    return if $.engine isnt 'webkit' or url.split('/')[2] isnt 'images.4chan.org'
    $.ajax url, onreadystatechange: (-> clearTimeout timeoutID if @status is 404),
      type: 'head'

  dialog: ->
    controls = $.el 'span',
      id: 'imgControls'
      innerHTML:
        "<select id=imageType name=imageType><option value=full>Full</option><option value='fit width'>Fit Width</option><option value='fit height'>Fit Height</option value='fit screen'><option value='fit screen'>Fit Screen</option></select><label>Expand Images<input type=checkbox id=imageExpand></label>"
    imageType = $.get 'imageType', 'full'
    select = $ 'select', controls
    select.value = imageType
    ImageExpand.cb.typeChange.call select
    $.on select, 'change', $.cb.value
    $.on select, 'change', ImageExpand.cb.typeChange
    $.on $('input', controls), 'click', ImageExpand.cb.all

    $.prepend $.id('delform'), controls

  resize: ->
    ImageExpand.style.textContent = ".fitheight img[data-md5] + img {max-height:#{d.documentElement.clientHeight}px;}"

CatalogLinks =
  init: ->
    el = $.el 'span',
      className: 'toggleCatalog'
      innerHTML: '[<a href=javascript:;></a>]'
    for nav in ['boardNavDesktop', 'boardNavDesktopFoot']
      clone = el.cloneNode true
      $.on clone.firstElementChild, 'click', @toggle
      $.add $.id(nav), clone

    # Set links on load.
    @toggle true

  toggle: (onLoad) ->
    if onLoad is true
      useCatalog = $.get 'CatalogIsToggled', g.CATALOG
    else
      useCatalog = @textContent is 'Catalog Off'
      $.set 'CatalogIsToggled', useCatalog

    for nav in ['boardNavDesktop', 'boardNavDesktopFoot']
      root = $.id nav
      for a in $$ 'a[href*="boards.4chan.org"]', root
        board = a.pathname.split('/')[1]
        if board is 'f'
          # 4chan links to /f/'s catalog even if it doesn't have one.
          a.pathname = '/f/'
          continue
        a.pathname = "/#{board}/#{if useCatalog then 'catalog' else ''}"

      a = $('.toggleCatalog', root).firstElementChild
      a.textContent = "Catalog #{if useCatalog then 'On' else 'Off'}"
      a.title = "Turn catalog links #{if useCatalog then 'off' else 'on'}."
    return

Main =
  init: ->
    Main.flatten null, Config

    # Load values from localStorage.
    for key, val of Conf
      Conf[key] = $.get key, val

    path = location.pathname
    pathname = path[1..].split '/'
    [g.BOARD, temp] = pathname
    switch temp
      when 'res'
        g.REPLY = true
        g.THREAD_ID = pathname[2]
      when 'catalog'
        g.CATALOG = true

    # Setup Fill some per board configuration values with their global equivalents.
    if Conf["Interval per board"]
      Conf["Interval_"   + g.BOARD] = $.get "Interval_"   + g.BOARD, Conf["Interval"]
      Conf["BGInterval_" + g.BOARD] = $.get "BGInterval_" + g.BOARD, Conf["BGInteval"]

    switch location.hostname
      when 'sys.4chan.org'
        if /report/.test location.search
          $.ready ->
            form  = $ 'form'
            field = $.id 'recaptcha_response_field'
            $.on field, 'keydown', (e) ->
              window.location = 'javascript:Recaptcha.reload()' if e.keyCode is 8 and not e.target.value
            $.on form, 'submit', (e) ->
              e.preventDefault()
              response = field.value.trim()
              field.value = "#{response} #{response}" unless /\s/.test response
              form.submit()
        if /auth/.test location.pathname
          $.ready ->
            return unless message = $ 'span'
            setTimeout ->
              if /^Success!/.test message.textContent
                window.close()
              else
                window.history.back()
            , 1500
        return
      when 'images.4chan.org'
        $.ready ->
          if /^4chan - 404/.test(d.title) and Conf['404 Redirect']
            path = location.pathname.split '/'
            url  = Redirect.image path[1], path[3]
            location.href = url if url
        return

    if Conf['Disable 4chan\'s extension']
      settings = JSON.parse(localStorage.getItem '4chan-settings') or {}
      settings.disableAll = true
      localStorage.setItem '4chan-settings', JSON.stringify settings

    Main.polyfill()

    if g.CATALOG
      $.ready Main.catalog
    else
      Main.features()

  polyfill: ->
    # page visibility API
    unless 'visibilityState' of document
      prefix = if 'mozVisibilityState' of document
        'moz'
      else if 'webkitVisibilityState' of document
        'webkit'
      else
        'o'

      property = prefix + 'VisibilityState'
      event = prefix + 'visibilitychange'

      d.visibilityState = d[property]
      d.hidden = d.visibilityState is 'hidden'
      $.on d, event, ->
        d.visibilityState = d[property]
        d.hidden = d.visibilityState is 'hidden'
        $.event d, new CustomEvent 'visibilitychange'

  catalog: ->
    if Conf['Catalog Links']
      CatalogLinks.init()

    if Conf['Thread Hiding']
      ThreadHiding.init()

    setTimeout ->
      Main.hidegMessage.create()
      Main.cleanup()

  features: ->
    Options.init()

    if Conf['Quick Reply'] and Conf['Hide Original Post Form']
      Main.css += '#postForm { display: none; }'

    if Conf['Color user IDs']
      Main.css += '.posteruid .hand { padding: 0 5px; border-radius: 6px; font-size: 0.8em; }'

    $.addStyle Main.css

    now = Date.now()
    if Conf['Check for Updates'] and $.get('lastUpdate',  0) < now - 6*$.HOUR
      $.ready ->
        $.on window, 'message', Main.message
        $.set 'lastUpdate', now
        $.add d.head, $.el 'script',
          src: 'https://github.com/ihavenoface/4chan-x/raw/master/latest.js'

    g.hiddenReplies = $.get "hiddenReplies/#{g.BOARD}/", {}
    if $.get('lastChecked', 0) < now - 1*$.DAY
      $.set 'lastChecked', now

      cutoff = now - 7*$.DAY
      hiddenThreads = $.get "hiddenThreads/#{g.BOARD}/", {}

      for id, timestamp of hiddenThreads
        if timestamp < cutoff
          delete hiddenThreads[id]

      for id, timestamp of g.hiddenReplies
        if timestamp < cutoff
          delete g.hiddenReplies[id]

      $.set "hiddenThreads/#{g.BOARD}/", hiddenThreads
      $.set "hiddenReplies/#{g.BOARD}/", g.hiddenReplies

    #major features
    if Conf['Filter']
      Filter.init()

    if Conf['Reply Hiding']
      ReplyHiding.init()

    if Conf['Filter'] or Conf['Reply Hiding']
      StrikethroughQuotes.init()

    if Conf['Anonymize']
      Anonymize.init()

    if Conf['Time Formatting']
      Time.init()

    if Conf['Relative Post Dates']
      RelativeDates.init()

    if Conf['File Info Formatting']
      FileInfo.init()

    if Conf['Sauce']
      Sauce.init()

    if Conf['Reveal Spoilers']
      RevealSpoilers.init()

    if Conf['Image Hover']
      ImageHover.init()

    if Conf['Menu']
      Menu.init()

      if Conf['Report Link']
        ReportLink.init()

      if Conf['Delete Link']
        DeleteLink.init()

      if Conf['Filter']
        Filter.menuInit()

      if Conf['Archive Link']
        ArchiveLink.init()

      if Conf['Download Link']
        DownloadLink.init()

      if Conf['Embed Link']
        EmbedLink.init()

    if Conf['Linkify']
      Linkify.init()

    if Conf['Remove Spoilers']
      RemoveSpoilers.init()

    if Conf['Resurrect Quotes']
      Quotify.init()

    if Conf['Quote Inline']
      QuoteInline.init()

    if Conf['Quote Preview']
      QuotePreview.init()

    if Conf['Quote Backlinks']
      QuoteBacklink.init()

    if Conf['Indicate OP quote']
      QuoteOP.init()

    if Conf['Indicate Quotes of You']
      QuoteYou.init()

    if Conf['Indicate Cross-thread Quotes']
      QuoteCT.init()

    if Conf['Color user IDs']
      IDColor.init()

    $.ready Main.featuresReady

  featuresReady: ->
    if /^4chan - 404/.test d.title
      if Conf['404 Redirect'] and /^\d+$/.test g.THREAD_ID
        location.href =
          Redirect.to
            board:    g.BOARD
            threadID: g.THREAD_ID
            postID:   location.hash
      return
    unless $.id 'navtopright'
      return
    $.addClass d.body, $.engine
    $.addClass d.body, 'fourchan_x'
    for nav in ['boardNavDesktop', 'boardNavDesktopFoot']
      if a = $ "a[href$='/#{g.BOARD}/']", $.id nav
        # Gotta make it work in temporary boards.
        $.addClass a, 'current'

    if styleSelector = $.id 'styleSelector'
      passLink = $.el 'a',
        textContent: '4chan Pass'
        href: 'javascript:;'
      $.on passLink, 'click', ->
        window.open '//sys.4chan.org/auth',
          'This will steal your data.'
          'left=0,top=0,width=500,height=255,toolbar=0,resizable=0'
      $.before styleSelector.previousSibling, [$.tn '['; passLink, $.tn ']\u00A0\u00A0']

    Main.hidegMessage.create()
    Main.cleanup()

    Favicon.init()

    # Major features.
    if Conf['Quick Reply']
      QR.init()

    if Conf['Image Expansion']
      ImageExpand.init()

    if Conf['Catalog Links']
      CatalogLinks.init()

    if Conf['Thread Watcher']
      setTimeout -> Watcher.init()

    if Conf['Keybinds']
      setTimeout -> Keybinds.init()

    if Conf['Replace GIF'] or Conf['Replace PNG'] or Conf['Replace JPG']
      ImageReplace.init()

    if g.REPLY
      if Conf['Prefetch']
        Prefetch.init()

      if Conf['Thread Updater']
        setTimeout -> Updater.init()

      if Conf['Thread Stats']
        ThreadStats.init()

      if Conf['Reply Navigation']
        setTimeout -> Nav.init()

      if Conf['Post in Title']
        TitlePost.init()

      if Conf['Unread Count'] or Conf['Unread Favicon']
        Unread.init()

    else #not reply
      if Conf['Thread Hiding']
        ThreadHiding.init()

      if Conf['Thread Expansion']
        setTimeout -> ExpandThread.init()

      if Conf['Comment Expansion']
        setTimeout -> ExpandComment.init()

      if Conf['Index Navigation']
        setTimeout -> Nav.init()

    board = $ '.board'
    nodes = []
    for node in $$ '.postContainer', board
      nodes.push Main.preParse node
    Main.node nodes, ->
      if d.readyState is "complete"
        return true
      false

    # Execute these scripts on inserted posts, not page init.
    Main.hasCodeTags = !! $ 'script[src^="//static.4chan.org/js/prettify/prettify"]'

    if MutationObserver = window.MutationObserver or window.WebKitMutationObserver or window.OMutationObserver
      observer = new MutationObserver Main.observer
      observer.observe board,
        childList: true
        subtree:   true
    else
      $.on board, 'DOMNodeInserted', Main.listener
    return

  flatten: (parent, obj) ->
    if obj instanceof Array
      Conf[parent] = obj[0]
    else if typeof obj is 'object'
      for key, val of obj
        Main.flatten key, val
    else # string or number
      Conf[parent] = obj
    return

  message: (e) ->
    {version} = e.data
    if version and version isnt Main.version
      xupdate = $.el 'div',
        id: 'xupdater'
        innerHTML:
          "An updated version of <a href=https://raw.github.com/ihavenoface/4chan-x/#{version}/4chan_x.user.js>4chan X</a> (v#{version}) is available.<a href=javascript:; id=dismiss_xupdate>  ×</a>"
      $.prepend $.id('delform'), xupdate
      $.on $('#dismiss_xupdate'), 'click', ->
        $.rm xupdate

  preParse: (node) ->
    parentClass = node.parentNode.className
    el   = $ '.post', node
    post =
      root:        node
      el:          el
      class:       el.className
      ID:          el.id.match(/\d+$/)[0]
      threadID:    g.THREAD_ID or $.x('ancestor::div[parent::div[@class="board"]]', node).id.match(/\d+$/)[0]
      isArchived:  /\barchivedPost\b/.test parentClass
      isInlined:   /\binline\b/.test       parentClass
      isCrosspost: /\bcrosspost\b/.test    parentClass
      blockquote:  el.lastElementChild
      quotes:      el.getElementsByClassName 'quotelink'
      backlinks:   el.getElementsByClassName 'backlink'
      fileInfo:    false
      img:         false
    if img = $ 'img[data-md5]', el
      # Make sure to not add deleted images,
      # those do not have a data-md5 attribute.
      imgParent = img.parentNode
      post.img      = img
      post.fileInfo = imgParent.previousElementSibling
      post.hasPdf   = /\.pdf$/.test imgParent.href
    Main.prettify post.blockquote
    post
  node: (nodes, notify) ->
    for callback in Main.callbacks
      try
        callback node for node in nodes
      catch err
        alert "4chan X (#{Main.version}) error: #{err.message}\nReport the bug at ihavenoface.github.com/4chan-x/#bug-report\n\nURL: #{window.location}\n#{err.stack}" if notify
    return
  observer: (mutations) ->
    nodes = []
    for mutation in mutations
      for addedNode in mutation.addedNodes
        if /\bpostContainer\b/.test(addedNode.className)
          nodes.push Main.preParse addedNode
    Main.node nodes if nodes.length
  listener: (e) ->
    {target} = e
    if /\bpostContainer\b/.test(target.className)
      Main.node [Main.preParse target]

  prettify: (bq) ->
    return unless Main.hasCodeTags
    code = ->
      for pre in document.getElementById('_id_').getElementsByClassName 'prettyprint'
        pre.innerHTML = prettyPrintOne pre.innerHTML.replace /\s/g, '&nbsp;'
      return
    $.globalEval "(#{code})()".replace '_id_', bq.id

  hidegMessage:
    create: ->
      return unless gmsg = $.id 'globalMessage'
      $.rm $.id 'toggleMsgBtn' if g.CATALOG
      hideState = $.get 'hidegMessage', hidden: false
      hideBtn   = $.el 'div',
        id:        'hideBtn'
        innerHTML: "[<a href=javascript:; id=hgMessage>Hide</a>] " +
                   "<span>[<a href=javascript:; id=dgMessage>Dismiss</a>]</span>"
      $.on (first = hideBtn.firstElementChild), 'click', ->
        Main.hidegMessage.toggle.call {el: first, gmsg, hideState}
      $.on (last  = hideBtn.lastElementChild.firstElementChild),  'click', ->
        Main.hidegMessage.toggle.call {el: last,  gmsg, hideState}
      $.before gmsg, hideBtn
      if hideState.hidden and not hideState.gmsg and hideState.gmsg isnt gmsg.textContent
        @toggle.call {el: first, gmsg, hideState}
      if hideState.gmsg and hideState.gmsg is gmsg.textContent
        @toggle.call {el: first, gmsg, hideState} if hideState.hidden
        @toggle.call {el: last,  gmsg, hideState}

    toggle: ->
      {el, gmsg, hideState} = @
      switch el.id
        when 'hgMessage'
          for i in [gmsg, el.nextElementSibling]
            i.classList.toggle 'hidden'
          if el.textContent is 'Hide'
            hideState.hidden = true
            el.textContent   = 'Show'
          else
            hideState.hidden = false
            el.textContent   = 'Hide'
        when 'dgMessage'
          if el.textContent is 'Dismiss'
            hideState.gmsg = gmsg.textContent
            el.textContent = 'Detain'
          else
            delete hideState.gmsg
            el.textContent = 'Dismiss'
      $.set 'hidegMessage', hideState

  cleanup: ->
    for ad in ['top', 'middle', 'bottom']
      continue unless ad = $ ".#{ad}ad"
      if (hr = ad.nextSibling).localName is 'hr'
        $.rm hr
      $.rm ad
    return

  namespace: '4chan_x.'
  version: '2.38.5'
  callbacks: []
  css: '
/* dialog styling */
hr.abovePostForm {
  width: 100% !important;
}
.post.reply.yourPost, #qp.yourPost {
  border-left: 1px solid rgba(221,0,0,.5) !important;
}
.dialog.reply {
  display: block;
  border: 1px solid rgba(0,0,0,.25);
  padding: 0;
}
.move {
  cursor: move;
}
label, .favicon {
  cursor: pointer;
}
a[href="javascript:;"] {
  text-decoration: none;
}
.warning {
  color: red;
}

.hide_thread_button:not(.hidden_thread) {
  float: left;
}

.thread > .hidden_thread ~ *,
[hidden],
#globalMessage.hidden,
#content > [name=tab]:not(:checked) + div,
#updater:not(:hover) > :not(.move),
.autohide:not(:hover) > form,
#qp input, .forwarded {
  display: none !important;
}

.menu_button {
  display: inline-block;
}
.menu_button > span {
  border-top:   .5em solid;
  border-right: .3em solid transparent;
  border-left:  .3em solid transparent;
  display: inline-block;
  margin: 2px;
  vertical-align: middle;
}
#menu {
  position: absolute;
  outline: none;
}
.entry {
  border-bottom: 1px solid rgba(0, 0, 0, .25);
  cursor: pointer;
  display: block;
  outline: none;
  padding: 3px 7px;
  position: relative;
  text-decoration: none;
  white-space: nowrap;
}
.entry:last-child {
  border: none;
}
.focused.entry {
  background: rgba(255, 255, 255, .33);
}
.entry.hasSubMenu {
  padding-right: 1.5em;
}
.hasSubMenu::after {
  content: "";
  border-left:   .5em solid;
  border-top:    .3em solid transparent;
  border-bottom: .3em solid transparent;
  display: inline-block;
  margin: .3em;
  position: absolute;
  right: 3px;
}
.hasSubMenu:not(.focused) > .subMenu {
  display: none;
}
.subMenu {
  position: absolute;
  left: 100%;
  top: 0;
  margin-top: -1px;
}
h1,
h2 {
  text-align: center;
}
#qr > .move {
  min-width: 300px;
  overflow: hidden;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  padding: 0 2px;
}
#qr > .move > span {
  float: right;
}
#autohide, .close, #qr select, #dump, .remove, .captchaimg, #qr div.warning {
  cursor: pointer;
}
#qr select,
#qr > form {
  margin: 0;
}
#dump {
  background: -webkit-linear-gradient(#EEE, #CCC);
  background: -moz-linear-gradient(#EEE, #CCC);
  background: -o-linear-gradient(#EEE, #CCC);
  background: linear-gradient(#EEE, #CCC);
  width: 10%;
}
.gecko #dump {
  padding: 1px 0 2px;
}
#dump:hover, #dump:focus {
  background: -webkit-linear-gradient(#FFF, #DDD);
  background: -moz-linear-gradient(#FFF, #DDD);
  background: -o-linear-gradient(#FFF, #DDD);
  background: linear-gradient(#FFF, #DDD);
}
#dump:active, .dump #dump:not(:hover):not(:focus) {
  background: -webkit-linear-gradient(#CCC, #DDD);
  background: -moz-linear-gradient(#CCC, #DDD);
  background: -o-linear-gradient(#CCC, #DDD);
  background: linear-gradient(#CCC, #DDD);
}
#qr:not(.dump) #replies, .dump > form > label {
  display: none;
}
#replies {
  display: block;
  height: 100px;
  position: relative;
  -webkit-user-select: none;
  -moz-user-select: none;
  -o-user-select: none;
  user-select: none;
}
#replies > div {
  counter-reset: thumbnails;
  top: 0; right: 0; bottom: 0; left: 0;
  margin: 0; padding: 0;
  overflow: hidden;
  position: absolute;
  white-space: pre;
}
#replies > div:hover {
  bottom: -10px;
  overflow-x: auto;
  z-index: 1;
}
.thumbnail {
  background-color: rgba(0,0,0,.2) !important;
  background-position: 50% 20% !important;
  background-size: cover !important;
  border: 1px solid #666;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  cursor: move;
  display: inline-block;
  height: 90px; width: 90px;
  margin: 5px; padding: 2px;
  opacity: .5;
  outline: none;
  overflow: hidden;
  position: relative;
  text-shadow: 0 1px 1px #000;
  -webkit-transition: opacity .25s ease-in-out;
  -moz-transition: opacity .25s ease-in-out;
  -o-transition: opacity .25s ease-in-out;
  transition: opacity .25s ease-in-out;
  vertical-align: top;
}
.thumbnail:hover, .thumbnail:focus {
  opacity: .9;
}
.thumbnail#selected {
  opacity: 1;
}
.thumbnail::before {
  counter-increment: thumbnails;
  content: counter(thumbnails);
  color: #FFF;
  font-weight: 700;
  padding: 3px;
  position: absolute;
  top: 0;
  right: 0;
  text-shadow: 0 0 3px #000, 0 0 8px #000;
}
.thumbnail.drag {
  box-shadow: 0 0 10px rgba(0,0,0,.5);
}
.thumbnail.over {
  border-color: #FFF;
}
.thumbnail > span {
  color: #FFF;
}
.remove {
  background: none;
  color: #E00;
  font-weight: 700;
  padding: 3px;
}
.remove:hover::after {
  content: " Remove";
}
.thumbnail > label {
  background: rgba(0,0,0,.5);
  color: #FFF;
  right: 0; bottom: 0; left: 0;
  position: absolute;
  text-align: center;
}
.thumbnail > label > input {
  margin: 0;
}
#addReply {
  color: #333;
  font-size: 3.5em;
  line-height: 100px;
}
#addReply:hover, #addReply:focus {
  color: #000;
}
.field {
  border: 1px solid #CCC;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  color: #333;
  font: 13px sans-serif;
  margin: 0;
  padding: 2px 4px 3px;
  -webkit-transition: color .25s, border .25s;
  -moz-transition: color .25s, border .25s;
  -o-transition: color .25s, border .25s;
  transition: color .25s, border .25s;
}
.field:-moz-placeholder,
.field:hover:-moz-placeholder {
  color: #AAA;
}
.field:hover, .field:focus {
  border-color: #999;
  color: #000;
  outline: none;
}
#qr > form > div:first-child > .field:not(#dump) {
  width: 30%;
}
#qr textarea.field {
  display: -webkit-box;
  min-height: 160px;
  min-width: 100%;
}
#qr.captcha textarea.field {
  min-height: 120px;
}
.textarea {
  position: relative;
}
#charCount {
  color: #000;
  background: hsla(0, 0%, 100%, .5);
  font-size: 8pt;
  margin: 1px;
  position: absolute;
  bottom: 0;
  right: 0;
  pointer-events: none;
}
#charCount.warning {
  color: red;
}
.captchainput > .field {
  min-width: 100%;
}
.captchaimg {
  background: #FFF;
  outline: 1px solid #CCC;
  outline-offset: -1px;
  text-align: center;
}
.captchaimg > img {
  display: block;
  height: 57px;
  width: 300px;
}
#qr [type=file] {
  margin: 1px 0;
  width: 70%;
}
#qr [type=submit] {
  margin: 1px 0;
  padding: 1px; /* not Gecko */
  width: 30%;
}
.gecko #qr [type=submit] {
  padding: 0 1px; /* Gecko does not respect box-sizing: border-box */
}

.fileText:hover .fntrunc,
.fileText:not(:hover) .fnfull {
  display: none;
}
.fitwidth img[data-md5] + img {
  max-width: 100%;
}
.gecko  .fitwidth img[data-md5] + img,
.presto .fitwidth img[data-md5] + img {
  width: 100%;
}

#qr, #qp, #updater, #stats, #ihover, #overlay, #navlinks {
  position: fixed;
}

#ihover {
  max-height: 97%;
  max-width: 75%;
  padding-bottom: 18px;
}

#navlinks {
  font-size: 16px;
  top: 25px;
  right: 5px;
}

body {
  box-sizing: border-box;
  -moz-box-sizing: border-box;
}
body.unscroll {
  overflow: hidden;
}
#overlay {
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  text-align: center;
  background: rgba(0,0,0,.5);
  z-index: 1;
}
#overlay::after {
  content: "";
  display: inline-block;
  height: 100%;
  vertical-align: middle;
}
#options {
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  display: inline-block;
  padding: 5px;
  position: relative;
  text-align: left;
  vertical-align: middle;
  width: 600px;
  max-width: 100%;
  height: 500px;
  max-height: 100%;
}
#credits {
  float: right;
}
#options ul {
  padding: 0;
}
#options article li {
  margin: 10px 0 10px 2em;
}
#options code {
  background: hsla(0, 0%, 100%, .5);
  color: #000;
  padding: 0 1px;
}
#options label {
  text-decoration: underline;
}
#content {
  overflow: auto;
  position: absolute;
  top: 2.5em;
  right: 5px;
  bottom: 5px;
  left: 5px;
}
#content textarea {
  font-family: monospace;
  min-height: 350px;
  resize: vertical;
  width: 100%;
}

#updater {
  text-align: right;
}
#updater:not(:hover) {
  border: none;
  background: transparent;
}
#updater input[type=number] {
  width: 4em;
}
.new {
  background: lime;
}

#watcher {
  padding-bottom: 5px;
  position: absolute;
  overflow: hidden;
  white-space: nowrap;
}
#watcher:not(:hover) {
  max-height: 220px;
}
#watcher > div {
  max-width: 200px;
  overflow: hidden;
  padding-left: 5px;
  padding-right: 5px;
  text-overflow: ellipsis;
}
#watcher > .move {
  padding-top: 5px;
  text-decoration: underline;
}

#qp {
  padding: 2px 2px 5px;
}
#qp .post {
  border: none;
  margin: 0;
  padding: 0;
}
#qp img {
  max-height: 300px;
  max-width: 500px;
}
.qphl {
  box-shadow: 0 0 0 2px rgba(216, 94, 49, .7);
}
.quotelink.deadlink {
  text-decoration: underline !important;
}
.deadlink:not(.quotelink) {
  text-decoration: none !important;
}
.inlined {
  opacity: .5;
}
.inline {
  background-color: rgba(255, 255, 255, 0.15);
  border: 1px solid rgba(128, 128, 128, 0.5);
  display: table;
  margin: 2px;
  padding: 2px;
}
.inline .post {
  background: none;
  border: none;
  margin: 0;
  padding: 0;
}
div.opContainer {
  display: block !important;
}
.opContainer.filter_highlight {
  box-shadow: inset 5px 0 rgba(255, 0, 0, .5);
}
.opContainer.filter_highlight.qphl {
  box-shadow: inset 5px 0 rgba(255, 0, 0, .5),
              0 0 0 2px rgba(216, 94, 49, .7);
}
.filter_highlight > .reply {
  box-shadow: -5px 0 rgba(255, 0, 0, .5);
}
.filter_highlight > .reply.qphl {
  box-shadow: -5px 0 rgba(255, 0, 0, .5),
              0 0 0 2px rgba(216, 94, 49, .7)
}
.filtered,
.quotelink.filtered {
  text-decoration: underline;
  text-decoration: line-through !important;
}
.quotelink.forwardlink,
.backlink.forwardlink {
  text-decoration: none;
  border-bottom: 1px dashed;
}
.threadContainer {
  margin-left: 20px;
  border-left: 1px solid black;
}
#xupdater {
  margin-bottom: 2px;
}
.youtubeTitle {
  background: transparent url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAMCAYAAABr5z2BAAABIklEQVQoz53LvUrDUBjG8bOoOammSf1IoBSvoCB4JeIqOHgBLt6AIMRBBQelWurQ2kERnMRBsBUcIp5FJSBI5oQsJVkkUHh8W0o5nhaFHvjBgef/Mq+Q46RJBMkI/vE+aOus956tnEswIZe1LV0QyJ5sE2GzgZfVMtRNIdiDpccEssdlB1mW4bvTwdvWJtRdErM7U+8S/FJykCRJX5qm+KpVce8UMNLRLbulz4iSjTAMh6Iowsd5BeNadp3nUF0VlxAEwZBotXC0Usa4ll3meZdA1iguwvf9vpvDA2wvmKgYGtSud8suDB4TyGr2PF49D/vra9jRZ1BVdknMzgwuCGSnZEObwu6sBnVTCHZiaC7BhFx2PKdxUidiAH/4lLo9Mv0DELVs9qsOHXwAAAAASUVORK5CYII=") center left no-repeat!important;
  padding-left: 18px;
}
.vimeoTitle {
  background: transparent url("data:image/gif;base64,R0lGODlhEAAQAMQfAAuUuQynzzu83u/09Ryy2Su320rC4IbW6mKOngqHq5GvuoO3xhVbc0m92zV7keDo60R8j8Hc5KHEzwuawGSluaTg8Ah1lfD5/BmPsJPI13fR6LLd6f///wuavg2t1gAAACH5BAEAAB8ALAAAAAAQABAAAAVu4NeNZFmKgqeurCqMbbzCbrEWh0ao9MFdNgNnWOF1CJUhR+PZDIYRY2MRGWYIFsVQYgRYHNBAc4gwqiaPoUfIkQDMKsnwkB5YZp0VRTmEsGgeGHwIb3grAVoDCAktgB4WEAyMjY4AYpQiJpojHyEAOw==") center left no-repeat!important;
  padding-left: 18px;
}
.soundcloudTitle {
  background:transparent url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABsklEQVQ4y5WTy2pUQRCGv2rbzDjJeAlIBmOyipGIIJqFEBDElwh4yULGeRFXPoEIBl/AvQ/gC2RnxCAoxijiwks852S6+3dxzslcHJCpTXVX11/Xv0097gLPgVNMJxnQNfX4zsqleWbnpoMf/oa9d988MM9MC/rp+E0a+A0dsVobMNMCOO8B6McRoABJI+A6gJmN3D2A8jgEBCEkSEMBrcrsDAzDWWn3AjgKFaDMmgRqniGFgsaDp1jrLOngDf1XT1D+A1dFc4MKAkkiCVKjjVu7g9+4Rzx4i1u6hjXbuMWr0O5QPNvCu7IaCZwEKQukLGDrm5x8uI0tr6MkiGlkiv7yLfzN+6S5i6QsIMABkEfcxhbWWYMkVAOjxvYAjc3HNHrbKI9VBQBFwF25XQKSBjqIf1YBuAurEMrczgDygD6/x2LCpFLXLUyQ+PoldphhBhYfIX09XU1+Flaukz7uYqs3SHs7cG4BmTsmkBUF9mmXEwa28BNLPaQPLepuNcbGSWQquQC2/Kdcox1FUGkcB0ykck1nA2+wTzMs8stGnP4rbWGw74EuS/GFQWfK7/wF6P4F7fzIAYkdmdEAAAAASUVORK5CYII=") center left no-repeat!important;
  padding-left: 18px;
}
.embed {
  position: static !important;
  width: auto !important;
  height: auto !important;
  overflow: visible !important;
}
'

Main.init()

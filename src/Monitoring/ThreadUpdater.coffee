ThreadUpdater =
  init: ->
    return if g.VIEW isnt 'thread' or !Conf['Thread Updater']

    @button = $.el 'a',
      className: 'thread-refresh-shortcut fa fa-refresh'
      title: 'Refresh Thread'
      href: 'javascript:;'
    $.on @button, 'click', @update
    Header.addShortcut @button, 1

    html = ''
    for name, conf of Config.updater.checkbox
      checked = if Conf[name] then 'checked' else ''
      html   += "<div><label title='#{conf[1]}'><input name='#{name}' type=checkbox #{checked}> #{name}</label></div>"

    html = <%= importHTML('Monitoring/ThreadUpdater') %>

    @dialog = UI.dialog 'updater', 'bottom: 0; right: 0;', html
    @timer  = $ '#update-timer',  @dialog
    @status = $ '#update-status', @dialog
    @isUpdating = Conf['Auto Update']

    Thread.callbacks.push
      name: 'Thread Updater'
      cb:   @node

  node: ->
    ThreadUpdater.thread   = @
    ThreadUpdater.root     = @OP.nodes.root.parentNode
    ThreadUpdater.lastPost = +Object.keys(@posts).sort()[-1..][0]

    for input in $$ 'input', ThreadUpdater.dialog
      if input.type is 'checkbox'
        $.on input, 'change', $.cb.checked
      switch input.name
        when 'Scroll BG'
          $.on input, 'change', ThreadUpdater.cb.scrollBG
          ThreadUpdater.cb.scrollBG()
        when 'Auto Update This'
          $.off input, 'change', $.cb.checked
          $.on  input, 'change', ThreadUpdater.cb.autoUpdate
        when 'Interval'
          if Conf['Sync Thread Updater']
            ThreadUpdater.cb.sync.input = input
            $.sync 'Interval', ThreadUpdater.cb.sync
          $.on input, 'change', ThreadUpdater.cb.interval
          ThreadUpdater.cb.interval.call input
        when 'Update'
          $.on input, 'click', ThreadUpdater.update

    $.on window, 'online offline',   ThreadUpdater.cb.online
    $.on d,      'QRPostSuccessful', ThreadUpdater.cb.post
    $.on d,      'visibilitychange', ThreadUpdater.cb.visibility

    ThreadUpdater.cb.online()
    $.add d.body, ThreadUpdater.dialog

  beep: 'data:audio/wav;base64,<%= grunt.file.read("audio/beep.wav", {encoding: "base64"}) %>'

  cb:
    online: ->
      if navigator.onLine
        ThreadUpdater.outdateCount = 0
        ThreadUpdater.setInterval()
        ThreadUpdater.set 'status', null, null
      else
        ThreadUpdater.set 'timer', null
        ThreadUpdater.set 'status', 'Offline', 'warning'
      ThreadUpdater.count true
    post: (e) ->
      return unless ThreadUpdater.isUpdating and e.detail.threadID is ThreadUpdater.thread.ID
      ThreadUpdater.outdateCount = 0
      setTimeout ThreadUpdater.update, 1000 if ThreadUpdater.seconds > 2
    visibility: ->
      return if d.hidden
      # Reset the counter when we focus this tab.
      ThreadUpdater.outdateCount = 0
      ThreadUpdater.seconds = Math.min ThreadUpdater.seconds, ThreadUpdater.interval
    scrollBG: ->
      ThreadUpdater.scrollBG = if Conf['Scroll BG']
        -> true
      else
        -> not d.hidden
    autoUpdate: (e) ->
      ThreadUpdater.count ThreadUpdater.isUpdating = @checked
    sync: (e) ->
      {input} = ThreadUpdater.cb.sync
      input.value = e
      ThreadUpdater.cb.interval.call input
    interval: (e) ->
      val = unless val = parseInt @value
        Config.updater.Interval
      else if val < 1
        1
      else
        val
      ThreadUpdater.interval = @value = val
      $.cb.value.call @ if e
    load: (e) ->
      $.rmClass ThreadUpdater.button, 'fa-spin'
      {req} = ThreadUpdater
      delete ThreadUpdater.req
      if e.type isnt 'loadend' # timeout or abort
        req.onloadend = null
        if e.type is 'timeout'
          ThreadUpdater.set 'status', 'Retrying', null
          ThreadUpdater.update()
        return
      switch req.status
        when 200
          g.DEAD = false
          ThreadUpdater.parse req.response.posts
          ThreadUpdater.setInterval()
        when 404
          g.DEAD = true
          ThreadUpdater.set 'timer', null
          ThreadUpdater.set 'status', '404', 'warning'
          ThreadUpdater.thread.kill()
          $.event 'ThreadUpdate',
            404: true
            threadID: ThreadUpdater.thread.fullID
        else
          ThreadUpdater.outdateCount++
          ThreadUpdater.setInterval()
          [text, klass] = if req.status is 304
            [null, null]
          else
            ["#{req.statusText} (#{req.status})", 'warning']
          ThreadUpdater.set 'status', text, klass

  setInterval: ->
    # hurr durr
    ThreadUpdater.seconds = ThreadUpdater.interval
    ThreadUpdater.set 'timer', ThreadUpdater.seconds
    ThreadUpdater.count true

  set: (name, text, klass) ->
    el = ThreadUpdater[name]
    if node = el.firstChild
      # Prevent the creation of a new DOM Node
      # by setting the text node's data.
      node.data = text
    else
      el.textContent = text
    el.className = klass if klass isnt undefined

  count: (start) ->
    clearTimeout ThreadUpdater.timeoutID
    ThreadUpdater.timeout() if start and ThreadUpdater.isUpdating and navigator.onLine

  timeout: ->
    ThreadUpdater.timeoutID = setTimeout ThreadUpdater.timeout, 1000
    sec = ThreadUpdater.seconds--
    ThreadUpdater.set 'timer', sec
    ThreadUpdater.update() if sec <= 0

  update: ->
    return unless navigator.onLine
    $.addClass ThreadUpdater.button, 'fa-spin'
    ThreadUpdater.count()
    ThreadUpdater.set 'timer', '...'
    ThreadUpdater.req?.abort()
    url = "//a.4cdn.org/#{ThreadUpdater.thread.board}/thread/#{ThreadUpdater.thread}.json"
    ThreadUpdater.req = $.ajax url,
      onabort:   ThreadUpdater.cb.load
      onloadend: ThreadUpdater.cb.load
      ontimeout: ThreadUpdater.cb.load
      timeout:   $.MINUTE
    ,
      whenModified: true

  updateThreadStatus: (type, status) ->
    return unless hasChanged = ThreadUpdater.thread["is#{type}"] isnt status
    ThreadUpdater.thread.setStatus type, status
    change = if type is 'Sticky'
      if status
        'now a sticky'
      else
        'not a sticky anymore'
    else
      if status
        'now closed'
      else
        'not closed anymore'
    new Notice 'info', "The thread is #{change}.", 30

  parse: (postObjects) ->
    OP = postObjects[0]
    Build.spoilerRange[ThreadUpdater.thread.board] = OP.custom_spoiler

    ThreadUpdater.updateThreadStatus 'Sticky', !!OP.sticky
    ThreadUpdater.updateThreadStatus 'Closed', !!OP.closed
    ThreadUpdater.thread.postLimit = !!OP.bumplimit
    ThreadUpdater.thread.fileLimit = !!OP.imagelimit
    ThreadUpdater.thread.inedible  = if ThreadUpdater.interval <= Config.updater.Interval then 2 else 0

    nodes = [] # post container elements
    posts = [] # post objects
    index = [] # existing posts
    files = [] # existing files
    count = 0  # new posts count

    # Build the index, create posts.
    for postObject in postObjects
      num = postObject.no
      index.push num
      files.push num if postObject.fsize
      continue if num <= ThreadUpdater.lastPost
      # Insert new posts, not older ones.
      count++
      node = Build.postFromObject postObject, ThreadUpdater.thread.board.ID
      nodes.push node
      post = new Post node, ThreadUpdater.thread, ThreadUpdater.thread.board
      post.inedible = ThreadUpdater.thread.inedible
      posts.push post

    # Check for deleted posts/files.
    for ID, post of ThreadUpdater.thread.posts
      # XXX tmp fix for 4chan's racing condition
      # giving us false-positive dead posts.
      if post.inedible--
        delete post.isDead
        continue
      else
        delete post.inedible
      ID = +ID
      if post.isDead and ID in index
        post.resurrect()
      else unless ID in index
        post.kill()
      else if post.file and !post.file.isDead and ID not in files
        post.kill true

    sendEvent = ->
      $.event 'ThreadUpdate',
        404: false
        threadID: ThreadUpdater.thread.fullID
        newPosts: posts.map (post) -> post.fullID
        postCount: OP.replies + 1
        fileCount: OP.images + (!!ThreadUpdater.thread.OP.file and !ThreadUpdater.thread.OP.file.isDead)

    unless count
      ThreadUpdater.set 'status', null, null
      ThreadUpdater.outdateCount++
      sendEvent()
      return

    ThreadUpdater.set 'status', "+#{count}", 'new'
    ThreadUpdater.outdateCount = 0
    if Conf['Beep'] and d.hidden and Unread.posts and !Unread.posts.length
      unless ThreadUpdater.audio
        ThreadUpdater.audio = $.el 'audio', src: ThreadUpdater.beep
      ThreadUpdater.audio.play()

    ThreadUpdater.lastPost = posts[count - 1].ID
    Main.callbackNodes Post, posts

    scroll = Conf['Auto Scroll'] and ThreadUpdater.scrollBG() and Header.getBottomOf(ThreadUpdater.root) > -25
    $.add ThreadUpdater.root, nodes
    sendEvent()
    if scroll
      if Conf['Bottom Scroll']
        window.scrollTo 0, d.body.clientHeight
      else
        Header.scrollTo nodes[0]

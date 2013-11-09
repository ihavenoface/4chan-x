ReportLink =
  init: ->
    return if g.VIEW is 'catalog' or !Conf['Menu'] or !Conf['Report Link']
    @dialog = UI.dialog 'report', 'top: 50px; right: 0px;', """
    <%= grunt.file.read('html/Menu/ReportLink.html').replace(/>\s+</g, '><').trim() %>
    """
    @reportEmbed = $ '#report-embed', @dialog

    $.on d, '4chanXInitFinished', @ready

    a = $.el 'a',
      className: 'report-link'
      href: 'javascript:;'
      textContent: 'Report this post'
    $.on a, 'click', ReportLink.report
    $.event 'AddMenuEntry',
      type: 'post'
      el: a
      order: 10
      open: (post) ->
        ReportLink.post = post
        !post.isDead
  ready: ->
    $.off d, '4chanXInitFinished', ReportLink.ready
    ReportLink.toggle()
    $.on window, 'message', ReportLink.toggle
    $.on $('.close', ReportLink.dialog), 'click',     ReportLink.toggle
    $.on $('.move',  ReportLink.dialog), 'mousedown', ReportLink.drag
    $.on $('.jump',  ReportLink.dialog), 'click', ->
      Header.scrollTo ReportLink.post.nodes.root
    $.add d.body, ReportLink.dialog
  report: ->
    {post} = ReportLink
    url = "//sys.4chan.org/#{post.board}/imgboard.php?mode=report&no=#{post}"
    el  = $.el 'iframe', src: url
    $.extend el.style,
      width:  '610px'
      height: '117px'
      border: 'none'
    $('.move', ReportLink.dialog).textContent = "Report Post No.#{post.ID}"
    ReportLink.toggle false, el
  toggle: (e, el) ->
    return unless div = ReportLink.reportEmbed.firstChild
    if e
      return unless e.data and /^done-report/.test e.data
    if el
      ReportLink.lastEmbed = el
      $.replace div, el
      $.rmClass ReportLink.dialog, 'empty'
      return
    delete ReportLink.lastEmbed
    $.addClass ReportLink.dialog, 'empty'
    $.replace div, $.el 'div'
  drag: (e) ->
    {style} = ReportLink.reportEmbed
    if ReportLink.drag.mouseup
      $.off d, 'mouseup', ReportLink.drag
      ReportLink.drag.mouseup = false
      style.visibility = ''
      return
    $.on d, 'mouseup', ReportLink.drag
    ReportLink.drag.mouseup = true
    style.visibility = 'hidden'

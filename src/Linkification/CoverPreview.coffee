CoverPreview =
  init: ->
    return if g.VIEW is 'catalog' or !Conf['Cover Preview']

    @services = Embedding.services

    Post.callbacks.push
      name: 'Cover Preview'
      cb:   @node

  node: ->
    return unless @embeds
    for embed in @embeds when embed.service.preview
      CoverPreview.preview embed
    return

  preview: ({anchor, post, result, service}) ->
    $.on anchor, 'mouseover', (e) ->
      src = service.preview.call result[1]
      el = $.el 'img',
        src: src
        id: 'ihover'
      el.setAttribute 'data-fullid', post.fullID
      $.add d.body, el
      UI.hover
        # want el about mouse,
        # not right like normal ihover
        root: anchor
        el: el
        latestEvent: e
        endEvents: 'mouseout click'
        asapTest: -> el.height

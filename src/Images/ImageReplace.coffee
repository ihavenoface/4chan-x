ImageReplace =
  init: ->
    for type in ['JPG', 'PNG', 'GIF']
      if Conf["Replace #{type}"]
        unless @active
          @active = {}
        @active[type] = true
    return if g.VIEW is 'catalog' or !@active

    Post::callbacks.push
      name: 'Replace Image'
      cb:   @node
  node: ->
    return if @isClone or @isHidden or @thread.isHidden or !@file?.isImage
    {thumb, URL} = @file
    type = URL[-3..].toUpperCase()
    return unless ImageReplace.active[type] and !/spoiler/.test thumb.src
    if @file.isSpoiler
      {style} = thumb
      style.maxHeight = style.maxWidth = if @isReply then '125px' else '250px'
    img = $.el 'img'
    $.on img, 'load', ->
      thumb.src = URL
    img.src = URL

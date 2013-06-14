ImageReplaceLoaded =
  init: ->
    return if g.VIEW is 'catalog' or !(Conf['Replace Loaded Images'] and Conf['Image Hover'] or Conf['Image Expansion'])

    Post::callbacks.push
      name: 'Replace Loaded Image'
      cb:   @node

  node: ->
    return if @isClone or @isHidden or @thread.isHidden or !@file?.isImage
    {file, isReply} = @
    {thumb, URL} = file
    type = URL[-3..].toUpperCase()
    return if ImageReplace.active[type] and /spoiler/.test thumb.src

    if Conf['Image Hover']
      $.on thumb, 'mouseover', ->
        ImageReplaceLoaded.replace.call {isReply, thumb, src: URL}

    if Conf['Image Expansion']
      $.on thumb, 'click', ->
        $.asap (-> file.fullImage), ->
          ImageReplaceLoaded.replace.call {isReply, thumb, src: file.fullImage.src}

  replace: ->
    return if @thumb.src is @src
    if @isSpoiler
      {style} = @thumb
      style.maxHeight = style.maxWidth = if @isReply then '125px' else '250px'
    @thumb.src = @src


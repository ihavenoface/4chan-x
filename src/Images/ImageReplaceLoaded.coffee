ImageReplaceLoaded =
  init: ->
    return if g.VIEW is 'catalog' or !Conf['Replace Loaded Images']

    Post.callbacks.push
      name: 'Replace Loaded Image'
      cb:   @node

  node: ->
    return if @isHidden or @thread.isHidden or !@file?.isImage
    {file, isReply} = @
    {thumb, URL} = file
    type = URL[-3..].toUpperCase()
    return if ImageReplace.active[type] or /spoiler/.test thumb.src

    if Conf['Image Hover']
      $.on thumb, 'mouseover', ->
        ImageReplace.replace.call {file, isReply, thumb, src: URL}

    if Conf['Image Expansion']
      $.on thumb, 'click', ->
        $.asap (-> file.fullImage), ->
          ImageReplace.replace.call {file, isReply, thumb, src: file.fullImage.src}

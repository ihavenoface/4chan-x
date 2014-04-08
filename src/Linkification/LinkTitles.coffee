LinkTitles =
  init: ->
    return if g.VIEW is 'catalog' or !Conf['Link Titles']

    @services = Embedding.services

    $.get 'cachedTitles', {}, ({cachedTitles}) ->
      for key, service of LinkTitles.services
        continue unless service.title
        LinkTitles.services[key].cachedTitles = cachedTitles[service.name] or= {}
      LinkTitles.cachedTitles = cachedTitles

    Post.callbacks.push
      name: 'Link Titles'
      cb:   @node

  node: ->
    return unless @embeds
    for embed in @embeds when embed.service.title
      LinkTitles.changeTitle embed
    return

  changeTitle: (embed) ->
    {anchor, result, service} = embed
    {name} = service
    res = result[1]
    if title = service.cachedTitles?[res]
      return LinkTitles.cb.changeTitle anchor, title, name
    url = service.titleURL.call {anchor, result}
    $.cache url, ->
      try
        response = JSON.parse @response
      catch
        return
      title = service.title.call response
      if @status in [200, 304] and title
        LinkTitles.cachedTitles[name][res] = title
        $.set 'cachedTitles', LinkTitles.cachedTitles
        LinkTitles.cb.changeTitle anchor, title, name

  cb:
    changeTitle: (anchor, title, name) ->
      anchor.textContent = title
      $.addClass anchor, 'title'
      $.addClass anchor, name.toLowerCase()

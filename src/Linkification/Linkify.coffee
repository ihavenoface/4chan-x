Linkify =
  init: ->
    return if g.VIEW is 'catalog' or !Conf['Linkification']
    @catchAll = ///([a-z]*:(?://|\?)[^\s/$\.\\\#><].|(\w[\w-\.]*(@[\w-\.]*)?\.(?:a(?:e(?:ro)?|s(?:ia)?|r(?:pa)?|[cdfgilmnoqtuwxz])|b(?:iz?|[abdefghjmnorstvwyz])|c(?:at?|o(?:(?:op|m))?|[cdfghiklmnruvxyz])|e(?:du|[cegrstu])|g(?:ov|[abdefghilmnpqrstuwy])|i(?:n(?:(?:fo|t))?|[delmoqrst])|j(?:o(?:bs)?|[emp])|m(?:il|o(?:bi)?|u(?:seum)?|[acdeghklnprstvwxyz])|n(?:a(?:me)?|et?|om?|[cfgilpruz])|org|p(?:ro?|[aefghkmnstwy])|t(?:el|r(?:avel)?|[cdfghjklmnoptvwz])|d[ejkmoz]|f[ijkmor]|h[kmnrtu]|k[eghimnprwyz]|l[abcikrstuvy]|qa|r[easuw]|s[abcdegijklmnortuvyz]|u[agksyz]|v[aceginu]|w[fs]|y[etu]|z[amw])(?![\d\w])))[^\s><]*///i
    @protocol = ///((?:http(?:://|s://)|ftp(?:://|s://)|ma(?:gnet:\??|ilto:)|irc:(?://)?|r(?:mtp://|tmp(?:t://|s://))|byond://)[^\s/$.?\#].|www\.)[^\s><]*///i

    @globalCatchAll = new RegExp @catchAll.source, 'g'

    Post::callbacks.push
      name: 'Linkification'
      cb:   @node

  node: ->
    return if @isClone or @isHidden or @thread.isHidden or !links = @info.comment.match Linkify.globalCatchAll

    for link in links
      if /www\.4chan\.org/i.test link
        continue
      if /["',;)\]?\.]$/.test link
        link = link[...-1]
      if Linkify.matchingProtocol = Linkify.protocol.exec link
        link = Linkify.matchingProtocol[0]
      else if /\.{2}|-{2}/.test link
        continue

      href = if !/^www/.test(link) and Linkify.matchingProtocol or /^\w+:\/\//.test link
        link
      else if /@/.test link
        "mailto:#{link}"
      else
        "http://#{link}"
      Linkify.href     = href.replace /\\/g, '\/'
      Linkify.link     = link
      Linkify.length   = link.length
      Linkify.seeking  = false
      Linkify.found    = false
      Linkify.nodes    = []

      for child in @nodes.comment.childNodes
        Linkify.seek child
        break if Linkify.found
    return

  seek: (node) ->
    return unless node

    switch node.localName or node.nodeName
      when '#text'
        break
      when 'wbr'
        if @seeking
          @container.nodes.push node
        return
      when 's'
        return if $$('s', node).length
        if (nodes = node.childNodes).length is 1
          node = node.firstChild
          inSpoiler = true
          break
        if node.textContent.length >= @length
          for child in nodes
            @seek child
            break if @found
        return
      when 'span'
        for child in node.childNodes
          @seek child
          break if @found
        return
      else
        return
    if @seeking
      @current += node.data
      if inSpoiler
        if Conf['Clean Links']
          $.replace node.parentNode, node
        else
          node = node.parentNode
      if @length > @current.length
        @container.nodes.push node
      else
        if after = @current[@length...]
          node.data = node.data[...-after.length]
        @container.nodes.push node
        a = Linkify.anchor @href
        $.add a, @container.nodes
        @nodes.push a
        @nodes.push $.tn after if after
        $.replace @container.entry, @nodes
        @found = true
      return

    unless data = node.data
      return

    if (index = data.indexOf @link) >= 0
      if inSpoiler
        node = node.parentNode
      if index
        @nodes.push $.tn data[...index]
      a = Linkify.anchor @href
      a.textContent = @link
      @nodes.push a
      if data = data[index + @length..]
        @nodes.push $.tn data
      $.replace node, @nodes
      @found = true
      return

    unless result = @[if @matchingProtocol then 'protocol' else 'catchAll'].exec data
      return

    [start] = result
    {index, input} = result
    unless @link[...start.length] is start
      return

    if inSpoiler
      if Conf['Clean Links']
        $.replace node.parentNode, node
      else
        node = node.parentNode

    if index
      @nodes.push $.tn input[...index]
      node.data = start
    @container =
      nodes: [node.cloneNode true]
      entry: node
    @current = start
    @seeking = true

  anchor: (href) ->
    $.el 'a',
      target: '_blank'
      rel: 'nofollow noreferrer'
      href: href

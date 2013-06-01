Linkify =
  init: ->
    return if g.VIEW is 'catalog' or !Conf['Linkification']
    @catchAll = /(?:(?:([a-z]+):)?(?:(?:\?xt=urn[^\s<>]*)|(?:\/\/)?(?:\S+(?::\S*)?@)?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]){1,3})|(?!w{2}\.4chan\.org)([a-zA-Z\u00a1-\uffff0-9][a-zA-Z\u00a1-\uffff0-9\-\.]+)(?:\.([a-z\u00a1-\uffff]{2,}))))(?::\d{2,5})?(?:[\/#][^\s<>]*)?)/i

    @tld = /a(?:e(?:ro)?|s(?:ia)?|r(?:pa)?|[cdfgilmnoqtuwxz])|b(?:iz?|[abdefghjmnorstvwyz])|c(?:at?|o(?:(?:op|m))?|[cdfghiklmnruvxyz])|e(?:du|[cegrstu])|g(?:ov|[abdefghilmnpqrstuwy])|i(?:n(?:(?:fo|t))?|[delmoqrst])|j(?:o(?:bs)?|[emp])|m(?:il|o(?:bi)?|u(?:seum)?|[acdeghklnprstvwxyz])|n(?:a(?:me)?|et?|om?|[cfgilpruz])|org|p(?:ro?|[aefghkmnstwy])|t(?:el|r(?:avel)?|[cdfghjklmnoptvwz])|d[ejkmoz]|f[ijkmor]|h[kmnrtu]|k[eghimnprwyz]|l[abcikrstuvy]|qa|r[easuw]|s[abcdegijklmnortuvyz]|u[agksyz]|v[aceginu]|w[fs]|y[etu]|z[amw]/i

    @globalCatchAll = new RegExp @catchAll.source + '\\b', 'g'

    Post::callbacks.push
      name: 'Linkification'
      cb:   @node

  node: ->
    return if @isClone or @isHidden or @thread.isHidden or !links = @info.comment.match Linkify.globalCatchAll

    for link in links
      [link, protocol, domain, tld] = link.match Linkify.catchAll
      if /\.{2}|-{2}/.test domain # https://code.google.com/p/chromium/issues/detail?id=146162
        continue # V8 doesn't like complex regex it seems.

      if !protocol
        unless (tld?.match Linkify.tld)?[0] is tld
          continue
        subdomain = domain?.match(/^\w*\./)?[0][...-1]

      href = if protocol
        link
      else if /@/.test link
        "mailto:#{link}"
      else if subdomain in ['ftp', 'ftps' ,'irc']
        "#{subdomain}://#{link}"
      else
        "http://#{link}"

      Linkify.href     = href
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
        return
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

    unless result = @catchAll.exec data
      return

    {index, input} = result
    start = input[index..]
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

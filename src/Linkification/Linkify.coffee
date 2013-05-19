Linkify =
  init: ->
    return if g.VIEW is 'catalog' or !Conf['Linkification']
    @catchAll = ///((([a-z]+?:(?://)?[^\s/$\.\#].)|(\w+[\.-]?)+\.(?:a(?:e(?:ro)?|s(?:ia)?|r(?:pa)?|[cdfgilmnoqtuwxz])|b(?:iz?|[abdefghjmnorstvwyz])|c(?:at?|o(?:(?:op|m))?|[cdfghiklmnruvxyz])|e(?:du|[cegrstu])|g(?:ov|[abdefghilmnpqrstuwy])|i(?:n(?:(?:fo|t))?|[delmoqrst])|j(?:o(?:bs)?|[emp])|m(?:il|o(?:bi)?|u(?:seum)?|[acdeghklnprstvwxyz])|n(?:a(?:me)?|et?|om?|[cfgilpruz])|org|p(?:ro?|[aefghkmnstwy])|t(?:el|r(?:avel)?|[cdfghjklmnoptvwz])|d[ejkmoz]|f[ijkmor]|h[kmnrtu]|k[eghimnprwyz]|l[abcikrstuvy]|qa|r[easuw]|s[abcdegijklmnortuvyz]|u[agksyz]|v[aceginu]|w[fs]|y[etu]|z[amw])(?![\d\w])))[^\s]*///i
    @protocol = ///(?:http(?:://|s://)|ftp(?:://|s://)|ma(?:gnet:\??|ilto:)|irc:(?://)?|r(?:mtp://|tmp(?:t://|s://))|byond://)[^\s/$.?\#].[^\s]*///i

    @globalCatchAll = new RegExp @catchAll.source, 'g'

    Post::callbacks.push
      name: 'Linkification'
      cb:   @node

  node: ->
    return if @isClone or @isHidden or @thread.isHidden or !links = @info.comment.match Linkify.globalCatchAll

    for spoiler in $$ 's', @nodes.comment
      # Should be added to the loop after.
      if (prev = spoiler.previousSibling)?.data
        prev.data += spoiler.textContent
      if (next = spoiler.nextSibling)?.data
        prev.data += next.data
        $.rm next
      if prev
        $.rm spoiler

    for link in links
      if /www\.4chan\.org/i.test link
        continue
      if /["',;)\]?\.]$/.test link
        link = link[...-1]
      if Linkify.matchingProtocol = Linkify.protocol.exec link
        link = Linkify.matchingProtocol[0]
      Linkify.link      = link
      Linkify.length    = link.length
      Linkify.seeking   = false
      Linkify.found     = false
      Linkify.nodes     = []
      Linkify.container = []

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
      when 's', 'span'
        unless @seeking
          for child in node.childNodes
            @seek child
          return
        node = node.firstChild
      else
        return
    if @seeking
      @current += node.data
      if @length > @current.length
        @container.nodes.push node
      else
        @found = true
        if after = @current[@length...]
          node.data = node.data[...-after.length]
        @container.nodes.push node
        a = Linkify.anchor @container.href
        $.add a, @container.nodes
        @nodes.push a
        @nodes.push $.tn after if after
        $.replace @container.entry, @nodes
      return

    unless data = node.data
      return
    unless result = @[if @matchingProtocol then 'protocol' else 'catchAll'].exec data
      return

    [start] = result
    {index, input} = result
    if index
      @nodes.push $.tn input[...index]

    href = if @matchingProtocol or /^\w+:\/\//.test @link then @link else "http://#{@link}"
    href = href.replace /\\/g, '\/'

    if @length is start.length
      a = Linkify.anchor href
      a.textContent = @link
      @nodes.push a
      if data = input[index + @length..]
        @nodes.push $.tn data
      $.replace node, @nodes
      @found = true
      return

    if @length > start.length
      if index
        node.data = start
      @container =
        nodes: [node.cloneNode true]
        entry: node
        href:  href
      @current = start
      @seeking = true

  anchor: (href) ->
    $.el 'a',
      target: '_blank'
      rel: 'nofollow noreferrer'
      href: href

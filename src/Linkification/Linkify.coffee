Linkify =
  init: ->
    return if g.VIEW is 'catalog' or !Conf['Linkification']
    @catchAll = ///(((?:ftp(?:://|s://)|http(?:://|s://)|ma(?:gnet://|ilto://)|irc://)[^\s/$\.?\#].)|[^\s]*\.(?:a(?:e(?:ro)?|s(?:ia)?|r(?:pa)?|[cdfgilmoqtuwxz])|b(?:iz?|[abdefghjmnorstvwz])|c(?:at?|o(?:(?:op|m))?|[cdfghiklmnruvxyz])|e(?:du|[cegrstu])|g(?:ov|[abdefghlmnpqrstuwy])|i(?:n(?:fo|t)|[delmoqrst])|j(?:o(?:bs)?|[em])|m(?:il|o(?:bi)?|u(?:seum)?|[acdeghklnprstvwxyz])|n(?:a(?:me)?|et?|om|[cfgilpruz])|org|p(?:ro?|[aefghklmstw])|t(?:el|r(?:avel)?|[cdfgjklmnoptvwz])|d[ejkmoz]|f[ijkmor]|h[kmnrtu]|k[eghimnprwyz]|l[abcikrstuvy]|qa|r[easuw]|s[abcdeghijklmnortuvyz]|u[agksyz]|v[aceginu]|w[fs]|y[etu]|z[amw]))[^\s]*///gi
    @protocol = ///(?:ftp(?:://|s://)|http(?:://|s://)|ma(?:gnet://|ilto://)|irc://)[^\s/$.?\#].[^\s]*///gi

    Post::callbacks.push
      name: 'Linkification'
      cb:   @node

  node: ->
    return if @isClone or @isHidden or @thread.isHidden or !links = @info.comment.match Linkify.catchAll

    for link in links
      seeking = false
      nodes = []
      for node in @nodes.comment.childNodes
        continue unless node

        if seeking
          switch node.localName or node.nodeName
            when '#text'
              break
            when 'wbr'
              container.nodes.push node
              continue
            when 's'
              current += node.firstChild.data
              container.nodes.push node
              continue
            else
              continue
          current += node.data
          if link.length > current.length
            container.nodes.push node
            continue
          else
            if after = current[link.length...]
              node.data = node.data[...-after.length]

            container.nodes.push node
            a = $.el 'a',
              target: '_blank'
              rel: 'nofollow noreferrer'
              href: container.href

            $.add a, container.nodes
            nodes.push a
            nodes.push $.tn after if after
            $.replace container.entry, nodes
            break
          continue
        unless data = node.data
          continue
        prot = Linkify.protocol.exec data
        unless result = prot or Linkify.catchAll.exec data
          continue
        if prot and prot.index
          nodes.push $.tn data[...prot.index]
          data = node.data = data[prot.index..]

        if (index = data.indexOf link) >= 0
          if index
            nodes.push $.tn data[...index]
          a = $.el 'a',
            target: '_blank'
            rel: 'nofollow noreferrer'
            href: link
            textContent: link
          nodes.push a
          data = data[index + link.length..]
          if data
            nodes.push $.tn data
          $.replace node, nodes
          break

        if link.indexOf(data) >= 0
          container =
            nodes:  [node.cloneNode true]
            entry:  node
            href:   link
          current = data
          seeking = true
          continue
    return

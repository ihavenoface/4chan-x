Linkify =
  init: ->
    return if g.VIEW is 'catalog' or !Conf['Linkification']
    @catchAll = ///(((?:http(?:://|s://)|ftp(?:s://|://)|ma(?:gnet:|ilto:)|irc:(?://)?)[^\s/$\.?\#].)|[^\s]*\.(?:a(?:e(?:ro)?|s(?:ia)?|r(?:pa)?|[cdfgilmoqtuwxz])|b(?:iz?|[abdefghjmnorstvwz])|c(?:at?|o(?:(?:op|m))?|[cdfghiklmnruvxyz])|e(?:du|[cegrstu])|g(?:ov|[abdefghlmnpqrstuwy])|i(?:n(?:fo|t)|[delmoqrst])|j(?:o(?:bs)?|[em])|m(?:il|o(?:bi)?|u(?:seum)?|[acdeghklnprstvwxyz])|n(?:a(?:me)?|et?|om|[cfgilpruz])|org|p(?:ro?|[aefghklmstw])|t(?:el|r(?:avel)?|[cdfgjklmnoptvwz])|d[ejkmoz]|f[ijkmor]|h[kmnrtu]|k[eghimnprwyz]|l[abcikrstuvy]|qa|r[easuw]|s[abcdeghijklmnortuvyz]|u[agksyz]|v[aceginu]|w[fs]|y[etu]|z[amw]))[^\s]*///i
    @protocol = ///(?:http(?:://|s://)|ftp(?:s://|://)|ma(?:gnet:|ilto:)|irc:(?://)?)[^\s/$.?\#].[^\s]*///i

    @globalCatchAll = new RegExp @catchAll.source, 'g'

    Post::callbacks.push
      name: 'Linkification'
      cb:   @node

  node: ->
    return if @isClone or @isHidden or @thread.isHidden or !links = @info.comment.match Linkify.globalCatchAll

    for link in links
      if protocol = Linkify.protocol.exec link
        if protocol.index
          link = protocol[0]
        else
          protocol = false
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
        unless result = Linkify[if protocol then 'protocol' else 'catchAll'].exec data
          continue

        {index, input} = result
        if index
          nodes.push $.tn input[...index]

        href = if result[2] then link else "http://#{link}"

        if link.length is result[0].length
          a = $.el 'a',
            target: '_blank'
            rel: 'nofollow noreferrer'
            href: href
            textContent: link
          nodes.push a
          if data = input[index + link.length..]
            nodes.push $.tn data
          $.replace node, nodes
          break

        if link.length > result[0].length
          if index
            node.data = data = result[0]
          container =
            nodes:  [node.cloneNode true]
            entry:  node
            href:   href
          current = data
          seeking = true
          continue

    return

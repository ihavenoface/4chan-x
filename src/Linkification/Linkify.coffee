Linkify =
  init: ->
    return if g.VIEW is 'catalog' or !Conf['Linkification']
    @regex = ///((ht|f)tp(s?)://|www\.|(mailto|magnet):){1}\S+///gi
    Post::callbacks.push
      name: 'Linkification'
      cb:   @node

  node: ->
    return if @isClone or @isHidden or @thread.isHidden or !links = @info.comment.match Linkify.regex

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
            container.nodes.push node
            a = $.el 'a',
              target: '_blank'
              rel: 'nofollow noreferrer'
              href: container.href
            $.add a, container.nodes
            $.replace container.entry, a
            break
          continue
        continue unless data = node.data
        continue unless data.match Linkify.regex
        href =
          if /^www/.test link
            "http://#{link}"
          else
            link
        if (index = data.indexOf link) >= 0
          if text = data[...index]
            nodes.push $.tn text
          a = $.el 'a',
            target: '_blank'
            rel: 'nofollow noreferrer'
            href: href
            textContent: link
          nodes.push a
          data = data[index + link.length..]
          if data
            nodes.push $.tn data
          $.replace node, nodes
          break

        if link.indexOf(data) >= 0
          container =
            nodes: [node.cloneNode true]
            entry: node
            href:  href
          current = data
          seeking = true
          continue

    return

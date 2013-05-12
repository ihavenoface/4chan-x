Linkify =
  init: ->
    return if g.VIEW is 'catalog' or !Conf['Linkification']
    @regex = ///((((ht|f)tp(s?)://|www\.|(mailto|magnet):)[^\s/$.?\#].)|[^\s]*\.(org|a(rpa|ero|sia|c-g|i|m-o|q-u|w-z)|b(iz|a|b|e-j|m-o|r-t|v|w-z)|c(om|at|oop|a|c-o|r|u|v|x-z)|d(e|j|k|m|o|z)|e(du|c|e|g|r-u)|f(i-k|m|o|r)|g(ov|a|b|d|e-i|l|m|n|p|r-w|y)|h(k|m|n|r|t|u)|i(nfo|nt|d|e|l|m-t)|j(obs|e|m-p)|k(e|g-i|m|n|p|r|w|y|z)|l(a-c|i|k|r-v|y)|m(il|obi|useum|a-e|g-p|r-z)|n(ame|et|a|c|e-g|i|l|o|p|r|u|z|om)|p(ro|a|e-h|k-n|r-t|w|y)|qa|r(e|a|s|u|w)|s(a|b-e|g-o|r|t-v|y|z)|t(el|ravel|c|d|f-p|r|t|v|w|z)|u(a|g|k|s|y|z)|v(a|c|e|g|i|n|u)|w(f|s)|y(e|t|u)|z(a|m|w)))[^\s]*///gi

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

Linkify =
  init: ->
    return if g.VIEW is 'catalog' or !Conf['Linkification']
    @regex = ///((((ht|f)tp(s?)://|www\.|(mailto|magnet):)[^\s/$.?\#].)|[^\s]*\.(aero|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel|ac|ad|ae|af|ag|ai|al|am|an|ao|aq|ar|as|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|co|cr|cu|cv|cx|cy|cz|cz|de|dj|dk|dm|do|dz|ec|ee|eg|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|in|io|iq|ir|is|it|je|jm|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mk|ml|mn|mn|mo|mp|mr|ms|mt|mu|mv|mw|mx|my|mz|na|nc|ne|nf|ng|ni|nl|no|np|nr|nu|nz|nom|pa|pe|pf|pg|ph|pk|pl|pm|pn|pr|ps|pt|pw|py|qa|re|ra|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sj|sk|sl|sm|sn|so|sr|st|su|sv|sy|sz|tc|td|tf|tg|th|tj|tk|tl|tm|tn|to|tp|tr|tt|tv|tw|tz|ua|ug|uk|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|ye|yt|yu|za|zm|zw|arpa))[^\s]*///gi

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

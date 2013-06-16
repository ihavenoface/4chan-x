Linkify =
  init: ->
    return if g.VIEW is 'catalog' or !Conf['Linkify'] and !Conf['Embedding'] and !Conf['Link Titles']

    @catchAll = /(?:(?:([a-zA-Z]+)(?::|%[0-9a-fA-F]{2}))?(?:(?:(?:\?|%[0-9a-fA-F]{2})xt(?:=|%[0-9a-fA-F]{2})urn(?::|%[0-9a-fA-F]{2})[^\s<>]*)|(?:\/{2}|(?:%[0-9a-fA-F]{2}){2})?(?:\b\S+(?::\S*)?(@))?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]){1,3})|(?:\b)([a-zA-Z\u00a1-\uffff0-9][a-zA-Z\u00a1-\uffff0-9\-\.]+)(\.[a-zA-Z\u00a1-\uffff0-9]{2,})))(?::\d{2,5})?((?:[\/#]|%[0-9a-fA-F]{2})[^\s<>]*)?)/i

    @tld = /^(?:a(?:e(?:ro)?|r(?:pa)?|s(?:ia)?|[cdfgilmnoqtuwxz])|b(?:iz?|[abdefghjmnorstvwyz])|c(?:at?|o(?:(?:op|m))?|[cdfghiklmnrsuvxyz])|i(?:n(?:(?:fo|t))?|[delmoqrst])|j(?:o(?:bs)?|[emp])|m(?:o(?:bi)?|u(?:seum)?|il|[acdeghklmnpqrstvwxyz])|n(?:a(?:me)?|et?|[cfgilopruz])|o(?:rg|m)|p(?:ost|ro?|[aefghklmnstwy])|t(?:el|r(?:avel)?|[cdfghjklmnoptvwz])|xxx|e(?:du|[ceghrstu])|g(?:ov|[abdefghilmnpqrstuwy])|d[dejkmoz]|f[ijkmor]|h[kmnrtu]|k[eghimnprwyz]|l[abcikrstuvy]|qa|r[eosuw]|s[abcdeghijklmnorstuvxyz]|u[agksyz]|v[aceginu]|w[fs]|y[etu]|z[amw])$/i

    @globalCatchAll = new RegExp @catchAll.source, 'g'

    if Conf['Link Titles']
      $.get 'cachedTitles', {}, (item) ->
        Linkify.cachedTitles = item.cachedTitles
        for key, service of Linkify.embeds
          {name} = service
          if service.title
            unless Linkify.cachedTitles[name]
              Linkify.cachedTitles[name] = {}
            Linkify.embeds[key].cachedTitles = Linkify.cachedTitles[name]
        return

    Post::callbacks.push
      name: 'Linkify'
      cb:   @node

  node: ->
    if @isClone
      # here be handling for inline
      return
    return if @isHidden or @thread.isHidden or !links = @info.comment.match Linkify.globalCatchAll

    for link in links
      [link, protocol, isEmail, domain, tld, resource] = link.match Linkify.catchAll
      if /\.{2}|-{2}|w{3}\.4chan\.org/.test domain + tld
        # https://code.google.com/p/chromium/issues/detail?id=146162
        # V8 doesn't like complex regex it seems.
        continue
      if tld and !isEmail and !resource
        if !Linkify.tld.test pastDot = tld[1..]
          continue
        if @board.ID is 'g' and /^p[ly]|sh$/.test pastDot
          continue

      if !protocol and isEmail and resource
        link = link[...-resource.length]

      link = Linkify.trim link
      if /\)$/.test(link) and close = link.match /\)/g
        open = link.match(/\(/g) or ''
        if close.length > open.length
          link = Linkify.trim link[...-close.length - open.length]

      try
        URI = decodeURIComponent link
        if protocol is 'magnet'
          URI = link
      catch err
        continue

      if !protocol and !isEmail
        subdomain = URI.match(/^[a-z]+(?=\.)/)?[0]

      href = if protocol
        [URI, protocol is 'magnet']
      else if isEmail
        ["mailto:#{URI}", true]
      else if /^ftps?|irc$/.test subdomain
        ["#{subdomain}://#{URI}", subdomain is 'irc']
      else
        ["http://#{URI}"]

      if domain and tld
        fullDomain = (domain + tld).toLowerCase()
      for service in Linkify.embeds
        break if valid = service.domains.test fullDomain
      if !Conf['Linkify']
        if !valid or Conf['Link Titles'] and !service.title
          continue

      Linkify.seeking    = false
      Linkify.seek.nodes = []

      for child in @nodes.comment.childNodes
        break if info = Linkify.seek child, link, href
      if typeof info is 'object'
        {a, node} = info
        $.replace node, Linkify.seek.nodes
      else
        continue

      result = service.regex.exec fullDomain + decodeURI resource
      if Conf['Embedding'] and result
        toggle = $.el 'a',
          textContent: 'Embed'
          href: a.href
        $.on toggle, 'click', (e) ->
          Linkify.toggle e
        garbage = /^(?:(?:\u0020+)?[\[\(]embed[\)\]](?:\u0020+)?)+/i
        if garbage.test (next = a.nextSibling)?.data
          next.data = next.data.replace garbage, ''
        $.after a, [$.tn '\u0020['; toggle, $.tn ']']
        a.embedding =
          info:    {link, protocol, domain, tld, resource, result}
          toggle:  toggle
          service: service
      if Conf['Link Titles'] and result and service.title
        Linkify.title a, result, service
    return

  seek: (node, link, href) ->
    return if !node or node.sought
    node.sought = true

    switch node.localName or node.nodeName
      when '#text'
        break
      when 'wbr'
        if @seeking
          @container.nodes.push node
        return
      when 's'
        if $$('s', node).length
          return true
        if (nodes = node.childNodes).length is 1
          inSpoiler = node
          node = node.firstChild
          break
        if node.textContent.length >= @length
          for child in nodes
            break if info = @seek child, link, href
        return info
      when 'span'
        for child in node.childNodes
          break if info = @seek child, link, href
        return info
      else
        return
    if @seeking
      @current += node.data
      if inSpoiler
        if Conf['Clean Links']
          $.replace inSpoiler, node
        else
          node = inSpoiler
      if link.length > @current.length
        @container.nodes.push node
        return
      if after = @current[link.length...]
        node.data = node.data[...-after.length]
      @container.nodes.push node
      a = Linkify.anchor href
      $.add a, @container.nodes
      {nodes} = @seek
      nodes.push a
      nodes.push $.tn after if after
      return {a, node: @container.entry}

    unless data = node.data
      return

    if (index = data.indexOf link) >= 0
      {nodes} = @seek
      if inSpoiler
        node = inSpoiler
      if index
        nodes.push $.tn data[...index]
      a = Linkify.anchor href
      a.textContent = link
      nodes.push a
      if data = data[index + link.length..]
        nodes.push $.tn data
      return {a, node}

    return unless next = (inSpoiler or node).nextSibling
    if next.localName is 'wbr'
      next = next.nextSibling
    return if !next or next.localName is 'a' or !nextData = next.textContent
    index = 0
    while index isnt data.length
      start = data[index++..]
      if link[...start.length] is start
        index--
        break
    guess = start + nextData
    return unless start and link[...guess.length] is guess or guess.indexOf(link) >=0

    if index
      {nodes} = @seek
      nodes.push $.tn data[...index]
      node.data = start

    if inSpoiler
      if Conf['Clean Links']
        $.replace inSpoiler, node
      else
        node = inSpoiler
    @container =
      nodes: [node.cloneNode true]
      entry: node
    @current = start
    @seeking = true
    return

  anchor: (href) ->
    [URI, thisTab] = href
    a = $.el 'a',
      target: if thisTab then '' else '_blank'
      rel:    'noreferrer'
      href:   URI

  trim: (link) ->
    if close = link.match /["',;:\]?.]+$/
      link[...close.index]
    else
      link

  toggle: (e) ->
    e.preventDefault()
    {which, target} = e
    return unless which is 1
    if target.textContent is 'Embed'
      a = target.previousElementSibling
      embed = a.embedding
      {result} = embed.info
      return embed.service.embedURL.call {result, target, href: target.href}
    if target.textContent is 'Unembed'
      media = target.nextSibling.nextSibling
      $.rm media if media.className is 'media-embed'
      target.textContent = 'Embed'

  title: (a, result, service) ->
    res = result[1]
    if title = service.cachedTitles[res]
      return Linkify.cb.title.call {a, service, title}
    {name} = service
    url = service.titleURL.call {a, result}
    $.cache url, ->
      if @status in [200, 304] and title = service.title.call JSON.parse @response
        Linkify.cachedTitles[name][res] = title
        $.set 'cachedTitles', Linkify.cachedTitles
        Linkify.cb.title.call {a, service, title}
      else
        return unless toggle = a.embedding.toggle
        for el in [toggle.previousSibling, toggle.nextSibling, toggle]
          $.rm el
        return
  cb:
    title: ->
      @a.textContent = @title
      if @service.icon
        @a.style.cssText = "background: transparent url('data:image/png;base64,#{@service.icon}') left bottom 1px no-repeat; padding-left: 18px;"

    embed: ->
      div = $.el 'div',
        className: 'media-embed'
      if @style
        $.extend @el.style, Linkify.embeds[@style].style
      $.add div, @el
      $.after @target.nextSibling, div
      @target.textContent = 'Unembed'

  embeds: [
    {
      name: 'YouTube'
      style:
        border: 'none'
        width:  '640px'
        height: '360px'
      icon: '<%= grunt.file.read("img/embeds/YouTube.png", {encoding: "base64"}) %>'
      domains: /^(?:youtu(?:\.be|be\.com)|www\.youtu(?:\.be|be\.com)|m\.youtube\.com)$/
      regex: /(?:v[=\/]|#p\/[a-z]\/.+\/|youtu\.be\/)([a-z0-9_-]+)(?:.*[#&\?]t=([0-9hms]+))?/i
      title: -> @entry.title.$t
      titleURL: -> "https://gdata.youtube.com/feeds/api/videos/#{@result[1]}?alt=json&fields=title/text(),yt:noembed,app:control/yt:state/@reasonCode"
      embedURL: ->
        [_, name, time] = @result
        time = if time then "#t=#{time}" else ''
        el = $.el 'iframe',
          src: "https://youtube.com/embed/#{name}?rel=1&autohide=1#{time}"
        Linkify.cb.embed.call {el, style: '0', target: @target}
      results: true
    }, {
      name: 'SoundCloud'
      icon: '<%= grunt.file.read("img/embeds/SoundCloud.png", {encoding: "base64"}) %>'
      domains: /^(?:s(?:nd\.sc|oundcloud\.com)|www\.s(?:nd\.sc|oundcloud\.com)|m\.soundcloud\.com)$/
      regex: /\.(?:sc|com)\/([^#\&\?]+)/i
      title: -> @title
      titleURL: -> "https://soundcloud.com/oembed?&format=json&url=#{@a.href}"
      embedURL: ->
        url = "https://soundcloud.com/oembed?show_artwork=false&maxwidth=500px&show_comments=false&format=json&iframe=true&url=#{@href}"
        {target} = @
        $.cache url, ->
          if @status in [200, 304]
            el = $.el 'div',
              innerHTML: JSON.parse(@response).html
            Linkify.cb.embed.call {el, target}
        return
    }, {
      name: 'Vocaroo'
      style:
        border: 'none'
        width:  '150px'
        height: '45px'
      domains: /^vocaroo\.com$/
      regex: /vocaroo\.com\/i\/([a-zA-Z0-9]+)/i
      embedURL: ->
        el = $.el 'iframe',
          src: "http://vocaroo.com/player.swf?autoplay=0&playMediaID=#{@result[1]}"
        Linkify.cb.embed.call {el, style: '2', target: @target}
    }, {
      name: 'Vimeo'
      style:
        border: 'none'
        width:  '640px'
        height: '360px'
      icon: '<%= grunt.file.read("img/embeds/Vimeo.png", {encoding: "base64"}) %>'
      domains: /^vimeo\.com$/
      regex: /\/([^#\&\?]*)/i
      title: -> @title
      titleURL: -> "https://vimeo.com/api/oembed.json?url=#{@a.href}"
      embedURL: ->
        el = $.el 'iframe',
          src: "https://player.vimeo.com/video/#{@result[1]}"
        Linkify.cb.embed.call {el, style: '3', target: @target}
    }, {
      name: 'Pastebin'
      style:
        border: 'none'
        width:  '640px'
      domains: /^pastebin\.com$/
      regex: /pastebin\.com\/(?!u\/)([a-zA-Z0-9]+)/i
      embedURL: ->
        el = $.el 'iframe',
          src: "http://pastebin.com/embed_iframe.php?i=#{@result[1]}"
        Linkify.cb.embed.call {el, style: '4', target: @target}
    }, {
      name: 'Gist'
      style:
        border: 'none'
        width:  '640px'
        height: '360px'
      icon: '<%= grunt.file.read("img/embeds/Gist.png", {encoding: "base64"}) %>'
      domains: /^gist\.github\.com$/
      regex: /\/\w+\/(\d+)/i
      title: ->
        response = @files
        return file for file of response when response.hasOwnProperty file
      titleURL: -> "https://api.github.com/gists/#{@result[1]}"
      embedURL: ->
        el = $.el 'iframe',
          src: "http://www.purplegene.com/script?url=https://gist.github.com/#{@result[1]}.js"
        Linkify.cb.embed.call {el, style: '5', target: @target}
    }, {
      name: 'InstallGentoo'
      style:
        border: 'none'
        width:  '640px'
        height: '360px'
      domains: /^paste\.installgentoo\.com$/
      regex: /\/view\/(?:raw\/)?([a-zA-Z0-9]+)/i
      embedURL: ->
        el = $.el 'iframe',
          src: "http://paste.installgentoo.com/view/embed/#{@result[1]}"
        Linkify.cb.embed.call {el, style: '6', target: @target}
    }, {
      name: 'Imgur'
      style:
        border: 'none'
        cursor: 'pointer'
      domains: /^(i\.)?imgur\.com$/
      regex: /imgur\.com(?!\/a)\/([a-zA-Z0-9]+)(?:\.(?:a?png|jpg|gif))?/i
      embedURL: ->
        el = $.el 'img',
          # imgur/browser doesn't care about filetype so we
          # use this to embed files without type specified.
          src: "http://i.imgur.com/#{@result[1]}.png"
          className: 'image-embed'
        unless Linkify.style
          Linkify.style = $.addStyle null
          Linkify.embeds[7].resize()
          $.on window, 'resize', Linkify.embeds[7].resize
        {target} = @
        $.on el, 'click', ->
          $.rm el.parentNode
          target.textContent = 'Embed'
        Linkify.cb.embed.call {el, style: '7', target}
      resize: ->
        Linkify.style.textContent =
          ".media-embed .image-embed { max-height: #{parseInt innerHeight * .8}px; max-width: #{parseInt innerWidth * .8}px; }"
    }, {
      name: 'LiveLeak'
      style:
        border: 'none'
        width:  '640px'
        height: '360px'
      domains: /^(www\.)?liveleak.com$/
      regex: /(?:liveleak\.com\/view.+i=)([a-z]{3}_\d+)/i
      embedURL: ->
        el = $.el 'iframe',
          src: "http://www.liveleak.com/e/#{@result[1]}"
        Linkify.cb.embed.call {el, style: '8', target: @target}
    }
  ]

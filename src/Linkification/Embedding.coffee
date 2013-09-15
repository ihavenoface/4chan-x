Embedding =
  init: ->
    return if g.VIEW is 'catalog' or !Conf['Embedding'] and !Conf['Link Titles']

    if Conf['Link Titles']
      $.get 'cachedTitles', {}, ({cachedTitles}) ->
        for key, service of Embedding.embeds
          continue unless service.title
          Embedding.embeds[key].cachedTitles = cachedTitles[service.name] or= {}
        Embedding.cachedTitles = cachedTitles

    Post::callbacks.push
      name: 'Embedding'
      cb:   @node

  node: ->
    return unless (links = $$ '.linkified', @nodes.comment).length

    for link in links
      next = link.nextElementSibling
      if @isClone and next?.nodeName is 'A'
        [_, closed, open] = next.textContent.match /^(?:(Embed)|(Unembed))$/
        # why?
        if open
          $.rm next.nextElementSibling
        if open or closed
          $.rm next.nextSibling
          $.rm next.previousSibling
          $.rm next

      for service in Embedding.embeds
        if valid = service.domains.test link.hostname
          break
      result       = valid and service.regex.exec(link.href) or valid
      canEmbed     = !!(Conf['Embedding']     and result[1] and link.pathname)
      canLinkTitle = !!(Conf['Link Titles']   and result[1] and service.title)
      canPreview   = !!(Conf['Cover Preview'] and result[1] and service.preview)
      if !(canEmbed or canLinkTitle or canPreview)
        continue
      if canEmbed
        toggle = $.el 'a',
          textContent: 'Embed'
          href: link.href
        $.on toggle, 'click', (e) ->
          Embedding.toggle e
        garbage = /^(?:(?:\u0020+)?[\[(]embed[)\]](?:\u0020+)?)+/i
        if garbage.test (next = link.nextSibling)?.data
          next.data = next.data.replace garbage, ''
        $.after link, [$.tn '\u0020['; toggle, $.tn ']']
        # dont put that junk on the anchor, store it somewhere else
        link.embedding =
          info:    {link, protocol: link.protocol, domain: link.domain, result}
          toggle:  toggle
          service: service
      if canLinkTitle
        Embedding.title link, result, service
      if canPreview
        Embedding.preview link, result, service
    return

  toggle: (e) ->
    e.preventDefault()
    {which, target} = e
    return unless which is 1
    if target.textContent is 'Embed'
      a = target.previousElementSibling
      embed = a.embedding
      {result} = embed.info
      return embed.service.embedURL.call {result, target, href: target.href}
    else
      media = target.nextSibling.nextSibling
      $.rm media if media.className is 'media-embed'
      target.textContent = 'Embed'

  title: (a, result, service) ->
    res = result[1]
    if title = service.cachedTitles[res]
      return Embedding.cb.title.call {a, service, title}
    {name} = service
    url = service.titleURL.call {a, result}
    $.cache url, ->
      if @status in [200, 304] and title = service.title.call JSON.parse @response
        Embedding.cachedTitles[name][res] = title
        $.set 'cachedTitles', Embedding.cachedTitles
        return Embedding.cb.title.call {a, service, title}
      if Conf['Embedding'] and toggle = a.embedding.toggle
        for el in [toggle.previousSibling, toggle.nextSibling, toggle]
          $.rm el
      unless Conf['Linkify']
        $.replace a, [a.childNodes...]

  preview: (a, result, service) ->
    {preview} = service
    $.on a, 'mouseover', (e) ->
      return if a.embedding?.toggle.textContent is 'Unembed'
      preview.call {a, e, result}

  cb:
    title: ->
      @a.textContent = @title
      if @service.icon # move this to css
        @a.style.cssText = "background: transparent url('data:image/png;base64,#{@service.icon}') left bottom 1px no-repeat; padding-left: 18px;"

    embed: ->
      div = $.el 'div',
        className: 'media-embed'
      if @style
        $.extend @el.style, Embedding.embeds[@style].style
      $.add div, @el
      $.after @target.nextSibling, div
      @target.textContent = 'Unembed'

    preview: ->
      {a, e, src} = @
      el = $.el 'img',
        src: src
        id: 'ihover'
      post = Get.postFromNode a
      el.setAttribute 'data-fullid', post.fullID
      $.add d.body, el
      UI.hover
        root: a
        el: el
        latestEvent: e
        endEvents: 'mouseout click'
        asapTest: -> el.height

  embeds: [
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
      preview:  ->
        src = "https://img.youtube.com/vi/#{@result[1]}/0.jpg"
        Embedding.cb.preview.call {a: @a, e: @e, src}
      embedURL: ->
        [_, name, time] = @result
        time = if time then "#t=#{time}" else ''
        el = $.el 'iframe',
          src: "https://youtube.com/embed/#{name}?rel=1&autohide=1#{time}"
        Embedding.cb.embed.call {el, style: '0', target: @target}
      results: true
    ,
      name: 'SoundCloud'
      icon: '<%= grunt.file.read("img/embeds/SoundCloud.png", {encoding: "base64"}) %>'
      domains: /^(?:s(?:nd\.sc|oundcloud\.com)|www\.s(?:nd\.sc|oundcloud\.com)|m\.soundcloud\.com)$/
      regex: /\.(?:sc|com)\/([^#\&\?]+)/i
      # preview: ->
      #   {a, e} = @
      #   url = "https://soundcloud.com/oembed?format=json&url=#{a.href}"
      #   $.cache url, ->
      #     # probably nicer to fetch the url with title()
      #     if @status in [200, 304]
      #       src = JSON.parse(@response).thumbnail_url
      #       Embedding.cb.preview.call {a, e, src}
      title: -> @title
      titleURL: -> "https://soundcloud.com/oembed?&format=json&url=#{@a.href}"
      embedURL: ->
        url = "https://soundcloud.com/oembed?show_artwork=false&maxwidth=500px&show_comments=false&format=json&iframe=true&url=#{@href}"
        {target} = @
        $.cache url, ->
          if @status in [200, 304]
            el = $.el 'div',
              innerHTML: JSON.parse(@response).html
            Embedding.cb.embed.call {el, target}
        return
    ,
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
        Embedding.cb.embed.call {el, style: '2', target: @target}
    ,
      name: 'Vimeo'
      style:
        border: 'none'
        width:  '640px'
        height: '360px'
      icon: '<%= grunt.file.read("img/embeds/Vimeo.png", {encoding: "base64"}) %>'
      domains: /^vimeo\.com$/
      regex: /vimeo\.com\/(?:m\/)?(\d+)(?:.*[#&\?]t=([0-9hms]+))?/i
      title: -> @title
      titleURL: -> "https://vimeo.com/api/oembed.json?url=#{@a.href}"
      embedURL: ->
        [_, name, time] = @result
        time = if time then "#t=#{time}" else ''
        el = $.el 'iframe',
          src: "https://player.vimeo.com/video/#{name}#{time}"
        Embedding.cb.embed.call {el, style: '3', target: @target}
    ,
      name: 'Pastebin'
      style:
        border: 'none'
        width:  '640px'
        height: '500px'
      domains: /^pastebin\.com$/
      regex: /pastebin\.com\/(?!u\/)([a-zA-Z0-9]+)/i
      embedURL: ->
        el = $.el 'iframe',
          src: "http://pastebin.com/embed_iframe.php?i=#{@result[1]}"
        Embedding.cb.embed.call {el, style: '4', target: @target}
    ,
      name: 'Gist'
      style:
        border: 'none'
        width:  '640px'
        height: '500px'
      icon: '<%= grunt.file.read("img/embeds/Gist.png", {encoding: "base64"}) %>'
      domains: /^gist\.github\.com$/
      regex: /\/\w+\/(\d+)/i
      title: ->
        response = @files
        return file for file of response when response.hasOwnProperty file
      titleURL: -> "https://api.github.com/gists/#{@result[1]}"
      embedURL: ->
        el = $.el 'iframe',
          src: "data:text/html,<script src='https://gist.github.com/#{@result[1]}.js'></script>"
        Embedding.cb.embed.call {el, style: '5', target: @target}
    ,
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
        Embedding.cb.embed.call {el, style: '6', target: @target}
    ,
      name: 'imgur'
      style:
        border: 'none'
        cursor: 'pointer'
      domains: /^(i\.)?imgur\.com$/
      regex: /imgur\.com\/(?!a\/)([a-zA-Z0-9]+)(?:\.(?:a?png|jpg|gif))?/i
      embedURL: ->
        el = $.el 'img',
          # imgur/browser doesn't care about filetype so we
          # use this to embed files without type specified.
          src: "http://i.imgur.com/#{@result[1]}.png"
          className: 'image-embed'
        unless Embedding.style
          Embedding.style = $.addStyle null
          Embedding.embeds[7].resize()
          $.on window, 'resize', Embedding.embeds[7].resize
        {target} = @
        $.on el, 'click', ->
          $.rm el.parentNode
          target.textContent = 'Embed'
        Embedding.cb.embed.call {el, style: '7', target}
      resize: ->
        Embedding.style.textContent =
          ".media-embed .image-embed { max-height: #{parseInt innerHeight * .8}px; max-width: #{parseInt innerWidth * .8}px; }"
    ,
      name: 'LiveLeak'
      style:
        border: 'none'
        width:  '640px'
        height: '360px'
      domains: /^(www\.)?liveleak\.com$/
      regex: /liveleak\.com\/view.+i=([a-z]{3}_\d+)/i
      embedURL: ->
        el = $.el 'iframe',
          src: "http://www.liveleak.com/e/#{@result[1]}"
        Embedding.cb.embed.call {el, style: '8', target: @target}
    ,
      name: 'TwitchTV'
      style:
        border: 'none'
        width:  '640px'
        height: '360px'
      domains: /^(www\.)?twitch\.tv$/
      regex: /twitch\.tv\/(\w+)\/(?:b\/)?(\d+)/i
      embedURL: ->
        [_, channel, archive] = @result
        el = $.el 'object',
          data: 'http://www.twitch.tv/widgets/archive_embed_player.swf'
          innerHTML: """
            <param name='allowFullScreen' value='true' />
            <param name='flashvars' value='channel=#{channel}&start_volume=25&auto_play=false&archive_id=#{archive}' />
          """
        Embedding.cb.embed.call {el, style: '9',target: @target}
    ,
      name: 'Vine'
      style:
        border: 'none'
        width:  '500px'
        height: '500px'
      domains: /^(www\.)?vine\.co$/
      regex: /vine\.co\/(v\/[a-z0-9]+)/i
      embedURL: ->
        el = $.el 'iframe',
          src: "https://vine.co/#{@result[1]}/card"
        Embedding.cb.embed.call {el, style: '10', target: @target}
  ]

class Embed
  constructor: (@post, @anchor, @service, @result) ->
    if @post.embeds
      @post.embeds.push @
    else
      @post.embeds = [@]
    if @post.isClone
      @origin = @post.origin.embeds[@post.embeds.length - 1]
      @rmToggle()
      if @origin.isEmbedded
        @rmEmbed()
    @addToggle()

  addToggle: ->
    next = @anchor.nextSibling
    if next?.data
      next.data = next.data.replace /^((\u0020+)?[\[(]embed[)\]](\u0020+)?)+/i, ''

    @toggle = $.el 'a',
      textContent: 'Embed'
      href: 'javascript:;'
    @span = $.el 'span'
    $.add @span, [$.tn '\u0020['; @toggle, $.tn ']']
    $.after @anchor, @span

  rmToggle: ->
    $.rm @anchor.nextSibling

  rmEmbed: ->
    media = @anchor.nextSibling.nextSibling
    unless media.className is 'media-embed'
      media = @anchor.nextSibling
      # wat
      return unless media.className is 'media-embed'
    $.rm media

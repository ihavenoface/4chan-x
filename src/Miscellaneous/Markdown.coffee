Markdown =
  format: (text) ->
    return unless text

    tag_patterns =
      bi: /(\*\*\*|___)(?=\S)([^\r\n]*?\S)\1/g
      b: /(\*\*|__)(?=\S)([^\r\n]*?\S)\1/g
      i: /(\*|_)(?=\S)([^\r\n]*?\S)\1/g
      code: /(`)(?=\S)([^\r\n]*?\S)\1/g
      ds: /(\|\||__)(?=\S)([^\r\n]*?\S)\1/g

    for tag, pattern of tag_patterns
      text = text.replace pattern, Markdown.unicode_convert
    text

  unicode_convert: (str, tag, inner) ->
    fmt =
      if tag in ['_', '*']
        'i'
      else if tag in ['__', '**']
        'b'
      else if tag in ['___', '***']
        'bi'
      else if tag is '||'
        'ds'
      else if tag in ['`', '```']
        'code'

    # Unicode codepoints for the characters '0', 'A', and 'a'
    # http://en.wikipedia.org/wiki/Mathematical_Alphanumeric_Symbols
    codepoints =
      b:    [ 0x1D7CE, 0x1D400, 0x1D41A ] # MATHEMATICAL BOLD
      i:    [ 0x1D7F6, 0x1D434, 0x1D44E ] # MATHEMATICAL ITALIC
      bi:   [ 0x1D7CE, 0x1D468, 0x1D482 ] # MATHEMATICAL BOLD ITALIC
      code: [ 0x1D7F6, 0x1D670, 0x1D68A ] # MATHEMATICAL MONOSPACE
      ds:   [ 0x1D7D8, 0x1D538, 0x1D552 ] # I FUCKING LOVE CAPS LOCK

    charcodes = (inner.charCodeAt i for c, i in inner)

    codes = for charcode in charcodes
      if charcode >= 48 and charcode <= 57
        charcode - 48 + codepoints[fmt][0]
      else if charcode >= 65 and charcode <= 90
        charcode - 65 + codepoints[fmt][1]
      else if charcode >= 97 and charcode <= 122
        if charcode is 104 and tag is 'i'
          # http://blogs.msdn.com/b/michkap/archive/2006/04/21/580328.aspx
          # mathematical small h -> planck constant
          0x210E
        else
          charcode - 97 + codepoints[fmt][2]
      else
        charcode

    unicode_text = codes.map(Markdown.ucs2_encode).join ''
    unicode_text = unicode_text.replace /\x20/g, '\xA0'  if tag is 'code'
    unicode_text

  ucs2_encode: (value) ->
    # translates Unicode codepoint integers directly into text. Javascript does this in an ugly fashion by default.
    output = ''
    if value > 0xFFFF
      value -= 0x10000
      output += String.fromCharCode value >>> 10 & 0x3FF | 0xD800
      value = 0xDC00 | value & 0x3FF
    output += String.fromCharCode value

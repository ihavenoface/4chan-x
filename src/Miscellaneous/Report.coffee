Report =
  init: ->
    return unless /report/.test(location.search) and d.cookie.indexOf('pass_enabled=1') is -1
    $.addStyle 'body {background: none !important}'
    $.asap (-> $.id 'recaptcha_response_field'), Report.ready
  ready: ->
    postID = location.search.match(/\d+$/)[0]
    field = $.id 'recaptcha_response_field'
    $.on field, 'keydown', (e) ->
      $.globalEval 'Recaptcha.reload("t")' if e.keyCode is 8 and not field.value
    $.on $('form'), 'submit', (e) ->
      e.preventDefault()
      response = field.value.trim()
      field.value = "#{response} #{response}" unless /\s/.test response
      @submit()
      parent.postMessage "reported #{postID}", '*'

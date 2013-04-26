IDColor =
  init: ->
    return if g.VIEW is 'catalog' or !Conf['Color user IDs']
    @ids = {}

    Post::callbacks.push
      name: 'Color user IDs'
      cb:   @node

  node: ->
    return unless span = @nodes.uniqueID
    {uniqueID} = @info
    rgb = IDColor.ids[uniqueID] or IDColor.compute uniqueID
    span.firstElementChild.style.cssText =
      "background-color: rgb(#{rgb[0]},#{rgb[1]},#{rgb[2]});
       color: #{if rgb[3] then 'black' else 'white'};"

  compute: (uniqueID) ->
    rgb = []
    hash = @hash uniqueID

    rgb[0] = (hash >> 24) & 0xFF
    rgb[1] = (hash >> 16) & 0xFF
    rgb[2] = (hash >> 8)  & 0xFF
    rgb[3] = ((rgb[0] * 0.299) + (rgb[1] * 0.587) + (rgb[2] * 0.114)) > 125

    @ids[uniqueID] = rgb
    rgb

  hash: (uniqueID) ->
    msg = 0
    for i in [0...uniqueID.length]
      msg = ((msg << 5) - msg) + uniqueID.charCodeAt i
    msg

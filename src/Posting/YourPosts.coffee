YourPosts =
  init: ->
    return if !Conf['Mark own Posts'] or !Conf['Quick Reply']

    Post.callbacks.push
      name: 'Mark own Posts'
      cb:   @node

  node: ->
    if QR.db.get {
      boardID:  @board.ID
      threadID: @thread.ID
      postID:   @ID
    }
      $.addClass @nodes.root, 'your-post'

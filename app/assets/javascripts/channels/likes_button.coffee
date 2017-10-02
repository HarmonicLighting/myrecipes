App.cable.subscriptions.create "LikesButtonChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#like-button-" + data.recipe_id).html(data.button);
    # Called when there's incoming data on the websocket for this channel

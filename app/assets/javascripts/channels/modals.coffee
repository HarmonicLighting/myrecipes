App.modals = App.cable.subscriptions.create "ModalsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#modals").prepend(data)
    # Called when there's incoming data on the websocket for this channel

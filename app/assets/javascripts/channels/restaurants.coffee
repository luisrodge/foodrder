App.restaurants = App.cable.subscriptions.create "RestaurantsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log(data)
    # Called when there's incoming data on the websocket for this channel
    $("[data-behavior='pending-orders-count']").text(data.count)
    active_restaurant = $("[data-behavior='seller-orders'][data-restaurant-id=#{data.restaurant_id}]")
    if active_restaurant.length > 0
      active_restaurant.prepend(data.order_fragment)

if ($('meta[name=action-cable-url]').length > 0) {
    App.restaurants = App.cable.subscriptions.create("RestaurantsChannel", {
        connected: function () {
        },
        disconnected: function () {
        },
        received: function (data) {
            var active_restaurant;
            // console.log(data);
            $("[data-behavior='pending-orders-count']").text(data.count);
            active_restaurant = $("[data-behavior='seller-orders'][data-restaurant-id=" + data.restaurant_id + "]");
            return active_restaurant.prepend(data.order_fragment);
        }
    });
}
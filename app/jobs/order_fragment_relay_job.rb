class OrderFragmentRelayJob < ApplicationJob
  queue_as :default

  def perform(order_fragment)
    ActionCable.server.broadcast "restaurants_channel:#{order_fragment.restaurant.id}", {
        order_fragment: Supplier::OrderFragmentsController.render(order_fragment),
        restaurant_id: order_fragment.restaurant.id,
        count: order_fragment.restaurant.pending_order_fragments.count
    }
  end
end

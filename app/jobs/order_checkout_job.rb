class OrderCheckoutJob < ApplicationJob
  queue_as :default

  def perform(order_params, cart)
    Order.checkout(order_params, cart)
  end
end

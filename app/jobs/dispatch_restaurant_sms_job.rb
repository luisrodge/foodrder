class DispatchRestaurantSmsJob < ApplicationJob
  queue_as :default

  def perform(order_fragment)
    EngineSparkService.new(order_fragment).message_restaurant
  end
end

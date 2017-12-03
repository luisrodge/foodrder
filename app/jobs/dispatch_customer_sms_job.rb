class DispatchCustomerSmsJob < ApplicationJob
  queue_as :default

  def perform(order_fragment)
    EngineSparkService.new(order_fragment).message_customer
  end
end

class DispatchReservationSmsJob < ApplicationJob
  queue_as :default

  def perform(reservation)
    EngineSparkService.new(reservation).message_restaurant_reservation
  end
end

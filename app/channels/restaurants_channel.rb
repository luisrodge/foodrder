class RestaurantsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "restaurants_channel:#{current_supplier.restaurant.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end

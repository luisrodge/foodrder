class RestaurantsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "restaurants_channel:#{current_user.restaurant.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end

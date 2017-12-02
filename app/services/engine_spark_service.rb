require 'httparty'

class EngineSparkService
  API_URL = 'https://start.engagespark.com/api/v1/engagements/279054/contacts/'

  def initialize(order_fragment)
    @order_fragment = order_fragment
  end

  # Build out the new order text messages that
  # will be dispatched to the restaurant.
  def message_restaurant
    message_body = ""
    message_end = ""
    dispatch_message("New order placed on foodrder.bz @ #{@order_fragment.created_at.strftime("%I:%M %p")}.")
    @order_fragment.food_order_items.each do |order_item|
      message_body = "#{order_item.itemable.name}, Amount: #{order_item.quantity}."
      dispatch_message(message_body)
    end
    if @order_fragment.drink_order_items.any?
      @order_fragment.drink_order_items.each do |order_item|
        message_body = "#{order_item.itemable.variantable.name} - #{order_item.itemable.name}, Amount: #{order_item.quantity}."
        dispatch_message(message_body)
      end
    end
    if @order_fragment.delivery?
      message_end = "Delivery @ #{@order_fragment.order.location}, #{@order_fragment.order.location_description}."
    end
    dispatch_message(message_end)
  end

  def dispatch_message(message)
    HTTParty.post(API_URL,
                  :body => {:fullPhoneNumber => "5016082077",
                            :organizationId => 5291,
                            :customFields => {"14669" => message}
                  }.to_json,
                  :headers => {'Content-Type' => 'application/json',
                               'Authorization' => 'Token 4e774d9a6d93795307cb4d29c7576b7755d2c31a'})
  end

end
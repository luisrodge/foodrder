require 'httparty'

class EngineSparkService
  API_URL = 'https://start.engagespark.com/api/v1/engagements/279054/contacts/'

  def initialize(order_fragment)
    @order_fragment = order_fragment
  end

  # Build out the new order text messages that
  # will be dispatched to the restaurant.
  # The message body contains important order details
  # such as item name, variant, quantity, etc...
  def message_restaurant
    dispatch_message("New order placed on foodrder.bz")
    puts "Dispatch header"
    @order_fragment.food_order_items.each do |order_item|
      puts "Dispatch food body"
      message_body = "#{order_item.item_name}, Amount: #{order_item.quantity}."
      dispatch_message(message_body)
    end
    if @order_fragment.drink_order_items.any?
      puts "Dispatch drink body"
      @order_fragment.drink_order_items.each do |order_item|
        message_body = "#{order_item.item_name}, Amount: #{order_item.quantity}."
        dispatch_message(message_body)
      end
    end
    if @order_fragment.delivery?
      puts "Dispatch message end"
      message_end = "Delivery @ #{@order_fragment.order.delivery_address}."
      dispatch_message(message_end)
    end
  end

  # Build out message to inform the customer
  # that their placed order is ready for pickup.
  def message_customer
    dispatch_message("Your recently placed order at #{@order_fragment.restaurant.name} is ready for pickup.")
  end

  def dispatch_message(message)
    HTTParty.post(API_URL,
                  :body => {:fullPhoneNumber => "501#{@order_fragment.restaurant.phone_number}",
                            :organizationId => 5291,
                            :customFields => {"14669" => message}
                  }.to_json,
                  :headers => {'Content-Type' => 'application/json',
                               'Authorization' => 'Token 4e774d9a6d93795307cb4d29c7576b7755d2c31a'})
  end

end
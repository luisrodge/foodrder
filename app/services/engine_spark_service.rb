require 'httparty'

class EngineSparkService
  API_URL = 'https://start.engagespark.com/api/v1/engagements/287096/contacts/'

  def initialize(order_fragment)
    @order_fragment = order_fragment
  end

  # Build out the new order text messages that
  # will be dispatched to the restaurant.
  def message_restaurant
    dispatch_message("New order placed on foodrder.bz. View here foodrder.bz/seller/o/#{@order_fragment.id}")
  end

  # Build out message to inform the customer
  # that their placed order is ready for pickup.
  def message_customer
    dispatch_message("Your recently placed order at #{@order_fragment.restaurant.name} restaurant is ready for pickup.")
  end

  def dispatch_message(message)
    HTTParty.post(API_URL,
                  :body => {:fullPhoneNumber => "5016082077",
                            :organizationId => 5291,
                            :customFields => {"14753" => message}
                  }.to_json,
                  :headers => {'Content-Type' => 'application/json',
                               'Authorization' => 'Token 4e774d9a6d93795307cb4d29c7576b7755d2c31a'})
  end

end
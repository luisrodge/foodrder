require 'httparty'

class EngineSparkService
  API_URL = 'https://start.engagespark.com/api/v1/engagements/287096/contacts/'

  def initialize(record)
    @record = record
  end

  # Build out the new order text messages that
  # will be dispatched to the restaurant.
  def message_restaurant
    dispatch_message("New order placed on foodrder.bz. View here foodrder.bz/supplier/order_fragments/#{@record.id}",
                     @record.restaurant.phone_number)
  end

  # Build out message to inform restaurant
  # about new reservation request.
  def message_restaurant_reservation
    dispatch_message("New reservation placed on foodrder.bz. View here foodrder.bz/supplier/reservations",
                     @record.restaurant.phone_number)
  end

  # Build out message to inform the customer
  # that their placed order is ready for pickup.
  def message_customer
    dispatch_message("Your recently placed order at #{@record.restaurant.name} restaurant is ready for pickup.",
                     @record.order.phone_number)
  end

  def dispatch_message(message, phone_number)
    HTTParty.post(API_URL,
                  :body => {:fullPhoneNumber => '501' + phone_number,
                            :organizationId => 5291,
                            :customFields => {"14753" => message}
                  }.to_json,
                  :headers => {'Content-Type' => 'application/json',
                               'Authorization' => 'Token 4e774d9a6d93795307cb4d29c7576b7755d2c31a'})
  end

end
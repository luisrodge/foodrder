require 'httparty'

class EngineSparkService
  API_URL = 'https://start.engagespark.com/api/v1/engagements/279054/contacts/'

  def initialize(phone_number)
    @phone_number = phone_number
  end

  def message_restaurant
    HTTParty.post(API_URL,
                  :body => {:fullPhoneNumber => @phone_number,
                            :organizationId => 5291,
                            :customFields => {"14669" => "Test message from foodrder"}
                  }.to_json,
                  :headers => {'Content-Type' => 'application/json',
                               'Authorization' => 'Token 4e774d9a6d93795307cb4d29c7576b7755d2c31a'})

    #curl -H 'Content-Type: application/json' -H 'Authorization: Token 4e774d9a6d93795307cb4d29c7576b7755d2c31a' -d '{"fullPhoneNumber": "5016347762", "organizationId": 5291, "customFields": {"14669": "This is a message coming from MBC. New Specials happening now!"}}' https://start.engagespark.com/api/v1/engagements/279054/contacts/
  end
end
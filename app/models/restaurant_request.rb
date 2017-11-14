class RestaurantRequest < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email, :mobile_number,
                        :location, :street_name, :restaurant_name
  enum status: [:pending, :reviewed]

  def self.pending_requests
    where(status: 0).order("created_at DESC")
  end

end

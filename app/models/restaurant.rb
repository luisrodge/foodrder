class Restaurant < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :foods, dependent: :destroy
  has_many :specials, dependent: :destroy
  has_one :schedule, dependent: :destroy

  has_many :drinks

  enum order_medium_type: %w[only_pickup pickup_and_delivery only_delivery]

  # Virtual attributes
  attr_accessor :origin_seller_email

  # Validations
  validates_presence_of :name, :location, :street, :phone_number,
                        :order_medium_type
  validates_presence_of :origin_seller_email, on: :create

  # Carrierwave uploader
  mount_uploader :primary_image, PrimaryImageUploader

  def offers_delivery?
    only_delivery? || pickup_and_delivery?
  end

  # Return restaurants that offer delivery
  def self.delivery_available
    where('order_medium_type = ? OR order_medium_type=?', 1, 2).order("created_at DESC")
  end

  # Returns true if a restaurant is currently open
  def open?
    unless schedule.present? && (open_today || close?)
      return false
    end
    true
  end

  def open_today
    schedule.converted_schedule.occurs_on?(Date.today)
  end

  # Returns true if the restaurant is currently close
  def close?
    Time.now < schedule.open_time || Time.now > schedule.close_time
  end

end

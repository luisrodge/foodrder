class Restaurant < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :foods, dependent: :destroy
  has_many :specials, dependent: :destroy

  has_many :common_drinks
  has_many :drinks, through: :common_drinks

  enum order_medium_type: %w[only_pickup pickup_and_delivery only_delivery]
  enum order_notify_type: %w[phone_call text_message]

  # Virtual attributes
  attr_accessor :origin_seller_email

  # Validations
  validates_presence_of :name, :location, :street, :phone_number,
                        :order_medium_type, :order_notify_type
  validates_presence_of :origin_seller_email, on: :create

  # Carrierwave uploader
  mount_uploader :primary_image, PrimaryImageUploader

  def offers_delivery?
    only_delivery? || pickup_and_delivery?
  end

end

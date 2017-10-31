class Restaurant < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :foods, dependent: :destroy

  # Virtual attributes
  attr_accessor :origin_seller_email

  # Validations
  validates_presence_of :name, :location, :street, :phone_number
  validates_presence_of :origin_seller_email, on: :create

  # Carrierwave uploader
  mount_uploader :primary_image, PrimaryImageUploader

  enum order_medium: [:pickup, :delivery_and_pickup, :delivery]

end

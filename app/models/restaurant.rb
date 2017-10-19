class Restaurant < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :menus, dependent: :destroy

  # Virtual attributes
  attr_accessor :origin_seller_email

  # Validations
  validates_presence_of :name, :location, :street, :phone_number, :origin_seller_email

  # Carrierwave uploader
  mount_uploader :primary_image, PrimaryImageUploader
end

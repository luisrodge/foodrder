class Food < ApplicationRecord
  belongs_to :restaurant
  belongs_to :menu

  validates_presence_of :name, :price, :description

  # Carrierwave uploader
  mount_uploader :primary_image, PrimaryImageUploader
end

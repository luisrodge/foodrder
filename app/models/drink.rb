class Drink < ApplicationRecord
  belongs_to :restaurant

  include Variantable

  validates_presence_of :name

  mount_uploader :primary_image, PrimaryImageUploader


  monetize :price_cents

  # For searchkick model searching
  searchkick

  # Search Food records by food name and Tags
  def search_data
    attributes.merge(
        name: name,
    )
  end

end

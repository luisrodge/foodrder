class Special < ApplicationRecord
  include Taggable

  belongs_to :restaurant

  validates_presence_of :name, :price_cents, :selling_date

  # Carrierwave uploader
  mount_uploader :primary_image, PrimaryImageUploader

  monetize :price_cents

  # For searchkick model searching
  searchkick

  # Search Food records by food name and Tags
  def search_data
    attributes.merge(
        name: name,
        tags_name: tags.map(&:name)
    )
  end
end

class Food < ApplicationRecord
  include Taggable

  belongs_to :restaurant
  belongs_to :menu

  has_many :variants, as: :variantable
  has_many :cart_items, as: :itemable
  has_many :order_items, as: :itemable


  validates_presence_of :name, :price_cents

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

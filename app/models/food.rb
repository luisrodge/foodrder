class Food < ApplicationRecord
  belongs_to :restaurant
  belongs_to :menu

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  validates_presence_of :name, :price_cents, :description

  # Carrierwave uploader
  mount_uploader :primary_image, PrimaryImageUploader

  monetize :price_cents

  # For searchkick model searching
  searchkick

  # Search Food records only by name
  def search_data
    attributes.merge(
        name: name,
        categories_title: menu.menu_categories.map(&:name)
    )
  end
end

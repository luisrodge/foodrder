class Drink < ApplicationRecord
  has_many :variants, as: :variantable, validate: false, dependent: :destroy

  validates_presence_of :name

  accepts_nested_attributes_for :variants

  monetize :default_price_cents

  # For searchkick model searching
  searchkick

  # Search Food records by food name and Tags
  def search_data
    attributes.merge(
        name: name,
    )
  end

end

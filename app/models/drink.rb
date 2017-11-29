class Drink < ApplicationRecord
  has_many :variants, as: :variantable

  accepts_nested_attributes_for :variants

  monetize :price_cents

  searchkick word_start: [:name]

  def search_data
    {
        name: name
    }
  end

end

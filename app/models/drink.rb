class Drink < ApplicationRecord
  has_many :variants, as: :variantable

  monetize :price_cents

  searchkick word_start: [:name]

  def search_data
    {
        name: name
    }
  end

end

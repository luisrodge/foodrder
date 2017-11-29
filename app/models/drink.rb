class Drink < ApplicationRecord
  has_many :common_drinks
  has_many :restaurants, through: :common_drinks

  monetize :price_cents

  searchkick word_start: [:name]

  def search_data
    {
        name: name
    }
  end

end

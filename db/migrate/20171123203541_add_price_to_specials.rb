class AddPriceToSpecials < ActiveRecord::Migration[5.1]
  def change
    add_monetize :specials, :price
  end
end

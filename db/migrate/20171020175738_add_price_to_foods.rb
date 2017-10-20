class AddPriceToFoods < ActiveRecord::Migration[5.1]
  def change
    add_monetize :foods, :price
  end
end

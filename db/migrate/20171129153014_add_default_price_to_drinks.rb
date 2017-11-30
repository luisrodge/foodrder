class AddDefaultPriceToDrinks < ActiveRecord::Migration[5.1]
  def change
    add_monetize :drinks, :default_price
  end
end

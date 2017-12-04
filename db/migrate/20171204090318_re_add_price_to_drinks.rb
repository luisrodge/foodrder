class ReAddPriceToDrinks < ActiveRecord::Migration[5.1]
  def change
    add_monetize :drinks, :price
  end
end

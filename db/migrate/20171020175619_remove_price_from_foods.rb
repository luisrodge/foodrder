class RemovePriceFromFoods < ActiveRecord::Migration[5.1]
  def change
    remove_column :foods, :price, :decimal
  end
end

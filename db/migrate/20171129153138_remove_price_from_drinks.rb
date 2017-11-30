class RemovePriceFromDrinks < ActiveRecord::Migration[5.1]
  def change
    remove_column :drinks, :price_cents
  end
end

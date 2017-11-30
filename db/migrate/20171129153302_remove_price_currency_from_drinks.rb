class RemovePriceCurrencyFromDrinks < ActiveRecord::Migration[5.1]
  def change
    remove_column :drinks, :price_currency
  end
end

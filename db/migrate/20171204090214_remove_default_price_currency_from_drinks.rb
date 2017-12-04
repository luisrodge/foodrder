class RemoveDefaultPriceCurrencyFromDrinks < ActiveRecord::Migration[5.1]
  def change
    remove_column :drinks, :default_price_currency
  end
end

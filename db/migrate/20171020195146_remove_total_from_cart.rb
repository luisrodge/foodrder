class RemoveTotalFromCart < ActiveRecord::Migration[5.1]
  def change
    remove_column :carts, :total, :decimal
  end
end

class AddTotalToCarts < ActiveRecord::Migration[5.1]
  def change
    add_monetize :carts, :total
  end
end

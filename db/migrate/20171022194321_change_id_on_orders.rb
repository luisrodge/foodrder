class ChangeIdOnOrders < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :id, :bigint, primary_key: true, default: -> {"make_random_id()"}
  end
end

class AddConfirmationCodeToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :confirmation_code, :integer
  end
end

class RemoveConfirmationCodeFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :confirmation_code, :integer
  end
end

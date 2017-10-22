class AddStatusToOrderFragments < ActiveRecord::Migration[5.1]
  def change
    add_column :order_fragments, :status, :integer, default: 0
  end
end

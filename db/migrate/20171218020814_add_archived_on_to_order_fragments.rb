class AddArchivedOnToOrderFragments < ActiveRecord::Migration[5.1]
  def change
    add_column :order_fragments, :archived_on, :datetime
  end
end

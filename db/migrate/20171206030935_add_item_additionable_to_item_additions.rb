class AddItemAdditionableToItemAdditions < ActiveRecord::Migration[5.1]
  def change
    add_column :item_additions, :item_additionable_id, :integer
    add_column :item_additions, :item_additionable_type, :string
    add_index :item_additions, [:item_additionable_id, :item_additionable_type], name: :idx_item_addition_item_additionable_item_additionable_type
  end
end

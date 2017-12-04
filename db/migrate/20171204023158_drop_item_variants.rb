class DropItemVariants < ActiveRecord::Migration[5.1]
  def change
    drop_table :item_variants
  end
end

class AddItemVariantableIdAndItemVariantableTypeToItemVariants < ActiveRecord::Migration[5.1]
  def change
    add_column :item_variants, :item_variantable_id, :integer, index: true
    add_column :item_variants, :item_variantable_type, :string, index: true

  end
end

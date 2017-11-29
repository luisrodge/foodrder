class CreateVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :variants do |t|
      t.string :name
      t.integer :variantable_id
      t.string :variantable_type

      t.timestamps
    end
    add_index :variants, [:variantable_id, :variantable_type]
  end
end

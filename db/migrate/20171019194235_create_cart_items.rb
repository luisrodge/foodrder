class CreateCartItems < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_items do |t|
      t.references :cart, foreign_key: true
      t.references :food, foreign_key: true
      t.integer :quantity
      t.decimal :sub_total
      t.references :cart_fragment, foreign_key: true

      t.timestamps
    end
  end
end

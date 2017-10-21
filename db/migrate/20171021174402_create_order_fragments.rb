class CreateOrderFragments < ActiveRecord::Migration[5.1]
  def change
    create_table :order_fragments do |t|
      t.references :order, foreign_key: true
      t.references :restaurant, foreign_key: true
      t.boolean :delivery, default: false

      t.timestamps
    end
  end
end

class CreateCartFragments < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_fragments do |t|
      t.references :restaurant, foreign_key: true
      t.references :cart, foreign_key: true

      t.timestamps
    end
  end
end

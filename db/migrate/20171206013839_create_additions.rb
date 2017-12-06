class CreateAdditions < ActiveRecord::Migration[5.1]
  def change
    create_table :additions do |t|
      t.string :name
      t.references :additionable, polymorphic: true
      t.monetize :price

      t.timestamps
    end
  end
end

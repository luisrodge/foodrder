class CreateDrinks < ActiveRecord::Migration[5.1]
  def change
    create_table :drinks do |t|
      t.string :name
      t.string :primary_image

      t.timestamps
    end
    add_index :drinks, :name, unique: true
  end
end

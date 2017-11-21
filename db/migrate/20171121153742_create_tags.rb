class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name
      t.string :primary_image

      t.timestamps
    end
    add_index :tags, :name, unique: true
  end
end

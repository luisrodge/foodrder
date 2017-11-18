class CreateMenuTags < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_tags do |t|
      t.references :menu_category, foreign_key: true
      t.references :menu, foreign_key: true

      t.timestamps
    end
  end
end

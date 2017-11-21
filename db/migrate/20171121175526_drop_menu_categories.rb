class DropMenuCategories < ActiveRecord::Migration[5.1]
  def change
    drop_table :menu_categories
  end
end

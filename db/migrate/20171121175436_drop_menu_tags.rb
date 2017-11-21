class DropMenuTags < ActiveRecord::Migration[5.1]
  def change
    drop_table :menu_tags
  end
end

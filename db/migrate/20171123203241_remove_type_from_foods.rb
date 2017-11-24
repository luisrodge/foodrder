class RemoveTypeFromFoods < ActiveRecord::Migration[5.1]
  def change
    remove_column :foods, :type, :string
  end
end

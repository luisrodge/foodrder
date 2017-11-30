class RemoveNameFromDrinks < ActiveRecord::Migration[5.1]
  def change
    remove_column :drinks, :name, :string
  end
end

class AddNameToDrinks < ActiveRecord::Migration[5.1]
  def change
    add_column :drinks, :name, :string
  end
end

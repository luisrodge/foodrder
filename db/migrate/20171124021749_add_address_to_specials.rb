class AddAddressToSpecials < ActiveRecord::Migration[5.1]
  def change
    add_column :specials, :address, :string
  end
end

class AddPrimaryImageToSpecials < ActiveRecord::Migration[5.1]
  def change
    add_column :specials, :primary_image, :string
  end
end

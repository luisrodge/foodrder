class AddSpecialDateToFoods < ActiveRecord::Migration[5.1]
  def change
    add_column :foods, :special_date, :datetime
  end
end

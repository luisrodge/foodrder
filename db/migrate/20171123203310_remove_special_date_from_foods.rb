class RemoveSpecialDateFromFoods < ActiveRecord::Migration[5.1]
  def change
    remove_column :foods, :special_date, :datetime
  end
end

class CreateItemAdditions < ActiveRecord::Migration[5.1]
  def change
    create_table :item_additions do |t|
      t.references :addition, foreign_key: true

      t.timestamps
    end
  end
end

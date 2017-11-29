class AddPriceToVariants < ActiveRecord::Migration[5.1]
  def change
    add_monetize :variants, :price
  end
end

class ItemAddition < ApplicationRecord
  belongs_to :addition
  belongs_to :item_additionable, polymorphic: true
end

class Addition < ApplicationRecord
  belongs_to :additionable, polymorphic: true

  monetize :price_cents

  validates_presence_of :name
end

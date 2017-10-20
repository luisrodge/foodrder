class Order < ApplicationRecord
  belongs_to :restaurant

  monetize :total_cents
end

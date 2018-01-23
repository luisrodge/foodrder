class MessageNumber < ApplicationRecord
  belongs_to :restaurant
  validates :number, numericality: {only_integer: true},
            length: {minimum: 7, maximum: 7}, presence: :true

end

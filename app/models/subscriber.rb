class Subscriber < ApplicationRecord
  validates :mobile_number, presence: true, uniqueness: true,
            numericality: {only_integer: true},
            length: {minimum: 7, maximum: 7}
end

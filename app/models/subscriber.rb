class Subscriber < ApplicationRecord
  validates_presence_of :mobile_number
  validates_uniqueness_of :mobile_number
end

class Menu < ApplicationRecord
  belongs_to :restaurant
  has_many :foods, dependent: :destroy

  validates_presence_of :name
end

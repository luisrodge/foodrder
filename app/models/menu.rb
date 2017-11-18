class Menu < ApplicationRecord
  belongs_to :restaurant
  has_many :foods, dependent: :destroy

  has_many :menu_tags
  has_many :menu_categories, through: :menu_tags

  validates_presence_of :name
end

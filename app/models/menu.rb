class Menu < ApplicationRecord
  include Taggable
  include Additionable

  belongs_to :restaurant
  has_many :foods, dependent: :destroy

  validates_presence_of :name

  def additions_name
    additions.map{|a| a.name}.join(" ,")
  end

  def additions_name_price
    additions.map{|a| "#{a.name} - $#{a.price}"}.join(", ")
  end
end
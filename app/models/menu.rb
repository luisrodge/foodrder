class Menu < ApplicationRecord
  include Taggable

  belongs_to :restaurant
  has_many :foods, dependent: :destroy

  validates_presence_of :name

  # Used for assigning tags submitted with
  # jqueryTokeInput plugin
  def taggable_tokens=(ids)
    self.tag_ids = ids.split(",")
  end
end

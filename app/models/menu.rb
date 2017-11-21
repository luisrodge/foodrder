class Menu < ApplicationRecord
  attr_accessor :menu_catgory_tokens

  belongs_to :restaurant
  has_many :foods, dependent: :destroy

  has_many :menu_tags
  has_many :menu_categories, through: :menu_tags

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  validates_presence_of :name

  attr_reader :menu_catgory_tokens

  def menu_catgory_tokens=(ids)
    self.menu_category_ids = ids.split(",")
  end
end

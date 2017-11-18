class MenuCategory < ApplicationRecord
  has_many :menu_tags
  has_many :menus, through: :menu_tags

  searchkick

  def search_data
    {
        name: name
    }
  end
end

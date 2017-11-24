class Tag < ApplicationRecord
  validates_presence_of :name

  searchkick word_start: [:name]

  def search_data
    {
        name: name
    }
  end
end

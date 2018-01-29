# Additions associate to menus and are usually referred to a add-ons.
# Additions have there own prices and all items in a menu that has additions
# can be optionally associated to those additions.a
class Addition < ApplicationRecord
  belongs_to :additionable, polymorphic: true

  monetize :price_cents

  validates_presence_of :name

  def full_name
    "#{name} - $#{price}"
  end

end

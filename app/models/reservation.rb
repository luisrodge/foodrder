class Reservation < ApplicationRecord
  belongs_to :restaurant

  validates_presence_of :full_name, :email, :reserve_date, :reserve_time, :persons
end

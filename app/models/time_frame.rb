class TimeFrame < ApplicationRecord
  belongs_to :schedule

  def open_time
    Time.parse(read_attribute(:open).strftime("%H:%M:%S"))
  end

  def close_time
    Time.parse(read_attribute(:close).strftime("%H:%M:%S"))
  end
end

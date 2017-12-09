class Schedule < ApplicationRecord
  serialize :recurring, Hash
  belongs_to :restaurant

  validates_presence_of :open, :close, :recurring

  def recurring=(value)
    if RecurringSelect.is_valid_rule?(value)
      super(RecurringSelect.dirty_hash_to_rule(value).to_hash)
    else
      super(nil)
    end

  end

  def converted_schedule
    the_schedule = IceCube::Schedule.new(Date.today)
    the_schedule.add_recurrence_rule(RecurringSelect.dirty_hash_to_rule(self.recurring))
    the_schedule
  end

  def open_time
    Time.parse(read_attribute(:open).strftime("%H:%M:%S"))
  end

  def close_time
    Time.parse(read_attribute(:close).strftime("%H:%M:%S"))
  end
end

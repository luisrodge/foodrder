class Schedule < ApplicationRecord
  serialize :recurring, Hash
  has_many :time_frames, dependent: :destroy
  belongs_to :restaurant

  accepts_nested_attributes_for :time_frames

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

  def day_names
    recurring[:validations][:day].map {|d| Date::DAYNAMES[d]}.join(", ")
  end

  def open_close_time_frames
    if time_frames.present?
      return time_frames.map {|tf| "#{tf.open_time.strftime('%I:%M %p')} - #{tf.close_time.strftime('%I:%M %p')}"}.join(", ")
    end
    "#{open_time.strftime('%I:%M %p')} - #{close_time.strftime('%I:%M %p')}"
  end

  def currently_open?
    converted_schedule.occurs_on?(Date.today) && time_frames.where('open < ? AND close > ?', Time.now, Time.now).any?
  end
end

#Date::DAYNAMES[Schedule.last.recurring[:validations][:day].first]

class Restaurant < ApplicationRecord
  has_many :suppliers, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :foods, dependent: :destroy
  has_many :specials, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :order_fragments, dependent: :destroy
  has_many :drinks, dependent: :destroy
  has_many :reservations, dependent: :destroy

  has_many :message_numbers, dependent: :destroy
  accepts_nested_attributes_for :message_numbers

  enum order_medium_type: %w[only_pickup pickup_and_delivery only_delivery]

  geocoded_by :address
  after_validation :geocode

  # Virtual attributes
  attr_accessor :origin_supplier_email

  # Validations
  validates_presence_of :name, :address, :phone_number,
                        :order_medium_type
  validates_presence_of :origin_supplier_email, on: :create

  # Carrierwave uploader
  mount_uploader :primary_image, PrimaryImageUploader

  def pending_order_fragments
    order_fragments.includes(order_items: [:variant, :additions, :itemable]).where(status: 0).order("created_at DESC")
  end

  def archived_order_fragments
    order_fragments.where(status: 1).order(archived_on: :desc)
  end

  def offers_delivery?
    only_delivery? || pickup_and_delivery?
  end

  # Return restaurants that offer delivery
  def self.delivery_available
    where('order_medium_type = ? OR order_medium_type=?', 1, 2).order("created_at DESC")
  end

  # Returns true if a restaurant is currently open
  def open?
    if schedule.present? && (open_today? == false || close?)
      return false
    end
    true
  end

  def open_today?
    schedule.converted_schedule.occurs_on?(Date.today) && time_frames.where('open < ? AND close > ?', Time.now, Time.now).any?
  end

  # Returns true if the restaurant is currently close
  def close?
    if schedule.time_frames.any?
      schedule.time_frames.each do |time_frame|
        if Time.now < time_frame.open_time || Time.now > time_frame.close_time
          return true
        else
          return false
        end
      end
    end
    Time.now < schedule.open_time || Time.now > schedule.close_time
  end

  def day_names
    schedule_days = nil
    schedules.each do |schedule|
      schedule_days = schedule.recurring[:validations][:day].map {|d| Date::DAYNAMES[d]}.join(", ")
      if schedule.time_frames.present?
        schedule_days += schedule.time_frames.map {|tf| " (#{tf.open_time.strftime('%I:%M %p')} - #{tf.close_time.strftime('%I:%M %p')})"}.join(", ")
      end
      schedule_days += " (#{schedule.open_time.strftime('%I:%M %p')} - #{schedule.close_time.strftime('%I:%M %p')})"
    end
    schedule_days
    #schedules.map {|s| s.recurring[:validations][:day].map {|d| Date::DAYNAMES[d]}.join(", ")}
  end

  # Does not account for midnight
  def currently_open?
    schedules.each do |schedule|
      if schedule.converted_schedule.occurs_on?(Date.today)
        if schedule.time_frames.present? && schedule.time_frames.where('open < ? AND close > ?', Time.now, Time.now).any?
          return true
        elsif schedule.open_time < Time.now && schedule.close_time > Time.now
          return true
        else
          next
        end
      else
        next
      end
    end
    false
  end


end

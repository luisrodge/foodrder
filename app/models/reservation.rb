class Reservation < ApplicationRecord
  belongs_to :restaurant

  after_commit :start_job, on: :create

  validates_presence_of :full_name, :email, :reserve_date, :reserve_time, :persons

  enum status: [:pending, :archived]

  # Invokes background job to dispatch reservation sms message
  def start_job
    DispatchReservationSmsJob.perform_later(self)
  end
end

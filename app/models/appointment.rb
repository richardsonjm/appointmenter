class Appointment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient

  validates_presence_of :date
  validate :date_must_be_at_least_three_days_away

  def date_must_be_at_least_three_days_away
    errors.add(:date, "can't be less than three days away") if
      !date.blank? and date < Time.now + 3.days
  end
end

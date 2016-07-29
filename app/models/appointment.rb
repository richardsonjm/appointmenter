class Appointment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient, class_name: "User"

  validates_presence_of :date, :patient, :doctor
  validate :date_must_be_at_least_three_days_away
  validate :doctor_specialty_matches_patient_ailment

  def date_must_be_at_least_three_days_away
    errors.add(:date, "can't be less than three days away") if
      !date.blank? and date < Time.now + 3.days
  end

  def doctor_specialty_matches_patient_ailment
    errors.add(:doctor_id, "doctor specialty must match patient ailment") if
      doctor.present? and patient_id.present? and !(doctor.specialty_ids & patient.specialty_ids).present?
  end
end

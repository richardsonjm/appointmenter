class Doctor < ActiveRecord::Base
  include PersonConcern
  has_many :doctors_specialties
  has_many :specialties, through: :doctors_specialties
  has_many :appointments
  has_many :patients, through: :appointments

  def name
    "Dr. #{super}"
  end

  def name_and_specialties
    "#{name} (#{specialties.map{|specialty| specialty.name}.join(", ")})"
  end

  def self.patient_doctors(patient)
    specialty_ids = patient.specialty_ids
    Doctor.joins(:doctors_specialties).where(doctors_specialties: {specialty_id: specialty_ids})
  end
end

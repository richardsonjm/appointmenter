class Doctor < ActiveRecord::Base
  include PersonConcern
  has_many :doctors_specialties
  has_many :specialties, through: :doctors_specialties

  def name
    "Dr. #{super}"
  end
end

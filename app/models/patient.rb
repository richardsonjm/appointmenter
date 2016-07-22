class Patient < ActiveRecord::Base
  include PersonConcern
  has_many :patients_ailments
  has_many :ailments, through: :patients_ailments
  has_many :appointments
  has_many :doctors, through: :appointments

  def specialty_ids
    ailments.map {|ailment| ailment.specialty_id}
  end
end

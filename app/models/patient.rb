class Patient < ActiveRecord::Base
  include PersonConcern
  has_many :patients_ailments
  has_many :ailments, through: :patients_ailments
  has_many :appointments
  has_many :doctors, through: :appointments
end

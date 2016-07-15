class Specialty < ActiveRecord::Base
  has_many :doctors_specialties
  has_many :doctors, through: :doctors_specialties

  validates_presence_of :name
end

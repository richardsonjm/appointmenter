class Specialty < ActiveRecord::Base
  has_many :doctors_specialties
  has_many :doctors, through: :doctors_specialties
  has_many :ailments

  def self.valid_names
    ENV['SPECIALTIES'].split(':')
  end

  validates :name, presence: true, inclusion: { in: self.valid_names,
    message: "%{value} is not a valid specialty" }
end

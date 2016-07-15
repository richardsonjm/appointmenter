class Ailment < ActiveRecord::Base
  has_many :patients_ailments
  has_many :patients, through: :patients_ailments

  validates_presence_of :name
end

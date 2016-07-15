class Appointment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient

  validates_presence_of :date
end

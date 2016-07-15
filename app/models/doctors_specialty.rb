class DoctorsSpecialty < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :specialty
end

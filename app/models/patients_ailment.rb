class PatientsAilment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :ailment
end

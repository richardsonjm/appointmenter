class PatientsAilment < ActiveRecord::Base
  belongs_to :patient, class_name: "User"
  belongs_to :ailment
end

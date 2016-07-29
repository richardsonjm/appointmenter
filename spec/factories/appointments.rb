FactoryGirl.define do
  factory :appointment do
    date Time.now + 4.days

    after(:build) do |appointment|
      if !appointment.patient.present? && !appointment.doctor.present?
        appointment.patient = FactoryGirl.create(:patient)
        specialty = appointment.patient.ailments.first.specialty
        appointment.doctor = FactoryGirl.create(:doctor, specialties: [specialty])
      elsif !appointment.doctor.present?
        specialty = appointment.patient.ailments.first.specialty
        appointment.doctor = FactoryGirl.create(:doctor, specialties: [specialty])
      elsif !appointment.patient.present?
        ailment = FactoryGirl.create(:ailment)
        appointment.doctor.specialties << ailment.specialty
        appointment.patient = FactoryGirl.create(:patient, ailments: [ailment])
      end
    end
  end
end

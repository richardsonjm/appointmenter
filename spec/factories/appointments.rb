FactoryGirl.define do
  factory :appointment do
    date Time.now + 4.days

    after(:build) do |appointment|
      ailment = FactoryGirl.create(:ailment)
      patient = FactoryGirl.create(:patient, ailments: [ailment])
      doctor = FactoryGirl.create(:doctor, specialties: [ailment.specialty])
      appointment.patient = patient unless appointment.patient.present?
      appointment.doctor = doctor unless appointment.doctor.present?
    end
  end
end

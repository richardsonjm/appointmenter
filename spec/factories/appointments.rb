FactoryGirl.define do
  factory :appointment do
    date Time.now + 4.days
    doctor
    patient
  end
end

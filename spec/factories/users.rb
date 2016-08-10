FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com"}
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password '123456789'
    password_confirmation '123456789'
    confirmed_at Time.now

    after(:build) do |user|
      FactoryGirl.create(:address, user: user) unless user.addresses.any?
    end

    factory :patient do
      sequence(:email) {|n| "patient#{n}@example.com"}
      after(:build) do |patient|
        patient.add_role :patient
        patient.ailments << FactoryGirl.create(:ailment) unless patient.ailments.any?
      end
    end

    factory :doctor do
      sequence(:email) {|n| "doctor#{n}@example.com"}
      after(:build) do |doctor|
        doctor.add_role :doctor
        doctor.specialties << FactoryGirl.create(:specialty) unless doctor.specialties.any?
      end

      factory :ny_doctor do
        after(:build) do |ny_doctor|
          unless ny_doctor.addresses.where(address_type: 1).any?
            FactoryGirl.create(:address, user: ny_doctor, address_type: 1)
          end
        end
      end

      factory :ca_doctor do
        after(:build) do |ca_doctor|
          unless ca_doctor.addresses.where(address_type: 1).any?
            FactoryGirl.create(:address,
              user: ca_doctor,
              address_type: 1,
              street: "101 Market",
              city: 'San Fransico',
              state: 'CA',
              zip: '94101')
          end
        end
      end
    end

    factory :admin do
      sequence(:email) {|n| "admin#{n}@example.com"}
      after(:build) do |admin|
        admin.add_role :admin
      end
    end
  end
end

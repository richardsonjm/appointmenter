FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password '123456789'
    password_confirmation '123456789'

    sequence(:street) {|n| "10#{n} Broadway"}
    city 'New York'
    state 'NY'
    zip '10013'

    factory :patient do
      sequence(:email) {|n| "patient#{n}@example.com"}
      after(:build) do |patient|
        patient.add_role :patient
      end
    end

    factory :doctor do
      sequence(:email) {|n| "doctor#{n}@example.com"}
      after(:build) do |patient|
        patient.add_role :patient
      end

      factory :ca_doctor do
        sequence(:street) {|n| "10#{n} Market"}
        city 'San Fransico'
        state 'CA'
        zip '94101'
      end
    end
  end
end

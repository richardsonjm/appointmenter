FactoryGirl.define do
  factory :address do
    sequence(:street) {|n| "10#{n} Broadway"}
    city 'New York'
    state 'NY'
    zip '10013'
    address_type 0
    user
  end
end

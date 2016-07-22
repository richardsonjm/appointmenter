FactoryGirl.define do
  factory :ailment do
    sequence(:name) {|n| "Malady#{n}"}
    specialty
  end
end

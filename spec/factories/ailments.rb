FactoryGirl.define do
  factory :ailment do
    sequence(:name) {|n| "Malady#{n}"}
  end
end

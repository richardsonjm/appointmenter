FactoryGirl.define do
  factory :ailment do
    sequence(:name) {|n| Ailment.valid_names[n % 3]}
    specialty
  end
end

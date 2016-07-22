FactoryGirl.define do
  factory :specialty do
    sequence(:name) {|n| Specialty.valid_names[n % 3]}
  end
end

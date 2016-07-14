FactoryGirl.define do
  factory :specialty do
    sequence(:name) {|n| "Corpologist#{n}"}
  end
end

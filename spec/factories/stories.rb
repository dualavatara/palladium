FactoryGirl.define do
  factory :story do
    sequence(:name) {|n| "Sample story #{n}"}
    desc "Description text"

    actor
    feature
  end
end

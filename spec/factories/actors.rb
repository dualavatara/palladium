FactoryGirl.define do
  factory :actor do
    sequence(:name) {|n| "Sample actor #{n}"}
    desc "Sample actor description"
  end
end

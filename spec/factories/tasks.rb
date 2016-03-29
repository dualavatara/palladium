FactoryGirl.define do
  factory :task do
    sequence(:name) { |n| "Task #{n}" }
    desc "Some text here"
    type :service
  end
end

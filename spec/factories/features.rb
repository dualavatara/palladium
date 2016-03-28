FactoryGirl.define do
  factory :feature do
    sequence(:name) {|n| "Feature name #{n}"}
    desc 'Feature description'
    project
  end
end

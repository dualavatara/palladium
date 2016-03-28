FactoryGirl.define do
  factory :feature do
    sequence(:name) {|n| "Feature name #{n}"}
    desc 'Feature description'
    project

    after(:create) do |feature|
      create_list(:story, 3, feature: feature)
    end
  end
end

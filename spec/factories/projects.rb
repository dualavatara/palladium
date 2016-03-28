FactoryGirl.define do
  factory :project do
    name "Sample project"

    after(:create) do |project|
      create_list(:feature, 3, project: project)
      create_list(:actor, 3, project: project)
    end
  end
end

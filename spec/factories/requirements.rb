FactoryGirl.define do
  factory :requirement do
    name 'Requirement name'
    desc 'Requirement description'
    project
  end
end

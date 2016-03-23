FactoryGirl.define do
  factory :company do
    name "Something Gmbh"
    web "http://www.somethinggmbh.com"
    email "info@somethinggmbh.com"

    transient do
      role_count 5
      project_count 1
    end

    after(:create) do |company, evaluator|
      create_list(:role, evaluator.role_count, company: company)
      create_list(:project, evaluator.project_count, company: company)
    end
  end
end

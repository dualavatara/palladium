FactoryGirl.define do
  factory :company do
    name "Something Gmbh"
    web "http://www.somethinggmbh.com"
    email "info@somethinggmbh.com"

    after(:create) do |company|
      create_list(:role, 3, company: company)
      create_list(:project, 3, company: company)
    end
  end
end

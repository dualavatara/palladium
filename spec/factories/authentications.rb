FactoryGirl.define do
  factory :valid_auth, class: Authentication do
    email    "test@test.com"
    password "foobar"
  end
end

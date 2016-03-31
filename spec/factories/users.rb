FactoryGirl.define do
  factory :user do
    sequence(:email, 1) {|n| "test#{n}@test.com"}
    password "foobar"
    password_confirmation "foobar"
    sequence(:name) { |n| "User #{n}" }
    initials "KZ"
  end
end

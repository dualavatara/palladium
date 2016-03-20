FactoryGirl.define do
  factory :user do
    email    "test@test.com"
    password "foobar"
    password_confirmation "foobar"
    name "Konstantin Zhukov"
    initials "KZ"
  end
end

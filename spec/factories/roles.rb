FactoryGirl.define do
  factory :role do
    sequence(:name, 1) {|n| "somerole#{n}"}
    company
    factory :admin_role do
      admin   true
    end
  end
end

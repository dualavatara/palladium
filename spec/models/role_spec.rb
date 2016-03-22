require 'rails_helper'

RSpec.describe Role, type: :model do
  before {
    @adminRole = FactoryGirl.build(:admin_role)
    @role = FactoryGirl.build(:role)
  }


  it {expect(@adminRole).to respond_to(:admin)}
  it {expect(@adminRole.admin).to be_truthy}
  it {expect(@role.admin).to be_falsey}
end

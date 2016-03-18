require 'rails_helper'

RSpec.describe Authentication, type: :model do
  before do
    @user = FactoryGirl.create(:user)
    @auth = FactoryGirl.build(:valid_auth)
  end

  subject { @auth }

  it { should respond_to(:email) }
  it { should respond_to(:password) }

end

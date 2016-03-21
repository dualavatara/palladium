require 'rails_helper'

RSpec.describe Company, type: :model do
  before do
    @company = FactoryGirl.create(:company, role_count: 3)
  end

  subject { @company }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:web) }
  it { should respond_to(:roles) }
  it 'should have correct number of assotiations' do
    expect(@company.roles.length).to eq(4)
  end

  it 'should have admin role' do
    expect(@company.roles.where(name: 'admin').first).to be_truthy
  end

end

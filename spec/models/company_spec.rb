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

  it 'should have admin role on creation' do
    expect(@company.roles.pluck(:admin)).to include(true)
  end

  describe 'company properties' do
    it 'should have non empty name field' do
      @company.name = ''
      expect(@company).not_to be_valid
    end
    it 'should have significant name field' do
      @company.name = '   '
      expect(@company).not_to be_valid
    end

    it 'can have empty email field' do
      @company.email = ''
      expect(@company).to be_valid
    end
    it 'can have empty web field' do
      @company.web = ''
      expect(@company).to be_valid
    end
    it 'should have correct email field if present' do
      @company.email = 'some#address,fff'
      expect(@company).not_to be_valid
    end

    it 'should have correct web field' do
      urls = ['some.adress.com/', 'http://', 'http://some']
      urls.each do |url|
        @company.email = url
        expect(@company).not_to be_valid
      end
    end
  end
end

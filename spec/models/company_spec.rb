require 'rails_helper'

RSpec.describe Company, type: :model do
  before do
    @company = FactoryGirl.create(:company)
  end

  subject { @company }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:web) }
  it { should respond_to(:roles) }
  it { should respond_to(:destroyable?)}

  it 'should have correct number of assotiations' do
    expect(@company.roles.length).to eq(4)
  end

  it {expect(@company.roles).to respond_to(:admins)}

  it 'should have admin role on creation' do
    expect(@company.roles.admins.first.admin).to be_truthy
  end

  it 'should return all admin roles' do
    @company.roles << FactoryGirl.create(:admin_role)
    expect(@company.roles.admins.count).to be(2)
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

    it 'should be invalid with bad web field' do
      urls = ['erpalladium.com', 'some.adress.com/', 'http://', 'http://some']
      urls.each do |url|
        @company.web = url
        expect(@company).not_to be_valid
      end
    end

    it 'should be valide with proper web field' do
      urls = ['http://erpalladium.com', 'https://some.adress.com/']
      urls.each do |url|
        @company.web = url
        expect(@company).to be_valid
      end
    end
  end

  it {expect(@company).to have_many(:projects)}

  describe 'when destroying company' do
    describe 'with no users on roles' do

      before { @company.destroy }

      it 'should not be seen commonly' do
        expect(Company.count).to be(0)
      end

      it 'should have field deleted_at not nil' do
        expect(Company.where(:deleted_at.ne => nil).count).to be(1)
      end
    end

    describe 'with only one admin user' do
      before do
        @user = FactoryGirl.create(:user, roles: [@company.roles.admins.first])
        @company.roles.admins.first.users << @user
        @company.save
        @company.destroy
      end

      it 'should be destroyed' do
        expect(@company.destroyed?).to be_truthy
      end

      it 'should destroy all related roles' do
        expect(Role.where(:company_id => @company.id).count).to eq(0)
      end
    end

    describe 'with other users on admin role' do
      before do
        @user_a = FactoryGirl.create(:user)
        @user_b = FactoryGirl.create(:user)
        @company.roles.admins.first.users << @user_a
        @company.roles.admins.first.users << @user_b
        @company.save
        @company.destroy
      end
      it 'should not be destroyed' do
        expect(@company.destroyed?).to be_falsey
      end
    end

    describe 'with users on other roles' do
      before do
          @user_a = FactoryGirl.create(:user)
          @user_b = FactoryGirl.create(:user)
          @company.roles.admins.first.users << @user_a
          @company.roles[2].users << @user_b
          @company.save
          @company.destroy
      end
      it 'should not be destroyed' do
        expect(@company.destroyed?).to be_falsey
      end
    end
  end
end

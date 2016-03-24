require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:name) }
  it { should respond_to(:initials) }

  it { should be_valid }

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    it do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.password = @user.password
      user_with_same_email.password_confirmation = @user.password_confirmation
      user_with_same_email.save
      should_not be_valid
    end
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = "" }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify do
        expect(user_for_invalid_password).to be(false)
      end
    end
  end

  describe 'when initials are present' do
    before do
      @user.initials = 'kz'
      @user.save
    end

    let(:initials) { @user.initials }

    it 'should be uppercase' do
      expect(initials).to eq('KZ')
    end
  end

  describe 'when initials are not present' do
    before do
      @user.name = 'John doe'
      @user.initials = ''
      @user.save
      @user = User.find(@user._id)
    end

    let(:initials) { @user.initials }

    it 'should generate them from name' do
      expect(initials).to eq('JD')
    end
  end

  describe 'with roles' do
    before do
      @companyA = FactoryGirl.create(:company, role_count: 5) #company where user have other role
      @companyB = FactoryGirl.create(:company, role_count: 0) #company where user have no roles
      @companyC = FactoryGirl.create(:company, role_count: 3) #company where user have admin role
      @roleInA = @companyA.roles[2]
      @roleInC = @companyC.roles.first
      @user = FactoryGirl.create(:user,
                                 roles: [
                                     @roleInA,
                                     @roleInC
                                 ])
    end

    it 'should have roles in company' do
      expect(@user.roles.length).to eq(2)
      expect(@user.roles).to include(@roleInA)
      expect(@user.roles).to include(@roleInC)
    end

    it {should respond_to(:companies)}

    it 'shoud have correct company list' do
      expect(@user.companies.length).to eq(2)
      expect(@user.companies).to include(@companyA)
      expect(@user.companies).not_to include(@companyB)
      expect(@user.companies).to include(@companyC)
    end

    it {expect(@user.roles).to respond_to(:for)}

    it 'should return correct roles list for company' do
      expect(@user.roles.for(@companyA).first.name).to eq(@companyA.roles[2].name)
      expect(@user.roles.for(@companyC).first.name).to eq(@companyC.roles[0].name)
    end
  end
end

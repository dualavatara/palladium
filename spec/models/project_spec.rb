require 'rails_helper'

RSpec.describe Project, type: :model do
  before do
    @project = FactoryGirl.build(:project)
  end

  subject { @project }

  it {should respond_to(:name)}

  it 'should have valid name at least 1 char' do
    subject.name = ''
    expect(subject).not_to be_valid
  end

  it {should belong_to(:company)}

  describe 'always belong to company' do
    it 'should be invalid without company' do
      expect(subject).not_to be_valid
    end
    it 'should be valid with company' do
      subject.company = FactoryGirl.build(:company, role_count: 1)
      expect(subject).to be_valid
    end
  end

  describe 'reference to users' do
    it 'should has_and_belongs_to_many users' do
      expect(subject).to have_and_belong_to_many(:users).of_type(User)
    end
  end

end

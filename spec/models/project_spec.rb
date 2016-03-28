require 'rails_helper'

RSpec.describe Project, type: :model do
  before do
    @company = FactoryGirl.build(:company)
    @project = FactoryGirl.build(:project, company: @company)
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
      subject.company = nil
      expect(subject).not_to be_valid
    end

    it 'should be valid with company' do
      subject.company = FactoryGirl.build(:company)
      expect(subject).to be_valid
    end
  end

  describe 'reference to users' do
    it 'should has_and_belongs_to_many users' do
      expect(subject).to have_and_belong_to_many(:users).of_type(User)
    end
  end

  describe 'destroy' do
    before do
      @company.save
      @project.save
    end

    describe 'without users' do
      before { @project.destroy }
      it 'should be marked as deleted' do
        expect(Project.where(:deleted_at.ne => nil).count).to be(1)
      end
    end

    describe 'with users having it' do
      before do
        @projects = ('A'..'C').collect { |c| FactoryGirl.create(:project, name:"Project #{c}", company: @company)}
        @user_a = FactoryGirl.create(:user, projects: @projects)
        @user_b = FactoryGirl.create(:user, projects: @projects, current_project: @projects.last) #user have this project
      end

      describe 'as current' do
        before { @projects.last.destroy }
        it 'should set user`s current to nil' do
          expect(User.find(@user_b.id).current_project?).to be_falsey
        end
      end

      describe 'as not current' do
        before { @projects.first.destroy }
        it 'should be marked as deleted' do
          expect(Project.where(:_id => @projects.first.id, :deleted_at.ne => nil).count).to be(1)
        end
      end
    end
  end
end

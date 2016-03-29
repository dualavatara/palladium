require 'rails_helper'
require 'support/shared_examples'
require 'support/users'

RSpec.describe "Tasks", type: :request do
  include UsersRspecHelpers
  before do
    @company = FactoryGirl.create(:company)
    @user = create_signin()
    @user.current_project = @company.projects.first
    @user.save

    visit new_task_path
  end

  subject { page }

  describe 'new' do
    it { should have_panel('new_task') }

    describe 'with proper fields' do
      before do
        fill_in 'Name', with: 'Some name'
        fill_in 'Description', with: 'Some description'
        click_button 'Add'
      end

      it 'should add task to database' do
        expect(Task.count).to eq(1)
      end

      it 'should redirect to tasks page' do
        expect(page).to have_current_path(tasks_path)
      end
    end

    describe 'with wrong fields' do
      before do
        fill_in 'Name', with: ''
        fill_in 'Description', with: 'Some description'
        click_button 'Add'
      end

      it 'should be on tasks page' do
        expect(page).to have_current_path(tasks_path)
      end

      it 'should contatin errors' do
        expect(page).to have_css('.text-danger')
      end

      it 'should not add task to database' do
        expect(Task.count).to eq(0)
      end
    end

  end
end

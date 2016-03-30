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
    @user.current_project.users << @user
    @user.current_project.save
  end

  subject { page }

  describe 'new' do
    before { visit new_task_path }

    it { should have_panel('new_task') }

    it 'should have current user selected for requester_id' do
      expect(page).to have_select('task_requester_id', selected: @user.name)
    end

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

      it 'should contain name, description, type and requester' do
        Task.where(project_id: @user.current_project.id).each do |task|
          within ("tr#task_#{task.id}") do
            expect(page).to have_content(task.name)
            expect(page).to have_content(task.desc)
            expect(page).to have_content(task.type)
            expect(page).to have_content(@user.name)
          end
        end
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
  describe 'index' do
    before do
      visit tasks_path
    end

    it 'should show task list' do
      expect(page).to have_object_table(@user.current_project.tasks)
    end
  end

  describe 'delete' do
    before do
      @task_id = @user.current_project.tasks.second.id
      visit tasks_path
      click_link('Delete', href: task_path(@task_id))
    end

    it 'should remove task from list' do
      expect(page).not_to have_css("tr#task_#{@task_id}")
    end

    it 'should remove task from db' do
      expect(Task.where(id: @task_id).count).to eq(0)
    end
  end
end

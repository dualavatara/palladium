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
        expect(Task.where( :name => 'Some name').count).to eq(1)
      end

      it 'should redirect to tasks page' do
        expect(page).to have_current_path(tasks_path)
      end

      it 'should contain name, description, type and requester' do
        Task.where( :name => 'Some name').each do |task|
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
        expect(Task.where( :name => '').count).to eq(0)
      end
    end

    describe 'with owners selected' do
      before do
        @other_users = FactoryGirl.create_list(:user, 3, projects: @company.projects)
        @company.projects.each do |project|
          project.users << @other_users
          project.save
        end
        visit new_task_path
        fill_in 'Name', with: 'Some name'
        fill_in 'Description', with: 'Some description'
        select @other_users.second.name, from: 'task_owner_ids'
        select @other_users.last.name, from: 'task_owner_ids'
        click_button 'Add'
      end

      it 'should add task to database with owners' do
        task = Task.find_by(name: 'Some name')
        expect(task.owners).to include(@other_users.second)
        expect(task.owners).to include(@other_users.last)
        # expect(Task.count).to eq(1)
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

  describe 'update_state' do
    before do
      @task = Task.where(project_id: @user.current_project.id).all.first
      visit tasks_path
    end

    it 'should translate task states to accepted' do
      within ("tr#task_#{@task.id}") {click_link 'Start'}
      expect(page).to have_link('Finish')
      within ("tr#task_#{@task.id}") {click_link 'Finish'}
      expect(page).to have_link('Deliver')
      within ("tr#task_#{@task.id}") {click_link 'Deliver'}
      expect(page).to have_link('Accept')
      expect(page).to have_link('Reject')
      within ("tr#task_#{@task.id}") {click_link 'Accept'}
      expect(page).to have_css('.bg-success')
    end

    it 'should translate task states to rejected' do
      within ("tr#task_#{@task.id}") {click_link 'Start'}
      expect(page).to have_link('Finish')
      within ("tr#task_#{@task.id}") {click_link 'Finish'}
      expect(page).to have_link('Deliver')
      within ("tr#task_#{@task.id}") {click_link 'Deliver'}
      expect(page).to have_link('Accept')
      expect(page).to have_link('Reject')
      within ("tr#task_#{@task.id}") {click_link 'Reject'}
      expect(page).to have_link('Restart')
      within ("tr#task_#{@task.id}") {click_link 'Restart'}
      within ("tr#task_#{@task.id}") {expect(page).to have_link('Finish')}
    end
  end
end

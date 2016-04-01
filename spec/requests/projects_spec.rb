require 'rails_helper'
require 'support/users'
require 'support/shared_examples'

RSpec.describe "Projects", type: :request do
  include UsersRspecHelpers

  before do
    @company = FactoryGirl.create(:company)
    @user = FactoryGirl.create(:user,roles: [@company.roles.admins.first])
    @company.roles.admins.first.users << @user
    @company.roles.admins.first.save
    signin(@user.email, @user.password)
  end

  describe 'new' do
    before do
      visit "/companies/#{@company.id}/projects/new"
    end

    describe 'with no projects created' do
      describe 'with correct fields' do
        before do
          fill_in 'Name', with: 'Sample project'
          click_button 'Add'
        end

        it 'should redirect to company profile' do
          expect(page).to have_current_path(company_path(@company))
        end

        it 'should be added to users projects' do
          @user = User.find(@user.id)
          expect(@user.projects.count).to eq(1)
        end

        it 'should set user`s current project' do
          @user = User.find(@user.id)
          expect(@user.current_project.name).to eq('Sample project')
        end
      end
    end

    describe 'with projects created' do
      before do
        fill_in 'project_name', with: 'Existing project'
        click_button 'Add'
        visit "/companies/#{@company.id}/projects/new"
        fill_in 'project_name', with: 'Sample project'
        click_button 'Add'
      end

      it 'should not change user`s current project' do
        @user = User.find(@user.id)
        expect(@user.current_project.name).to eq('Existing project')
      end
    end
  end

  describe 'current_project' do
    before do
      @project_a = FactoryGirl.create(:project, company: @company, name: 'First')
      @project_b = FactoryGirl.create(:project, company: @company, name: 'Second')
      @user.projects = [@project_a, @project_b]
      @user.current_project = @project_a
      @user.save
      visit '/'
    end

    it 'should change current project' do
      within('header') do
        click_link 'Second'
      end
      @user = User.find(@user.id)
      expect(@user.current_project).to eq(@project_b)
    end

    it 'should change header current project' do
      within('header') do
        click_link 'Second'
      end
      expect(page).to have_css('a.dropdown-toggle', text: @project_b.name)
    end
  end

  describe 'delete' do
    before do
      @projects = ('A'..'C').collect { |c| FactoryGirl.create(:project, name:"Project #{c}", company: @company)}
      @user.projects = @projects
      @user.current_project = @projects.first
      @user.save
      visit company_path(@company)
    end

    describe 'by admin' do
      it 'should redirect to company page' do
        click_link('Delete', href: project_path(@projects.first.id))
        expect(page).to have_current_path(company_path(@company))
      end

      it 'should not have it in list' do
        click_link('Delete', href: project_path(@projects.first.id))
        expect(page).not_to have_content(@projects.first.name)
      end
    end

    describe 'by not admin' do
      before do
        @company.roles.admins.first.users = []
        @company.roles.admins.first.save
      end

      it 'should have it in list' do
        click_link('Delete', href: project_path(@projects.first.id))
        expect(page).to have_content(@projects.first.name)
      end

      it 'should have no delete link'
    end
  end
end

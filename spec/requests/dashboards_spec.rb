require 'rails_helper'
require 'support/users'
require 'support/shared_examples'

RSpec.describe "Dashboards", type: :request do

  include UsersRspecHelpers

  before do
    @projects = FactoryGirl.create_list(:project, 3)
    @user = create_signin
    @user.projects = @projects
    @user.save
    visit '/dashboard'
  end

  it 'should have Projects header' do
    expect(page).to have_content('Projects')
  end

  it 'should have project panels' do
    @projects.each do |project|
      expect(page).to have_panel("project_#{project.id}")
    end
  end

  it 'should have correct features count' do
    expect(page).to have_content("Features : 3")
  end

  it 'should have correct stories count' do
    expect(page).to have_content("Stories : 9")
  end

  it 'should have correct tasks count' do
    expect(page).to have_content("Tasks : 3")
  end
end

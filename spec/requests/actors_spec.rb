require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "Actors", type: :request do
  before do
    @company = FactoryGirl.create(:company)
    @project = @company.projects.first

  end

  subject { page }

  describe 'index' do
    before {visit project_actors_path(@project.id)}

    it {should have_panel('actors')}
    it {should have_content(@project.actors.first.name)}
  end


  describe 'new' do
    before do
      visit new_project_actor_path(@project.id)
    end

    it 'should have new form' do
      expect(page).to have_css("form#new_actor")
    end

    it 'should redirect to actors list' do
      fill_in 'Name', with: 'Test actor'
      fill_in 'Description', with: 'Some text here'
      click_button 'Add'
      expect(page).to have_current_path(project_actors_path(@project.id))
    end

    it 'should show errors on misfilled' do
      fill_in 'Name', with: ''
      fill_in 'Description', with: 'Some text here'
      click_button 'Add'
      expect(page).to have_css('.field_with_errors')
    end

    it 'should have new actor on actors list' do
      fill_in 'Name', with: 'Test actor 2'
      fill_in 'Description', with: 'Some text here'
      click_button 'Add'

      expect(page).to have_content('Test actor 2')
    end
  end
end

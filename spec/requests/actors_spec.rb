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

  describe 'edit' do
    before do
      @actor = @project.actors.first
      visit edit_actor_path(@actor.id)
    end

    it 'should have edit_actor form' do
      expect(page).to have_css("form#edit_actor_#{@actor.id}")
    end
  end

  describe 'update' do
    before do
      @actor = @project.actors.first
      visit edit_actor_path(@actor.id)
    end

    describe 'with valid fields' do
      before do
        fill_in 'Name', with: 'Edited name'
        fill_in 'Description', with: 'Edited description'
        click_button 'Save'
      end

      it 'should edit object in db' do
        @obj = Actor.find(@actor.id)
        expect(@obj.name).to eq('Edited name')
        expect(@obj.desc).to eq('Edited description')
      end

      it 'should redirect to project actors' do
        expect(page).to have_current_path(project_actors_path(@project.id))
      end
    end

    describe 'with invalid fields' do
      before do
        fill_in 'Name', with: ''
        fill_in 'Description', with: ''
        click_button 'Save'
      end

      it 'should not edit object in db' do
        @obj = Actor.find(@actor.id)
        expect(@obj.name).to eq(@actor.name)
        expect(@obj.desc).to eq(@actor.desc)
      end

      it 'should have edit form' do
        expect(page).to have_css("form#edit_actor_#{@actor.id}")
      end

      it 'should have errors for invalid fields' do
        expect(page).to have_css('.text-danger')
      end
    end


  end

  describe 'destroy' do
    before do
      visit project_actors_path(@project.id)
      within("tr#actor_#{@actor.id}") do
        click_link 'Delete'
      end
    end

    it 'should redirect to actors list' do
      expect(page).to have_current_path(project_actors_path(@project.id))
    end

    it 'should not contain deleted actor' do
      expect(page).not_to have_css("tr#actor_#{@actor.id}")
    end
  end
end

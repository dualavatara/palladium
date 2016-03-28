require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "Stories", type: :request do
  before do
    @feature = FactoryGirl.create(:feature)
  end

  subject { page }

  describe 'index' do
    before {visit feature_stories_path(@feature.id)}

    it {should have_panel('stories')}
    it {should have_content(@feature.stories.first.name)}
  end

  describe 'new' do
    before do
      visit new_feature_story_path(@feature.id)

    end

    it 'should create story and redirect to feature page' do
      fill_in 'Name', with: 'New sample story'
      fill_in 'Description', with: 'Some text'
      select(@feature.project.actors.second.name, :from => 'story_actor_id')
      click_button 'Add'

      expect(page).to have_current_path(feature_stories_path(@feature.id))
      expect(page).to have_content('New sample story')
      expect(page).not_to have_css('form#new_story')
    end

    it 'should return error with no actor' do
      fill_in 'Name', with: 'New sample story'
      fill_in 'Description', with: 'Some text'
      click_button 'Add'
      expect(page).to have_css('.text-danger')
    end

  end
end

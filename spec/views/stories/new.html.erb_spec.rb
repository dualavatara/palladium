require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "stories/new", type: :view do

  before do
    @feature = FactoryGirl.create(:feature)
    @story = FactoryGirl.build(:story, feature: @feature)
    render
  end

  subject {rendered}

  it 'should have new story panel' do
    expect(subject).to have_panel('new_story')
  end

  it 'should have new story form' do
    expect(subject).to have_css('form#new_story')
  end

  it 'should have name edit' do
    expect(subject).to have_field('story_name')
  end
  it 'should have description edit' do
    expect(subject).to have_field('story_desc')
  end

  it 'should have actor edit' do
    expect(subject).to have_select('story_actor_id')
  end

  it 'should have Add submit' do
    expect(subject).to have_button('Add')
  end
end

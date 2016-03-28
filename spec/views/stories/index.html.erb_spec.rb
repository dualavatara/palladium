require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "stories/index.html.erb", type: :view do
  before do
    @feature = FactoryGirl.create(:feature)
    @stories = @feature.stories
    render
  end

  subject { rendered }

  it {should have_panel("stories")}

  it 'should have list of stories' do
    expect(rendered).to have_object_table(@stories)
  end

  it {should have_content(@stories.first.name)}
  it {should have_content(@stories.first.desc)}
  it {should have_link('Add', href:new_feature_story_path(@feature.id))}

  it 'should have Delete link for objects' do
    @stories.each do |story|
      expect(rendered).to have_link('Delete', href: story_path(story))
    end
  end

end

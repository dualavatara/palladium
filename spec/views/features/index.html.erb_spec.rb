require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "features/index.html.erb", type: :view do
  before do
    @project = FactoryGirl.create(:project)
    @features = @project.features
    render
  end

  it 'should have features list' do
    expect(rendered).to have_object_table(@features)
  end

  it 'should have Add link' do
    expect(render).to have_link('Add', href: new_project_feature_path(@project.id))
  end

  it 'should have Delete link' do
    expect(render).to have_link('Delete', href: feature_path(@features.first.id))
  end

  it 'should have link to stories from name' do
    @features.each do |feature|
      expect(render).to have_link(feature.name, href: feature_stories_path(feature.id))
    end
  end
end

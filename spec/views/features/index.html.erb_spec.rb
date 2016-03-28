require 'rails_helper'
require 'support/features.rb'

RSpec.describe "features/index.html.erb", type: :view do
  include FeaturesRspecHelpers
  before do
    @features = build_features
    assign(:features, @features)
    render
  end

  it 'should have features list' do
    ('A'..'C').each { |c| expect(render).to have_content("Req #{c}") }
  end

  it 'should have Add link' do
    expect(render).to have_link('Add', href: new_project_feature_path(@project.id))
  end

  it 'should have Delete link' do
    expect(render).to have_link('Delete', href: project_feature_path(@project.id, @features.first.id))
  end
end

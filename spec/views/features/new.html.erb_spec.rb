require 'rails_helper'
require 'support/features'

RSpec.describe "features/new.html.erb", type: :view do
  include FeaturesRspecHelpers
  before do
    @reqs = build_features
    assign(:project, @project)
    assign(:feature, Feature.new)
    render
  end

  it 'should have form with post method and /project/:project_id/features action' do
    expect(rendered).to have_css("form#new_feature[method=post][action='#{project_features_path(@project.id)}']")
  end
end

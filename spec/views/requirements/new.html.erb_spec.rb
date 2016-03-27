require 'rails_helper'
require 'support/requirements'

RSpec.describe "requirements/new.html.erb", type: :view do
  include RequierementsRspecHelpers
  before do
    @reqs = build_requirements
    assign(:project, @project)
    assign(:requirement, Requirement.new)
    render
  end

  it 'should have form with post method and /project/:project_id/requirements action' do
    expect(rendered).to have_css("form#new_requirement[method=post][action='#{project_requirements_path(@project.id)}']")
  end
end

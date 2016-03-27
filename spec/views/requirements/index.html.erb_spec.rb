require 'rails_helper'
require 'support/requirements.rb'

RSpec.describe "requirements/index.html.erb", type: :view do
  include RequierementsRspecHelpers
  before do
    @reqs = build_requirements
    assign(:requirements, @reqs)
    render
  end

  it 'should have requirements list' do
    ('A'..'C').each {|c| expect(render).to have_content("Req #{c}") }
  end

  it 'should have Add link' do
    expect(render).to have_link('Add', href: new_project_requirement_path(@project.id))
  end

end

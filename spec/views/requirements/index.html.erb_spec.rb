require 'rails_helper'

RSpec.describe "requirements/index.html.erb", type: :view do
  before do
    @company = FactoryGirl.build(:company)
    @project = FactoryGirl.build(:project, company: @company)
    @reqs = ('A'..'C').collect { |c| FactoryGirl.build(:requirement, name: "Req #{c}", project: @project) }
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

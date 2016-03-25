require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "projects/_index.html.erb", type: :view do
  before do
    @company = FactoryGirl.build(:company)
    @project_a = FactoryGirl.build(:project, name: 'Project A', id: 1, company: @company)
    @project_b = FactoryGirl.build(:project, name: 'Project B', id: 2, company: @company)
    assign(:projects, [@project_a, @project_b])
    render
  end

  subject { rendered }

  it_behaves_like 'has panel', "projects"

  it 'should have Add link for admin' do
    expect(subject).to have_link('Add', href: new_company_project_path(@company.id))
  end
  it 'should have rows with project data' do
    expect(subject).to have_css("tr td", text: 'Project A')
    expect(subject).to have_css("tr td", text: 'Project B')
  end
end

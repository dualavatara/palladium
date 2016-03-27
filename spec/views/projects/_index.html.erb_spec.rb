require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "projects/_index.html.erb", type: :view do
  before do
    @company = FactoryGirl.build(:company, id: 777)
    @project_a = FactoryGirl.build(:project, name: 'Project A', id: 1, company: @company)
    @project_b = FactoryGirl.build(:project, name: 'Project B', id: 2, company: @company)
    assign(:projects, [@project_a, @project_b])
    @path_a = project_path(@project_a.id)
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

  it 'should have link to project show' do
    expect(subject).to have_link('Project A', href: @path_a)
  end

  it 'should have Delete link' do
    expect(subject).to have_link('Delete', project_path(@project_a.id))
  end

  it 'should not have target="_blank on link"' do
    expect(subject).not_to have_css("a[href='#{@path_a}'][target=blank]")
  end

end

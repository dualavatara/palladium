require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "actors/index.html.erb", type: :view do
  before do
    @company = FactoryGirl.create(:company)
    @project = @company.projects.first
    @actors = @project.actors
    render
  end

  subject { rendered }

  it {should have_panel('actors')}

  it 'should have list of actors' do
    expect(rendered).to have_object_table(@actors)
  end

  it {should have_content(@actors.first.name)}
  it {should have_content(@actors.first.desc)}
  it {should have_link('Add', href:new_project_actor_path(@project.id))}
end

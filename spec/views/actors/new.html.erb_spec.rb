require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "actors/new", type: :view do
  before do
    @company = FactoryGirl.create(:company)
    @project = @company.projects.first
    @actors = @project.actors
    assign(:actor, @actors.new)
    assign(:project, @project)
    render
  end

  subject { rendered }

  it {should have_panel('new_actor')}
  it {should have_css('form#new_actor')}
end

require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "Actors", type: :request do
  before do
    @company = FactoryGirl.create(:company)
    @project = @company.projects.first
    visit project_actors_path(@project.id)
  end

  subject { page }

  it {should have_panel('actors')}
  it {should have_content(@project.actors.first.name)}
end

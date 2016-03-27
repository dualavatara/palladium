require 'rails_helper'

RSpec.describe "Requirements", type: :request do
  before do
    @company = FactoryGirl.create(:company)
    @project = FactoryGirl.create(:project, company: @company)
    @reqs = ('A'..'C').collect { |c| FactoryGirl.create(:requirement, name: "Req #{c}", project: @project) }
  end

  describe 'index for project_id' do
    before do
      visit project_requirements_path(@project.id)
    end

    it 'should list requirements' do
      ('A'..'C').each {|c| expect(page).to have_content("Req #{c}") }
    end
  end
end

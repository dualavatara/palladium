require 'rails_helper'

RSpec.describe "Requirements", type: :request do
  before do
    @company = FactoryGirl.create(:company)
    @project = FactoryGirl.create(:project, company: @company)
    @reqs = ('A'..'C').collect { |c| FactoryGirl.create(:requirement, name: "Req #{c}", project: @project) }
  end

  describe 'for project_id in requiest ' do
    describe 'index' do
      before do
        visit project_requirements_path(@project.id)
      end

      it 'should list requirements' do
        ('A'..'C').each { |c| expect(page).to have_content("Req #{c}") }
      end
    end

    describe 'new' do
      before do
        visit new_project_requirement_path(@project.id)
      end
      it 'should have new form' do
        expect(page).to have_css("form#new_requirement")
      end
    end
  end
end

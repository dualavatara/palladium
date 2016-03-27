require 'rails_helper'

RSpec.describe "Features", type: :request do
  before do
    @company = FactoryGirl.create(:company)
    @project = FactoryGirl.create(:project, company: @company)
    @reqs = ('A'..'C').collect { |c| FactoryGirl.create(:feature, name: "Req #{c}", project: @project) }
  end

  describe 'for project_id in requiest ' do
    describe 'index' do
      before do
        visit project_features_path(@project.id)
      end

      it 'should list features' do
        ('A'..'C').each { |c| expect(page).to have_content("Req #{c}") }
      end
    end

    describe 'new' do
      before do
        visit new_project_feature_path(@project.id)
      end
      it 'should have new form' do
        expect(page).to have_css("form#new_feature")
      end
    end
  end
end

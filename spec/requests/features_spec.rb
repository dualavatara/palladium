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

      it 'should redirect to project on submit' do
        fill_in 'Name', with: 'Test feature'
        fill_in 'Description', with: 'Some text here'
        click_button 'Add'
        expect(page).to have_current_path(project_features_path(@project.id))
      end

      it 'should show errors on misfilled' do
        fill_in 'Name', with: ''
        fill_in 'Description', with: 'Some text here'
        click_button 'Add'
        expect(page).to have_css('.field_with_errors')
      end
    end
  end
end

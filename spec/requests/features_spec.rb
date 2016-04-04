require 'rails_helper'

RSpec.describe "Features", type: :request do
  before do
    @company = FactoryGirl.create(:company)
    @project = FactoryGirl.create(:project, company: @company)
    @features = ('A'..'C').collect { |c| FactoryGirl.create(:feature, name: "Feature #{c}", project: @project) }
  end

  describe 'for project_id in request ' do
    describe 'index' do
      before do
        visit project_features_path(@project.id)
      end

      it 'should list features' do
        ('A'..'C').each { |c| expect(page).to have_content("Feature #{c}") }
      end
    end

    describe 'new' do
      before do
        visit new_project_feature_path(@project.id)
      end

      it 'should have new form' do
        expect(page).to have_css("form#new_feature")
      end

      it 'should redirect to feature list' do
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

    describe 'destroy' do
      before do
        visit project_features_path(@project.id)
        within("tr#feature_#{@features[1].id}") do
          click_link 'Delete'
        end
      end

      it 'should redirect to feature list' do
        expect(page).to have_current_path(project_features_path(@project.id))
      end

      it 'should not contain deleted feature' do
        expect(page).not_to have_css("tr##{@features[1].id}")
      end
    end
  end
end

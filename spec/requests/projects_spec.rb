require 'rails_helper'
require 'support/users'
require 'support/shared_examples'

RSpec.describe "Projects", type: :request do
  include UsersRspecHelpers

  describe 'new' do
    before do

      @company = FactoryGirl.build(:company)
      @project = FactoryGirl.build(:project, company: @company)
      @company.projects << @project
      @company.save

      @user = FactoryGirl.create(:user,roles: [@company.roles.admins.first])

      user_signin(@user.email, @user.password)
      visit "/companies/#{@company.id}/projects/new"
    end
    describe 'with correct fields' do
      before do
        fill_in 'Name', with: 'Sample project'
        click_button 'Add'
      end

      it 'should redirect to company profile' do
        expect(page).to have_current_path(company_path(@company))
      end
    end

  end
end

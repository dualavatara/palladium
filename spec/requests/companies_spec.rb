require 'rails_helper'
require 'support/users'

RSpec.describe "Companies", type: :request do
  include UsersRspecHelpers

  before do
    @companies = [
        FactoryGirl.create(:company, name: 'Company A'),
        FactoryGirl.create(:company, name: 'Company B'),
        FactoryGirl.create(:company, name: 'Company C')
    ]

    @user = FactoryGirl.create(:user,
                              roles: [
                                  @companies[0].roles[0], # role in first company
                                  @companies[2].roles[1], # role in third company
                                  @companies[2].roles[3], # role in third company
                              ])
    user_signin
  end

  describe 'company list' do

    before {visit '/companies'}

    it 'should have first and third company' do
      expect(page).to have_content('Company A')
      expect(page).to have_content('Company C')
    end
    it 'should not have second company' do
      expect(page).not_to have_content('Company B')
    end
    it 'should have correct roles names in company rows' do
      within('tr', text:'Company A') do
        expect(page).to have_content(@companies[0].roles[0].name)
      end

      within('tr', text:'Company C') do
        expect(page).to have_content("#{@companies[2].roles[1].name}, #{@companies[2].roles[3].name}")
      end
    end
  end
end

require 'rails_helper'
require 'support/users'

RSpec.describe "Companies", type: :request do
  include UsersRspecHelpers

  before do
    @company_a = FactoryGirl.create(:company, name: 'Company A')
    @company_b = FactoryGirl.create(:company, name: 'Company B')
    @company_c = FactoryGirl.create(:company, name: 'Company C')
    @company_d = FactoryGirl.create(:company, name: 'Company D')


    @user = FactoryGirl.create(:user,
                              roles: [
                                  @company_a.roles.admins.first, # admin role in first company
                                  @company_b.roles[1], # common role in third company
                                  @company_c.roles[1], # common role in third company
                                  @company_c.roles[3], # common role in third company
                              ])
    user_signin(@user.email, @user.password)
  end

  describe 'index' do

    before {visit '/companies'}

    it 'should have first and third company' do
      expect(page).to have_content('Company A')
      expect(page).to have_content('Company C')
    end

    it 'should not have fourth company' do
      expect(page).not_to have_content('Company D')
    end

    it 'should have correct roles names in company rows' do
      within('tr', text:'Company A') do
        expect(page).to have_content(@company_a.roles[0].name)
      end

      within('tr', text:'Company C') do
        expect(page).to have_content("#{@company_c.roles[1].name}, #{@company_c.roles[3].name}")
      end
    end
  end

  describe 'new' do
    before { visit '/companies/new' }
    it 'should have new_company form' do
      expect(page).to have_css("#new_company")
    end

    describe 'with valid company data' do
      before do
        fill_in 'company_name', with: 'My company Inc.'
        fill_in 'company_email', with: 'info@myconpany.com'
        fill_in 'company_web', with: 'http://www.myconpany.com'
        click_button 'Add'
      end

      it 'should redirect to companies page' do
        expect(page).to have_current_path(companies_path)
      end

      it 'should have new company in list with me as admin' do
        expect(page).to have_content('My company Inc.')
        within('tr', text:'My company Inc.') do
          expect(page).to have_content("admin")
        end
      end

    end

    describe 'with invalid data' do
      it 'should have errors near fields' do
        click_button 'Add'
        expect(page).to have_content('Name can\'t be blank')
      end
    end
  end

  describe 'delete' do
    describe 'by admin user' do
      before do
        visit '/companies'
        within("tr#company_#{@company_a.id}") { click_link("Delete") }
      end

      it 'should redirect to /companies' do
        expect(page).to have_current_path(companies_path)
      end

      it 'shouldn`t place company on page`' do
        expect(page).not_to have_content(@company_a.name)
      end

    end

    describe 'by not admin user' do
      before do
        visit '/companies'
      end

      it 'should be no Delete link' do
        within("tr#company_#{@company_b.id}") { expect(page).not_to have_link('Delete') }
      end
    end
  end

  context 'show' do
    describe 'by user in admin role' do
      before { visit company_path(@company_a)}

      it 'should have company panel' do
        expect(page).to have_css("div.panel#company_#{@company_a.id}")
      end

      it 'should have edit link' do
        expect(page).to have_link('Edit', href: edit_company_path(@company_a.id))
      end

      it 'should have projects panel' do

      end
    end

    describe 'by user in other role' do
      before { visit company_path(@company_b)}

      it 'should have company panel' do
        expect(page).to have_css("div.panel#company_#{@company_b.id}")
      end

      it 'should not have edit link' do
        expect(page).not_to have_link('Edit', href: edit_company_path(@company_b.id))
      end
    end

    describe 'by user in no role' do
      before { visit company_path(@company_d)}

      it {expect(page).to have_current_path(companies_path)}
    end
  end

  describe 'edit' do
    before do
      visit edit_company_path(@company_a)
    end

    it 'has form' do
      expect(page).to have_css("form#edit_company_#{@company_a.id}")
    end

    describe 'changed name and submitted' do
      before do
        fill_in 'company_name', with: 'Sample name'
        click_button 'Edit'
      end
      it 'should have no form on page' do
        expect(page).not_to have_css("form#edit_company_#{@company_a.id}")
      end
      it 'should have new name on page' do
        expect(page).to have_content('Sample name')
      end
    end
  end
end

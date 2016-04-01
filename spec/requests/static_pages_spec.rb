require 'rails_helper'
require 'support/users'

RSpec.describe "StaticPages", type: :request do

  include UsersRspecHelpers

  describe "Home page" do
    it "should have title 'Palladium'" do
      visit '/'
      expect(page).to have_title('Palladium')
    end

    it "should have 'Sign In' link" do
      visit '/'
      expect(page).to have_link('Sign In', href: '/signin')
    end

    it "should have 'Sign Up' link" do
      visit '/'
      expect(page).to have_link('Sign Up', href: '/signup')
    end

    describe 'redirects signed in user to dashboard' do
      before do
        @user = create_signin()
        visit '/'
      end

      it 'should have dashboard_path current url' do
        expect(page).to have_current_path(dashboard_path)
      end

      it 'should have Dashboard title' do
        expect(page).to have_title('Dashboard')
      end
    end
  end
end

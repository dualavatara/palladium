require 'rails_helper'
require 'support/users'

RSpec.describe "Authentications", type: :request do

  include UsersRspecHelpers

  before do
    @user = FactoryGirl.create(:user)
    Capybara.reset_sessions!
    visit '/signin'
  end

  describe "Signing in" do


    describe "on successful authentication" do
      it 'should redirect to root_path' do
        user_signin(@user.email, @user.password)
        expect(page).to have_current_path(root_path)
      end
    end

    describe "on failed authentication" do
      before do
        fill_in "authentication_email", with: "test@test.com"
        fill_in "authentication_password", with: "wrongpass"
        click_button 'signin'
      end

      it 'should have filled email and empty password fields' do
        expect(page).to have_field('authentication_email', with: 'test@test.com')
        expect(page).to have_field('authentication_password', with: '')
      end
    end
  end

  describe "Signing out" do
    before do
      user_signin(@user.email, @user.password)
    end

    specify "should route to root after sign out button" do
      click_link('signout_btn')
      expect(page).to have_current_path(root_path)
    end
  end
end

require 'rails_helper'
require 'support/users'

RSpec.describe "Authentications", type: :request do

  include UsersRspecHelpers

  before do
    @user = FactoryGirl.create(:user)

  end

  describe "Signing in" do


    describe "successful" do
      it 'should redirect to root_path' do
        signin(@user.email, @user.password)
        expect(page).to have_current_path(root_path)
      end
    end

    describe "failed" do
      before do
        signin(@user.email, "wrongpass")
      end

      it 'should have filled email field' do
        expect(page).to have_field('authentication_email', with: @user.email)
      end

      it 'should have empty password field' do
        expect(page).to have_field('authentication_password', with: '')
      end

    end
  end

  describe "Signing out" do
    before do
      signin(@user.email, @user.password)
    end

    specify "should route to root after sign out button" do
      click_link('signout_btn')
      expect(page).to have_current_path(root_path)
    end
  end
end

require 'rails_helper'
require 'show_me_the_cookies'

RSpec.describe "Users", type: :request do

  subject { page }

  describe "Register new user" do
    describe "Requesting registration form" do

      before do
        @user = FactoryGirl.create(:user)
        visit '/signup'
      end

      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button 'signup' }.not_to change(User, :count)
        end
      end

      describe "with valid information" do
        before do
          fill_in "user_email", with: "user@example.com"
          fill_in "user_name", with: "John Doe"
          fill_in "user_password", with: "foobar"
          fill_in "user_password_confirmation", with: "foobar"
        end

        it "should create a user" do
          expect { click_button 'signup' }.to change(User, :count).by(1)
        end

        it "should silently authenticate user" do
          click_button 'signup'
          visit '/signup'
          expect(page).to have_current_path(root_path)
        end

        it "should redirect user to root" do
          click_button 'signup'
          expect(page).to have_current_path(root_path)
        end
      end

      describe "for authenticated users" do
        before do
          visit '/signin'
          fill_in "authentication_email", with: "test@test.com"
          fill_in "authentication_password", with: "foobar"
          click_button 'signin'
          visit '/signup'
        end

        it "should redirect to root" do
          expect(page).to have_current_path(root_path)
        end

        it "should have no 'Sign up' and 'Sign in' links on navbar" do
          expect(page).not_to have_link('Sign In', href: signin_path)
          expect(page).not_to have_link('Sign Up', href: signup_path)
        end
      end
    end
  end

  describe 'unauthenticated user' do
    it 'should see signin page on /profile' do
      visit '/profile'
      expect(page).to have_current_path('/signin')
    end
  end
end

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

      it "should have field 'email' and label for it" do
        expect(page).to have_field('user_email')
        expect(page).to have_css('label[for=user_email]')
      end

      it "should have field 'password' and label for it" do
        expect(page).to have_field('user_password')
        expect(page).to have_css('label[for=user_password]')
      end

      it "should have field 'password_confirmation' and label for it" do
        expect(page).to have_field('user_password_confirmation')
        expect(page).to have_css('label[for=user_password_confirmation]')
      end

      it "should have 'Register' button" do
        expect(page).to have_button('signup')
      end

      it "should have 'Sign In' link" do
        expect(page).to have_link('signin', href: signin_path)
      end

      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button 'signup' }.not_to change(User, :count)
        end
      end

      describe "with valid information" do
        before do
          fill_in "user_email", with: "user@example.com"
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
          fill_in "user_email", with: "test@test.com"
          fill_in "user_password", with: "foobar"
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

  describe 'Authenticate user' do
    #we make a user in database here

    before do
      @user = FactoryGirl.create(:user)
      visit '/signin'
    end

    it 'should have id=authenticate_user form on it' do
      expect(page).to have_css('#authenticate_user')
    end

    it 'should have signin button' do
      expect(page).to have_button('signin')
    end

    it 'should have email and password fields' do
      expect(page).to have_field('user_password')
      expect(page).to have_css('label[for=user_password]')
      expect(page).to have_field('user_email')
      expect(page).to have_css('label[for=user_email]')
    end

    describe "Authentication result" do

      it "should redirect to root on success" do
        fill_in "user_email", with: "test@test.com"
        fill_in "user_password", with: "foobar"
        click_button 'signin'
        expect(page).to have_current_path(root_path)
      end

      it 'should not show login form on second visit to signin' do
        fill_in "user_email", with: "test@test.com"
        fill_in "user_password", with: "foobar"
        click_button 'signin'
        visit '/signin'
        expect(page).to have_current_path(root_path)
      end

      it 'should print errors on failure' do
        fill_in "user_email", with: "user@example.com"
        fill_in "user_password", with: "wrong pass"
        click_button 'signin'

        should have_css('.text-danger')
      end

      it "should have 'Sign Out' link" do
        fill_in "user_email", with: "test@test.com"
        fill_in "user_password", with: "foobar"
        click_button 'signin'
        expect(page).to have_link('Sign Out', href: signout_path)
      end
    end

    describe "Log out" do
      before do
        visit '/signin'
        fill_in "user_email", with: "test@test.com"
        fill_in "user_password", with: "foobar"
        click_button 'signin'
      end

      specify "should route to sign in form after sign out button" do
        click_link('signout_btn')
        visit '/signin'
        expect(page).to have_current_path(signin_path)
      end
    end
  end
end

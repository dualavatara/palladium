require 'rails_helper'

RSpec.describe "Users", type: :request do

  subject { page }

  describe "Register new user" do
    describe "Requesting registration form" do

      before {visit '/signup'}

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
          fill_in "user_email",        with: "user@example.com"
          fill_in "user_password",     with: "foobar"
          fill_in "user_password_confirmation", with: "foobar"
        end

        it "should create a user" do
          expect { click_button 'signup' }.to change(User, :count).by(1)
        end
      end
    end
  end
end

require 'rails_helper'
require 'support/users'

RSpec.describe "Users", type: :request do

  include UsersRspecHelpers

  subject { page }

  describe "register new" do
    describe "with registration form" do

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
          expect(page).to have_current_path(dashboard_path)
        end

        it "should redirect user to root" do
          click_button 'signup'
          expect(page).to have_current_path(dashboard_path)
        end
      end

      describe "for authenticated users" do
        before do
          signin(@user.email, @user.password)
          visit '/signup'
        end

        it "should redirect to root" do
          expect(page).to have_current_path(dashboard_path)
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

  describe 'user profile' do
    before do
      create_signin
      visit '/profile'
    end

    it 'should load profile form on edit link' do
      click_link 'Edit'
      expect(page).to have_field('Name')
      expect(page).to have_field('Initials')
    end

    it 'should change name and initials on profile form submit' do
      click_link 'Edit'
      fill_in "user_name", with: "John Doe"
      fill_in "user_initials", with: "JD"
      click_button 'Edit'

      usr = User.find(@user._id)
      expect(usr.name).to eq("John Doe")
      expect(usr.initials).to eq("JD")
    end

    it 'should show error on invalid name submit' do
      click_link 'Edit'
      fill_in "user_name", with: ""
      click_button 'Edit'
      expect(page).to have_css(".text-danger")
    end

    it 'should autocalc initials whem empty initials submitted' do
      click_link 'Edit'
      fill_in "user_name", with: "John Doe"
      fill_in "user_initials", with: ""
      click_button 'Edit'
      usr = User.find(@user._id)
      expect(usr.name).to eq("John Doe")
      expect(usr.initials).to eq("JD")
    end

    it 'should change password' do
      fill_in 'user_password', with: 'testpass'
      fill_in 'user_password_confirmation', with: 'testpass'
      click_button 'Set password'
      visit '/signout'
      signin(@user.email, 'testpass')
      expect(page).to have_current_path(dashboard_path)
    end

    it 'should show error on invalid password submit' do
      fill_in 'user_password', with: 'testpass'
      fill_in 'user_password_confirmation', with: 'testpass2'
      click_button 'Set password'
      expect(page).to have_css(".text-danger")
    end
  end

  describe 'current_project' do
    before do
      @user = FactoryGirl.create(:user)
      @project_a = FactoryGirl.create(:project, name: 'First')
      @project_b = FactoryGirl.create(:project, name: 'Second')
      @user.projects = [@project_a, @project_b]
      @user.current_project = @project_a
      @user.save
      signin(@user.email, @user.password)
    end

    it 'should change current project' do
      within('header') do
        click_link 'Second'
      end
      @user = User.find(@user.id)
      expect(@user.current_project).to eq(@project_b)
    end

    it 'should change header current project' do
      within('header') do
        click_link 'Second'
      end
      expect(page).to have_css('a.dropdown-toggle', text: @project_b.name)
    end
  end
end

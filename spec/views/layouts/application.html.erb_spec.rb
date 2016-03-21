require 'rails_helper'

RSpec.describe "layouts/application", type: :view do
  describe 'unauthenticated user' do
    before do
      allow(view).to receive(:signed_in?).and_return(false)
      render
    end

    it 'should have Sign In and Sign Up buttons' do
      expect(rendered).to have_link('Sign In')
      expect(rendered).to have_link('Sign Up')
    end
  end

  describe 'authenticated user' do
    before do
      @user = FactoryGirl.build(:user)
      assign(:user, @user)
      allow(view).to receive(:signed_in?).and_return(true)
      allow(view).to receive(:current_user).and_return(@user)
      render
    end

    it 'should have name and email in header' do
      expect(rendered).to have_content('Konstantin Zhukov')
      expect(rendered).to have_content('test@test.com')
    end
    it 'should have /signout link in dropdown' do
      expect(rendered).to have_css('.user_menu .dropdown-menu a[href="/signout"]')
    end
    it 'should have /profile link in dropdown' do
      expect(rendered).to have_css('.user_menu .dropdown-menu a[href="/profile"]')
    end
  end
end

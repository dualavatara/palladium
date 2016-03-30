require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before do
    @user = FactoryGirl::create(:user)
    assign(:user, @user)
    render
  end

  subject { Capybara.string(rendered) }

  describe 'profile section' do
    it 'should have name and initials' do
      should have_content(@user.name)
      should have_content('KZ')
    end

    it 'should have edit profile link' do
      should have_link('Edit', :href => edit_profile_path)
    end
  end

  describe 'password section' do
    it "should have blank field 'password' and label for it" do
      should have_field('user_password', :type => 'password')
      should have_css('label[for=user_password]')
      expect(subject.find_field('user_password').value.blank?).to be_truthy
    end

    it "should have blank field 'password_confirmation' and label for it" do
      should have_field('user_password_confirmation', :type => 'password')
      should have_css('label[for=user_password_confirmation]')
      expect(subject.find_field('user_password_confirmation').value.blank?).to be_truthy
    end

    it "should have 'Set password' button" do
      should have_button('Set password')
    end

  end

end

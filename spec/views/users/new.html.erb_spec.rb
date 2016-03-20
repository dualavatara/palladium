require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before do
    assign(:user, User.new)
    render
  end

  it "should have field 'name' and label for it" do
    expect(rendered).to have_field('user_name')
    expect(rendered).to have_css('label[for=user_name]')
  end

  it "should have field 'email' and label for it" do
    expect(rendered).to have_field('user_email')
    expect(rendered).to have_css('label[for=user_email]')
  end

  it "should have field 'password' and label for it" do
    expect(rendered).to have_field('user_password')
    expect(rendered).to have_css('label[for=user_password]')
  end

  it "should have field 'password_confirmation' and label for it" do
    expect(rendered).to have_field('user_password_confirmation')
    expect(rendered).to have_css('label[for=user_password_confirmation]')
  end

  it "should have 'Register' button" do
    expect(rendered).to have_button('signup')
  end

  it "should have 'Sign In' link" do
    expect(rendered).to have_link('signin', href: signin_path)
  end
end

require 'rails_helper'

RSpec.describe "authentications/new", type: :view do
  before do
    assign(:auth, Authentication.new)
    render
  end

  it 'should have id=new_authentication form on it' do
    expect(rendered).to have_css('#new_authentication')
  end

  it 'should have email and password fields and signin button' do
    visit '/signin'
    expect(rendered).to have_field('authentication_password')
    expect(rendered).to have_css('label[for=authentication_password]')
    expect(rendered).to have_field('authentication_email')
    expect(rendered).to have_css('label[for=authentication_email]')
    expect(rendered).to have_button('signin')
  end
end

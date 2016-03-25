require 'rails_helper'

RSpec.describe "authentications/new", type: :view do
  before do
    assign(:auth, Authentication.new)
    render
  end

  subject { rendered }

  it { should have_css('#new_authentication') }
  it { should have_field('authentication_password') }
  it { should have_css('label[for=authentication_password]') }
  it { should have_field('authentication_email') }
  it { should have_css('label[for=authentication_email]') }
  it { should have_button('signin') }

end

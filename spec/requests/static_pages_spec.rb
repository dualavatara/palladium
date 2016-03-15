require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "Home page" do
    it "should have title 'Palladium'" do
      visit '/'
      expect(page).to have_title('Palladium')
    end

    it "should have 'Sign In' link" do
      visit '/'
      expect(page).to have_link('Sign In')
    end

    it "should have 'Sign Up' link" do
      visit '/'
      expect(page).to have_link('Sign Up')
    end
  end
end

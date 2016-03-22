module UsersRspecHelpers
  def user_signin(hash={})
    hash = FactoryGirl.attributes_for(:user).merge(hash)
    visit '/signin'
    fill_in "authentication_email", with: hash[:email]
    fill_in "authentication_password", with: hash[:password]
    click_button 'signin'
  end

  def user_create_signin(hash={})
    @user = FactoryGirl.create(:user)
    user_signin(hash)
  end
end
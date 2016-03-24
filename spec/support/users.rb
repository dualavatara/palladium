module UsersRspecHelpers
  def user_signin(email, password)
    visit '/signin'
    fill_in "authentication_email", with: email
    fill_in "authentication_password", with: password
    click_button 'signin'
  end

  def user_create_signin(hash={})
    @user = FactoryGirl.create(:user)
    hash = hash.merge({:email => @user.email, :password => @user.password})
    user_signin(hash[:email], hash[:password])
  end
end
module UsersRspecHelpers
  def signin(email, password)
    visit '/signin'
    fill_in "authentication_email", with: email
    fill_in "authentication_password", with: password
    click_button 'signin'
  end

  def create_signin(hash={})
    @user = FactoryGirl.create(:user)
    hash = hash.merge({:email => @user.email, :password => @user.password})
    signin(hash[:email], hash[:password])
    @user
  end
end
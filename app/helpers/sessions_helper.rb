module SessionsHelper
  def current_user
    begin
      @_current_user ||= User.find(session[:user_id])
    rescue
      redirect_to signin_path
    end

    @_current_user
  end

  def current_user= (user)
    session[:user_id] ||= user._id.to_s
  end

  def signed_in?
    begin
      #mark search to limit multiple requests
      @_current_user ||= User.find(session[:user_id]) unless @_current_user_queried
      @_current_user_queried = true
    rescue

    end

    @_current_user
  end

  def clear_current_user
    session[:user_id] = nil
    @_current_user = nil
    @_current_user_queried = false
  end
end

class AuthenticationsController < ApplicationController
  def new
    @auth = Authentication.new
  end

  def create
    @auth = Authentication.new(auth_params)

    respond_to do |format|
      if signed_in?
        format.html { redirect_to root_path, status: :found }
      end

      begin
        user = User.find_by(email: @auth.email.downcase)

        raise 'user authentication failed' unless user.authenticate(@auth.password)

        # Sign the user in and redirect to the user's show page.
        self.current_user = user

        format.html { redirect_to root_path, status: :found, notice: "Authentication successful." }

      rescue
        # Create an error message and re-render the signin form.
        @auth.errors.add(:email, 'or password is incorrect.')
        format.html { render :new }
      end
    end

  end

  def destroy
    clear_current_user
    redirect_to root_path
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def auth_params
    params.require(:authentication).permit(:email, :password)
  end
end

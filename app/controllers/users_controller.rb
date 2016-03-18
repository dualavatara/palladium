class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = current_user if signed_in?
  end

  # GET /users/new
  def new
    redirect_to root_path, status: :found if signed_in?
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        self.current_user = @user
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def authenticate
    @errors = ActiveModel::Errors.new(self)

    redirect_to root_path, status: :found if signed_in?

    if params.has_key?(:user) && params[:user].has_key?(:email)
      begin
        user = User.find_by(email: params[:user][:email].downcase)

        raise 'user authentication failed' unless user.authenticate(params[:user][:password])
          # Sign the user in and redirect to the user's show page.
        self.current_user = user
        redirect_to root_path, status: :found, notice: "Authentication successful."

      rescue
        # Create an error message and re-render the signin form.
        @errors.add(:email, 'or password is incorrect.')
      end
    end
  end

  def signout
    clear_current_user
    redirect_to root_path
  end

  def self.human_attribute_name(key, opts)
    names = {email: 'Email'}
    names[key]
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end

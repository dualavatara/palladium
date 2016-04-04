class UsersController < ApplicationController
  before_action :set_user, except: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    # @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    redirect_to root_path, status: :found if signed_in?
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # GET /profile/edit
  # show profile editing form
  def edit_profile
    @user = current_user
    respond_to do |format|
      format.js { render :edit_profile }
      format.html { render partial: 'edit_profile' }
    end
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
    # respond_to do |format|
    #   if @user.update(user_params)
    #     format.html { render partial: 'show_profile' }
    #     format.json { render :show, status: :ok, location: @user }
    #     format.js { render :show_profile }
    #   else
    #     format.html { render partial: 'edit_profile' }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #     format.js { render :edit_profile }
    #   end
    # end
  end

  # PATCH/PUT /profile
  def update_profile
    respond_to do |format|
      if @user.update(user_params)
        format.html { render partial: 'show_profile' }
        format.json { render :show, status: :ok, location: @user }
        format.js { render :show_profile }
      else
        format.html { render partial: 'edit_profile' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js { render :edit_profile }
      end
    end
  end

  # PATCH/PUT /profile
  def update_password
    respond_to do |format|
      if @user.update(user_params)
        format.html { render partial: 'edit_password' }
        format.js { render :edit_password }
      else
        format.html { render partial: 'edit_password' }
        format.js { render :edit_password }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    # @user.destroy
    # respond_to do |format|
    #   format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  # PATCH
  def current_project
    respond_to do |format|
      if @user.current_project = @user.projects.find(params[:id])
        @user.save
        format.html { redirect_to project_path(@user.current_project) }
        format.js { render 'layouts/current_project' }
      else
        format.html { render :nothing => true  }
        format.js { render :nothing => true }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :initials, :email, :password, :password_confirmation)
  end
end

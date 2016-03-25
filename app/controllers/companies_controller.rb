class CompaniesController < ApplicationController
  before_action :current_user
  before_action :has_role?, only: [:show]
  before_action :is_admin?, only: [:destroy, :edit, :update]

  def index
    @user = current_user
    @companies = @user.companies
  end

  def new
    @company = Company.new
  end

  def show
    @company = Company.find(params[:id])
  end

  def edit
    @user = current_user
    respond_to do |format|
      format.js { render :edit_profile }
      format.html { render partial: 'edit_profile' }
    end
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      # company save successful so add default roles for it to current user
      current_user.roles = current_user.roles + @company.roles
      current_user.save
      redirect_to companies_path
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { render partial: 'show_profile' }
        format.js { render :show_profile }
      else
        format.html { render partial: 'edit_profile' }
        format.js { render :edit_profile }
      end
    end
  end

  def destroy
    @company.destroy if @company.admin?(current_user)

    redirect_to companies_path
  end

  def has_role?
    @company = Company.find(params[:id])
    if current_user.roles.for(@company).count > 0
      true
    else
      redirect_to companies_path
    end
  end

  def is_admin?
    @company = Company.find(params[:id])
    @company.admin?(current_user)
  end

  private

  def company_params
    params.require(:company).permit(:id, :name, :email, :web)
  end
end

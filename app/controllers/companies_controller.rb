class CompaniesController < ApplicationController
  before_action :current_user, only: [:index]

  def index
    @user = current_user
    @companies = @user.companies
  end

  def new
    @company = Company.new
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

  private

  def company_params
    params.require(:company).permit(:name, :email, :web)
  end
end

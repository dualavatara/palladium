class CompaniesController < ApplicationController
  before_action :current_user, only: [:index]

  def index
    @user = current_user
    @companies = @user.companies
  end
end

module CompaniesHelper
  def is_admin?(user, company)
    company.admin?(user)
  end

  def role_names(user, company)
    user.roles.for(company).pluck(:name)
  end

  def destroyable?(company)
    company.destroyable?
  end
end

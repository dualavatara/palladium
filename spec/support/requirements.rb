module RequierementsRspecHelpers
  def build_requirements
    @company = FactoryGirl.build(:company)
    @project = FactoryGirl.build(:project, company: @company)
    ('A'..'C').collect { |c| FactoryGirl.build(:requirement, name: "Req #{c}", project: @project) }
  end
end
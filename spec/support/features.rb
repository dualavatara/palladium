module FeaturesRspecHelpers
  def build_features
    @company = FactoryGirl.build(:company)
    @project = FactoryGirl.build(:project, company: @company)
    ('A'..'C').collect { |c| FactoryGirl.build(:feature, name: "Req #{c}", project: @project) }
  end
end
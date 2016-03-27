require 'rails_helper'

RSpec.describe Requirement, type: :model do
  before do
    @company = FactoryGirl.build(:company)
    @project = FactoryGirl.build(:project, company: @company)
    @req = FactoryGirl.build(:requirement, project: @project)
  end

  it {should respond_to(:name)}
  it {should respond_to(:desc)}
  it {should respond_to(:project)}

  it 'should belongs to project' do
    expect(@req).to be_valid
  end

end

require 'rails_helper'
require 'support/shared_examples'

RSpec.describe Feature, type: :model do
  before do
    @company = FactoryGirl.create(:company)
    @project = FactoryGirl.create(:project, company: @company)
    @feature = FactoryGirl.create(:feature, project: @project)
  end

  it_behaves_like 'weak destroy' do
    let(:model) { @feature }
  end

  it {should respond_to(:name)}
  it {should respond_to(:desc)}
  it {should respond_to(:project)}

  it 'should belongs to project' do
    expect(@feature).to be_valid
  end

  it 'should have significant name' do
    @feature.name = ''
    expect(@feature).not_to be_valid

    @feature.name = '   '
    expect(@feature).not_to be_valid
  end
end

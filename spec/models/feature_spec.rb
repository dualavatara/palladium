require 'rails_helper'
require 'support/shared_examples'

RSpec.describe Feature, type: :model do
  before do
    @company = FactoryGirl.create(:company)
    @project = FactoryGirl.create(:project, company: @company)
    @feature = FactoryGirl.create(:feature, project: @project)
  end

  it_behaves_like 'weak destroy' do
    subject { @feature }
  end

  it_behaves_like 'named and descripted' do
    subject { @feature }
  end

  it {should respond_to(:project)}

  it 'should belongs to project' do
    expect(@feature).to be_valid
  end
end

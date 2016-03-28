require 'rails_helper'

RSpec.describe Actor, type: :model do
  before do
    @actor = FactoryGirl.build(:actor)
  end
  it {should respond_to(:name)}
  it {should respond_to(:desc)}
  it {should belong_to(:project)}
  it {expect(@actor).to be_valid}
  it 'should have significant name' do
    @actor.name = ''
    expect(@actor).not_to be_valid
  end
end

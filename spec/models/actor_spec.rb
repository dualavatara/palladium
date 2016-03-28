require 'rails_helper'
require 'support/shared_examples'

RSpec.describe Actor, type: :model do
  before do
    @actor = FactoryGirl.build(:actor)
  end

  it_behaves_like 'weak destroy' do
    subject { FactoryGirl.create(:actor) }
  end

  it_behaves_like 'named and descripted' do
    subject { FactoryGirl.create(:actor) }
  end

  it {should belong_to(:project)}

  it {expect(@actor).to be_valid}
end

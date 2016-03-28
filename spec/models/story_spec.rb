require 'rails_helper'

RSpec.describe Story, type: :model do
  before do
    @story = FactoryGirl.build(:story)
  end

  subject { @story }

  it_behaves_like 'weak destroy' do
    subject { FactoryGirl.create(:story) }
  end

  it_behaves_like 'named and descripted' do
    subject { FactoryGirl.create(:story) }
  end
end

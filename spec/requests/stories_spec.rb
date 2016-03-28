require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "Stories", type: :request do
  before do
    @feature = FactoryGirl.create(:feature)
  end

  subject { page }

  describe 'index' do
    before {visit feature_stories_path(@feature.id)}

    it {should have_panel('stories')}
    it {should have_content(@feature.stories.first.name)}
  end
end

require 'rails_helper'

RSpec.shared_examples 'has panel' do |id|
  it id do
    expect(subject).to have_css("div.panel##{id}")
  end
end

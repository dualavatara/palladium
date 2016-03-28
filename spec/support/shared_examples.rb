require 'rails_helper'

RSpec.shared_examples 'has panel' do |id|
  it id do
    expect(subject).to have_css("div.panel##{id}")
  end
end

RSpec.shared_examples 'weak destroy' do
  before do
    model.destroy
  end

  it 'should be marked as deleted' do
    expect(model.class.where(:_id => model.id, :deleted_at.ne => nil).count).to be(1)
  end

end

RSpec::Matchers.define :have_panel do |id|
  match do |actual|
    expect(actual).to have_css("div.panel##{id}")
  end
end

RSpec::Matchers.define :have_object_row do |object|
  id = ActionView::RecordIdentifier.dom_id(object)
  match do |actual|
    expect(actual).to have_css("tr##{id}")
  end
  description do
    "have row with id=#{id}"
  end
end

RSpec::Matchers.define :have_object_table do |object_list|
  match do |actual|
    object_list.each {|object| expect(actual).to have_object_row(object) }
  end
end
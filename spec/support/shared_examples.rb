require 'rails_helper'

RSpec.shared_examples 'has panel' do |id|
  it id do
    expect(subject).to have_css("div.panel##{id}")
  end
end

RSpec.shared_examples 'weak destroy' do
  before do
    subject.destroy
  end

  it 'should be marked as deleted' do
    expect(subject.class.where(:_id => subject.id, :deleted_at.ne => nil).count).to be(1)
  end

end

RSpec.shared_examples 'named and descripted' do
  it {should respond_to(:name)}
  it {should respond_to(:desc)}

  it 'should have significant name' do
    subject.name = ''
    should_not be_valid

    subject.name = '   '
    should_not be_valid
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
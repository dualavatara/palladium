require 'rails_helper'
require 'support/shared_examples'

RSpec.describe Task, type: :model do
  before do
    @task = FactoryGirl.build(:task)
  end

  subject { @task }

  it_behaves_like 'weak destroy' do
    subject { FactoryGirl.create(:task) }
  end

  it_behaves_like 'named and descripted' do
    subject { FactoryGirl.create(:task) }
  end

  it { should respond_to(:type) }
  it { should respond_to(:e_s) }
  it { should respond_to(:e_r) }
  it { should respond_to(:e_w) }
  it { should respond_to(:requester) }
  it { should respond_to(:owners) }
  it { should respond_to(:state) }

  it 'should be invalid without a type' do
    @task.type = nil
    expect(@task).not_to be_valid
  end

  it 'should be valid with a type' do
    @task.type = :service
    expect(@task).to be_valid
  end

  it 'should have :story type on creation by default' do
    task = Task.new(name: 'Sample name')
    expect(task.type).to be(:story)
  end

  it 'should have :unstarted state by default' do
    task = Task.new(name: 'Sample name')
    expect(task.state).to be(:unstarted)
  end

  it 'can belong to a project' do
    @task.project = Project.new()
    expect(@task).to be_valid
  end

  shared_examples_for 'story required' do |param|
    it 'should be valid without story' do
      expect(subject).to be_valid unless param
    end

    it 'should not be valid without story' do
      expect(subject).not_to be_valid if param
    end

    it 'should be valid with story' do
      subject.story = Story.new()
      expect(subject).to be_valid
    end
  end

  describe ':story type' do
    before { subject.type = :story }
    it_behaves_like 'story required', true
  end

  describe ':bug type' do
    before { subject.type = :bug }

    it_behaves_like 'story required', false
  end

  describe ':service type' do
    before { subject.type = :service }

    it_behaves_like 'story required', false
  end
end

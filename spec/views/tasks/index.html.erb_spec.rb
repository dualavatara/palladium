require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "tasks/index.html.erb", type: :view do
  before do
    @tasks = FactoryGirl.build_list(:task, 3)
    @user = FactoryGirl.build(:user)
    @owners = FactoryGirl.build_list(:user, 2)
    @tasks.first.requester = @user
    @tasks.first.owners = @owners
    render
  end

  subject { rendered }

  it { should have_panel("tasks") }

  it 'should have list of tasks' do
    expect(rendered).to have_object_table(@tasks)
  end

  it 'should have delete link for each task' do
    @tasks.each { |task| expect(rendered).to have_link('Delete', href: task_path(task.id))}
  end

  it 'should have correct owners' do
    expect(rendered).to have_content("#{@owners.first.name}, #{@owners.second.name}")
  end
end

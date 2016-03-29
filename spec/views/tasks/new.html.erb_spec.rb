require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "tasks/new.html.erb", type: :view do
  before do
    @task = FactoryGirl.build(:task)
    render
  end

  subject { rendered }

  it { should have_panel('new_task') }

  it 'should have new_task form' do
    expect(rendered).to have_css('form#new_task')
  end

  it 'should have Name field' do
    expect(rendered).to have_field('task_name')
  end

  it 'should have Decription field' do
    expect(rendered).to have_field('task_desc')
  end

  it 'should have Add submit button' do
    expect(rendered).to have_button('Add')
  end

  it 'should have type field' do
    expect(subject).to have_select('task_type')
  end

  it 'should have requester field'
  it 'should select @user to requester field by default'
  it 'should have owners field'
end

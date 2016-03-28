require 'rails_helper'
require 'support/shared_examples.rb'

RSpec.describe "projects/new.html.erb", type: :view do
  before do
    @company = FactoryGirl.build(:company)
    @project = FactoryGirl.build(:project)
    @project.company = @company
    @company.projects << @project
    @company.save
    render
  end

  subject { rendered }

  it {should have_panel('new_project')}

  it 'should have name field' do
    expect(subject).to have_field('Name')
  end

  it 'should have submin Add button' do
    expect(subject).to have_button('Add')
  end
end

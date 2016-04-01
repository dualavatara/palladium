require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "dashboard/index.html.erb", type: :view do
  before do
    @projects = FactoryGirl.build_list(:project, 3)
    allow(view).to receive(:user_projects).and_return(@projects)
    allow(view).to receive(:features_num).and_return(3)
    allow(view).to receive(:stories_num).and_return(4)
    allow(view).to receive(:tasks_num).and_return(5)
    render
  end

  subject { rendered }

  it 'should have Projects header' do
    expect(subject).to have_css('h1', text: 'Projects')
  end

  it 'should have "New project" button' do
    expect(subject).to have_link('New project', href: new_project_path)
  end

  it 'should have project panels for all projects user participate in' do
    @projects.each do |project|
      expect(subject).to have_panel("project_#{project.id}")
    end
  end

  describe 'project panel' do

    let(:panel) { Capybara.string(rendered).find("div#project_#{@projects.second.id}") }
    let(:project) { @projects.second }

    it 'should have name with link to project page' do
      expect(panel).to have_link(project.name, href: project_path(project.id))
    end

    it 'should have link "Features" with number of features' do
      expect(panel).to have_link("Features", href: features_path)
      expect(panel.find('div#features')).to have_content('3')
    end

    it 'should have link "Stories" with number of stories' do
      expect(panel).to have_link("Stories", href: stories_path)
      expect(panel.find('div#stories')).to have_content('4')
    end
    it 'should have link "Tasks" with number of tasks' do
      expect(panel).to have_link("Tasks", href: tasks_path)
      expect(panel.find('div#tasks')).to have_content('5')
    end
  end
end

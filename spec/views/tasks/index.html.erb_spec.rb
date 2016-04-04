require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "tasks/index.html.erb", type: :view do
  before do
    @tasks = FactoryGirl.build_list(:task, 6)
    @user = FactoryGirl.build(:user)
    @owners = FactoryGirl.build_list(:user, 2)
    @tasks.first.requester = @user
    @tasks.first.owners = @owners
    @tasks[0].state = :unstarted
    @tasks[1].state = :started
    @tasks[2].state = :finished
    @tasks[3].state = :delivered
    @tasks[4].state = :accepted
    @tasks[5].state = :rejected
    @tasks.each {|task| task.save}
    render
  end

  subject { Capybara.string(rendered) }

  it { should have_panel("tasks") }

  it 'should have list of tasks' do
    expect(rendered).to have_object_table(@tasks)
  end

  it 'should have delete link for each task' do
    @tasks.each { |task| expect(rendered).to have_link('Delete', href: task_path(task.id)) }
  end

  it 'should have correct owners' do
    expect(rendered).to have_content("#{@owners.first.name}, #{@owners.second.name}")
  end

  def row(task)
    subject.find("tr##{dom_id(task)}")
  end

  def have_state_btn(cls, name, href)
    have_css("a.btn.#{cls}[href='#{href}']", text: name)
  end

  describe 'task states' do
    it 'shows btn-default class "Start" button on unsarted tasks' do
      expect(row(@tasks[0])).to have_state_btn('btn-default','Start', state_task_path(@tasks[0].id, :state => :started))
    end

    it 'shows btn-primary class "Finish" button on sarted tasks' do
      expect(row(@tasks[1])).to have_state_btn('btn-primary','Finish', state_task_path(@tasks[1].id, :state => :finished))
    end

    it 'shows btn-warning class "Deliver" button on finished tasks' do
      expect(row(@tasks[2])).to have_state_btn('btn-warning','Deliver', state_task_path(@tasks[2].id, :state => :delivered))
    end

    it 'shows btn-success class "Accept" button on delivered tasks' do
      expect(row(@tasks[3])).to have_state_btn('btn-success','Accept', state_task_path(@tasks[3].id, :state => :accepted))
    end

    it 'shows btn-danger class "Reject" button on delivered tasks' do
      expect(row(@tasks[3])).to have_state_btn('btn-danger','Reject', state_task_path(@tasks[3].id, :state => :rejected))
    end

    it 'has bg-success class row for accepted tasks' do
      # expect(row(@tasks[4])).to have_css('tr.bg-success')
      expect(row(@tasks[4])[:class]).to include('bg-success')
      expect(row(@tasks[4])).not_to have_css('.btn')
    end

    it 'shows btn-default class "Restart" button on rejected tasks' do
      expect(row(@tasks[5])).to have_state_btn('btn-default','Restart', state_task_path(@tasks[5].id, :state => :started))
    end
  end


end

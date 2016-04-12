require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe 'ApplicationFromBuilder' do
    before do
      @task = FactoryGirl.build(:task)
      @task.owners = FactoryGirl.build_list(:user, 3)
    end


    describe 'search_select' do
      before do
        @users = [] + @task.owners + FactoryGirl.build_list(:user, 3)
        @html = fields_for(@task, nil, {builder: ApplicationHelper::ApplicationFormBuilder}) do |f|
          f.search_select :owners, @users, :name, project_users_search_path('123')
        end
        p @html
      end

      subject { Capybara.string(@html) }

      let(:page) { subject }

      it 'should have edit field' do
        expect(subject).to have_css("input[type=text]")
      end
      it 'should have collpase button' do
        expect(subject).to have_css("span.caret")
      end
      it 'should have collapsed list of found items' do
        expect(subject).to have_css('ul.dropdown-menu')
        expect(subject.find('ul.dropdown-menu')).to have_css('li', count: 3)
      end
      it 'should have hidden field for selected ids' do
        expect(subject).to have_css("input#task_owner_ids[type=hidden]")
      end
      it 'should have divs with selected items' do
        expect(subject.find('ul.dropdown-menu')).to have_css('li', count: 3)
      end
    end
  end
end

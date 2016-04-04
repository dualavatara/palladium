require 'rails_helper'

RSpec.describe "layouts/application", type: :view do
  describe 'unauthenticated user' do
    before do
      allow(view).to receive(:signed_in?).and_return(false)
      render
    end

    it 'should have Sign In and Sign Up buttons' do
      expect(rendered).to have_link('Sign In')
      expect(rendered).to have_link('Sign Up')
    end
  end

  describe 'authenticated user' do
    before do
      @user = FactoryGirl.build(:user)
      assign(:user, @user)
      allow(view).to receive(:signed_in?).and_return(true)
      allow(view).to receive(:current_user).and_return(@user)
      render
    end

    it 'should have name and email in header' do
      expect(rendered).to have_content(@user.name)
      expect(rendered).to have_content(@user.email)
    end
    it 'should have /signout link in dropdown' do
      expect(rendered).to have_css('.user_menu .dropdown-menu a[href="/signout"]')
    end
    it 'should have /profile link in dropdown' do
      expect(rendered).to have_css('.user_menu .dropdown-menu a[href="/profile"]')
    end
    it 'should have companies link in dropdown' do
      expect(rendered).to have_css('.user_menu .dropdown-menu a[href="/companies"]')
    end


    describe 'with no projects created' do
      before do
        allow(view).to receive(:available_projects) { []}
        self.rendered = ''
        render
      end

      it 'should not have current_project dropdown' do
        expect(rendered).not_to have_css('div.dropdown#current_project')
      end
    end

    describe 'with projects created' do
      before do
        @company = FactoryGirl.create(:company)
        @project_a = FactoryGirl.create(:project, company: @company, name: 'First project')
        allow(view).to receive(:available_projects) { [@project_a]}
        allow(view).to receive(:current_project) { nil }
        self.rendered = ''
        render
      end

      it 'should have current_project dropdown' do
        expect(rendered).to have_css('li.dropdown#current_project')
      end

      it 'should have "Choose project..." if no current project' do
        expect(rendered).to have_css('a.dropdown-toggle', text: 'Choose project...')
      end

      describe 'more than 1' do
        before do
          @project_b = FactoryGirl.create(:project, company: @company, name: 'Second project')
          allow(view).to receive(:available_projects) { [@project_a, @project_b] }
          self.rendered = ''
          render
        end

        it 'should have dropdown with other projects' do
          expect(rendered).to have_css("li#project_#{@project_b.id}")
        end

        it 'should have link to remote change current project' do
          expect(rendered).to have_link(@project_b.name, href: current_project_path(@project_b.id))
        end
      end

      describe 'with current project set' do
        before do
          allow(view).to receive(:current_project) { @project_a }
          self.rendered = ''
          render
        end

        it 'should have link with current project name' do
          expect(rendered).to have_css('a.dropdown-toggle', text: @project_a.name)
        end

        it 'should not have current project in dropdown menu' do
          expect(rendered).not_to have_css("li#project_#{@project_a.id}")
        end

        it 'should have Features link' do
          expect(rendered).to have_link('Features', href: project_features_path(@project_a.id))
        end

        it 'should have Actors link' do
          expect(rendered).to have_link('Actors', href: project_actors_path(@project_a.id))
        end

        it 'should have /tasks link' do
          expect(rendered).to have_link('Tasks', href: tasks_path)
        end
      end
    end
  end
end

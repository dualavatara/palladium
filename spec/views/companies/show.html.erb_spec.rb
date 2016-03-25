require 'rails_helper'

RSpec.describe "companies/show", type: :view do
  before do
    @company = FactoryGirl.build(:company)
    @user = FactoryGirl.build(:user)
    assign(:company, @company)
    assign(:projects, @company.projects)
    allow(view).to receive(:is_admin?).and_return(true)
    render
  end
  it { expect(rendered).to have_content(@company.name) }
  it { expect(rendered).to have_content(@company.email) }
  it { expect(rendered).to have_content(@company.web) }
end

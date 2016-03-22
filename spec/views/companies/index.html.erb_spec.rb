require 'rails_helper'

RSpec.describe "companies/index.html.erb", type: :view do
  before do
    @companies = [
        FactoryGirl.build(:company, name: 'Company A'),
        FactoryGirl.build(:company, name: 'Company B'),
        FactoryGirl.build(:company, name: 'Company C')
    ]

    @roles =[
        FactoryGirl.build(:admin_role, company: @companies[0], name: 'admin'),
        FactoryGirl.build(:role, company: @companies[1]),
        FactoryGirl.build(:admin_role, company: @companies[2], name: 'admin'),
    ]

    @user = FactoryGirl.build(:user,
                               roles: @roles)
    assign(:companies, @companies)
    assign(:user, @user)
    render
  end

  it 'should have #comapnies panel' do
    expect(rendered).to have_css('#companies_panel')
  end

  it 'should have table with company names' do
    expect(rendered).to have_css('table.table td', text: 'Company A')
    expect(rendered).to have_css('table.table td', text: 'Company C')
  end

  it 'should have proper Add link' do
    expect(rendered).to have_link('Add', href: '/companies/new')
  end
end

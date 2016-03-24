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

    @user = FactoryGirl.create(:user,
                               roles: @roles)


    @roles[0].users << @user

    @companies.each {|company| company.save}
    @roles.each {|role| role.save}

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

  it 'should have link on company name' do
    expect(rendered).to have_link('Company A', href:'http://www.somethinggmbh.com')
  end

  it 'should have proper Add link' do
    expect(rendered).to have_link('Add', href: '/companies/new')
  end

  it 'should have record id in tr tag' do
    expect(rendered).to have_css("tr#company_#{ @companies[0].id}")
  end

  it 'should have Delete link for deletable company' do
    expect(rendered).to have_link('Delete', href: company_path(@companies[0].id))
  end

  it 'should have no Delete link for undeletable company' do
    expect(rendered).not_to have_link('Delete', href: company_path(@companies[1].id))
  end
end

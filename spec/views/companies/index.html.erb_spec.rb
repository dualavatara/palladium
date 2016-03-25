require 'rails_helper'

RSpec.describe "companies/index.html.erb", type: :view do
  before do
    # @companies = [
    #     FactoryGirl.build(:company, name: 'Company A'),
    #     FactoryGirl.build(:company, name: 'Company B'),
    #     FactoryGirl.build(:company, name: 'Company C')
    # ]
    @company_a = FactoryGirl.build(:company, name: 'Company A')
    @company_b = FactoryGirl.build(:company, name: 'Company B')
    @company_c = FactoryGirl.build(:company, name: 'Company C')


    # @roles =[
    #     FactoryGirl.build(:admin_role, company: @company_a, name: 'admin'),
    #     FactoryGirl.build(:role, company: @company_b),
    #     FactoryGirl.build(:admin_role, company: @company_c, name: 'admin'),
    # ]
    #
    @user = FactoryGirl.build(:user, roles: @roles)

    assign(:companies, [@company_a,  @company_b, @company_c])
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

  it 'should have web in separate column' do
    expect(rendered).to have_link('http://www.somethinggmbh.com', href:'http://www.somethinggmbh.com')
  end

  it 'should have link to profile on company name' do
    expect(rendered).to have_link('Company A', href:company_path(@company_a.id))
  end

  it 'should have proper Add link' do
    expect(rendered).to have_link('Add', href: '/companies/new')
  end

  context 'with companies and roles in db' do
    before do
      # @roles[0].users << @user
      #
      # [@company_a,  @company_b, @company_c].each {|company| company.save}
      # @roles.each {|role| role.save}
      # assign(:companies, [@company_a,  @company_b, @company_c])
      # render
    end

    it 'should have record id in tr tag' do
      @company_a.save
      render
      expect(rendered).to have_css("tr#company_#{ @company_a.id}")
    end

    it 'should have Delete link for deletable company' do
      allow(view).to receive(:destroyable?).and_return(true)
      allow(view).to receive(:is_admin?).and_return(true)
      @company_a.save
      render
      expect(rendered).to have_link('Delete', href: company_path(@company_a.id))
    end

    it 'should have no Delete link for undeletable company' do
      expect(rendered).not_to have_link('Delete', href: company_path(@company_b.id))
    end
  end
end

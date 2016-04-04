require 'rails_helper'

RSpec.fdescribe "actors/_form", type: :view do
  before do
    assign(:actor, FactoryGirl.build(:actor))
    assign(:project, FactoryGirl.build(:project))
    # assign(:panel_name, 'Panel name')
    render partial: "actors/form", locals: {panel_name: 'Panel name'}
  end

  subject { rendered }

  it { should have_css('label', text: 'Name') }

  it { should have_css('input#actor_name') }

  it { should have_css('label', text: 'Description') }

  it { should have_css('input#actor_desc') }

  it { should have_css('input[type=submit][value="Add"]') }
end

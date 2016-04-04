require 'rails_helper'
require 'support/shared_examples'

RSpec.describe "actors/edit", type: :view do
  before do
    @actor = FactoryGirl.build(:actor)
    assign(:actor, @actor)
    assign(:project, FactoryGirl.build(:project))
    render
  end

  subject { rendered }


  it { should have_panel(dom_id(@actor)) }

  it { should have_css("form##{dom_id(@actor)}") }
end

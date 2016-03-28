require 'rails_helper'

RSpec.describe Actor, type: :model do
  it {should respond_to(:name)}
  it {should respond_to(:desc)}
  it {should belong_to(:project)}
end

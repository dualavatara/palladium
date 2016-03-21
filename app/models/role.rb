class Role
  include Mongoid::Document

  field :name, type: String

  belongs_to :company
  has_and_belongs_to_many :users
end

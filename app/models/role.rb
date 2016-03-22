class Role
  include Mongoid::Document

  field :name, type: String
  field :admin, type: Boolean

  belongs_to :company
  has_and_belongs_to_many :users
end

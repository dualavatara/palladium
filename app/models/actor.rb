class Actor
  include Mongoid::Document
  field :name, type: String
  field :desc, type: String

  belongs_to :project
end

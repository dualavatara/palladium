class Feature
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  field :name, type: String
  field :desc, type: String

  belongs_to :project
end

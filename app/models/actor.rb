class Actor
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  field :name, type: String
  field :desc, type: String

  validates :name, presence: true

  belongs_to :project
end

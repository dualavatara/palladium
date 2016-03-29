class Project
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  field :name, type: String

  validates :name, presence: true

  belongs_to :company
  has_and_belongs_to_many :users
  has_many :features
  has_many :actors
  has_many :tasks
end

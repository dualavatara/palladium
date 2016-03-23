class Project
  include Mongoid::Document

  field :name, type: String

  validates :name, presence: true
  validates :company, presence: true

  belongs_to :company
  has_and_belongs_to_many :users
end

class Feature
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include NamedAndDescribed

  has_many :stories
  belongs_to :project
end

class Actor
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include NamedAndDescribed

  belongs_to :project, dependent: :restrict
end

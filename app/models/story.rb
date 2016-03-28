class Story
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include NamedAndDescribed

  belongs_to :feature
end

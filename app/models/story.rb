class Story
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include NamedAndDescribed

  belongs_to :actor, inverse_of: nil
  belongs_to :feature

  validates :actor, presence: true

  def full_name
    "#{actor.name} #{name}"
  end
end

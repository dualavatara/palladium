class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include NamedAndDescribed

  field :type, type: Symbol, default: :story
  field :e_s, type: Integer
  field :e_r, type: Integer
  field :e_w, type: Integer
  field :state, type: Symbol, default: :unstarted

  belongs_to :requester, :class_name => 'User'
  has_and_belongs_to_many :owners, :class_name => 'User', inverse_of: nil

  belongs_to :project
  belongs_to :story, inverse_of: nil

  validates :type, presence: true
  validates :state, presence: true
  validates :project, presence: true
  validates :story, presence: {message: 'must be selected for story type tasks.'}, if: :is_story?

  def is_story?
    type == :story
  end
end

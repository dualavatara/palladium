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

  def stories
    begin
      Array.wrap(Story.where(:feature_id.in => self.feature_ids))
    rescue Mongoid::Errors::DocumentNotFound
      []
    end
  end
end

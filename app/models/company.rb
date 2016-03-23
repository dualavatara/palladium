class Company
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :email, type: String
  field :web, type: String

  validates :name, :presence => true
  validates :email, :email => true, :unless => "email.empty?"
  validates :web, :url => true,  :unless => "web.empty?"

  has_many :roles

  after_save do
      self.roles.create(name: 'admin', admin: true) unless has_admin?
  end

  private
  def has_admin?
    self.roles.where(name: 'admin').first
  end
end

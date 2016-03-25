class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  field :name, type: String
  field :email, type: String
  field :web, type: String

  validates :name, :presence => true
  validates :email, :email => true, :unless => "email.empty?"
  validates :web, :url => true,  :unless => "web.empty?"
  validates_format_of :web, :with => /[a-z]+:\/\/.+/i,  :unless => "web.empty?"

  has_many :roles, dependent: :destroy do
    def admins
      where(admin: true)
    end
  end

  has_many :projects

  after_save do
      self.roles.create(name: 'admin', admin: true) unless has_admin?
  end

  before_destroy { destroyable? }

  def destroyable?
    self.roles.pluck(:user_ids).compact.flatten.count <= 1
  end

  def admin?(user)
    self.roles.admins.pluck(:user_ids).compact.flatten.include?(user.id)
  end

  private
  def has_admin?
    self.roles.where(name: 'admin').first
  end
end

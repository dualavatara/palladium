class Company
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :email, type: String
  field :web, type: String

  has_many :roles

  after_save do
    if !has_admin?
      self.roles.create(name: 'admin', admin: true)
    end
  end

  private
  def has_admin?
    self.roles.where(name: 'admin').first
  end
end

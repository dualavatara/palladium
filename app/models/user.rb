class User
  include ActiveModel::SecurePassword
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :password_digest, type: String
  field :name, type: String
  field :initials, type: String

  has_and_belongs_to_many :roles do
    def for(company)
      where(company: company)
    end
  end

  has_and_belongs_to_many :projects

  index({ email: 1 }, { unique: true})

  validates :email, email: true, uniqueness: { case_sensitive: false }
  validates :password, length: {minimum: 6}, if: :validate_password?
  validates :name, length: {minimum: 3, maximum: 120}
  validates :initials, length: {maximum: 2}

  before_save do
    self.email = email.downcase
    self.initials = if initials.nil? || initials.empty? then
                      make_initials(name)
                    else
                      initials.upcase
                    end
  end

  has_secure_password

  def validate_password?
    self.new_record? || !self.password.blank?
  end

  def companies
    Company.find(self.roles.pluck(:company_id))
  end

  private
  def make_initials(name)
    names = name.split
    initials = names.first[0, 1] + names.last[0, 1]
    initials.upcase
  end
end

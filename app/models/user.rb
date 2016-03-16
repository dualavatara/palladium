class User
  include ActiveModel::SecurePassword
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :password_digest, type: String

  index({ email: 1 }, { unique: true})

  validates :email, email: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  before_save { self.email = email.downcase }
  has_secure_password
end

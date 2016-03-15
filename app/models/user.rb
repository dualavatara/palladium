class User
  include Mongoid::Document
  field :name, type: String
  field :login, type: String
  field :passwd, type: String
  validates :login, email: {message: "must be a valid e-mail address."}
  validates :passwd, presence: true
end

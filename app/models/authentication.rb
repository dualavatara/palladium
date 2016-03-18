class Authentication
  include Mongoid::Document

  attr_accessor :email, :password

end

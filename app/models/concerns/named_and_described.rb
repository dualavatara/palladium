require 'active_support/concern'

module NamedAndDescribed
  extend ActiveSupport::Concern

  included do
    field :name, type: String
    field :desc, type: String

    validates :name, presence: true
  end
end
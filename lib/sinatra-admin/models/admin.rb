require 'mongoid'

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

module SinatraAdmin
  class Admin
    include Mongoid::Document

    field :first_name, type: String
    field :last_name, type: String
    field :email, type: String
    field :password, type: String

    validates :email,
              :password, presence: true

    validates :email, email: true

    def authenticate(attemp_password)
      password.eql?(attemp_password)
    end
  end
end

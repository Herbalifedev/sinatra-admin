require 'mongoid'
require 'bcrypt'

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
    include BCrypt

    field :first_name, type: String
    field :last_name, type: String
    field :email, type: String
    field :password_hash, type: String

    validates :email,
              :password_hash, presence: true

    validates :email, email: true

    def authenticate(attemp_password)
      password == attemp_password
    end

    def password
      @password ||= Password.new(password_hash)
    end

    def password=(new_password)
      @password = Password.create(new_password)
      self.password_hash = @password
    end
  end
end

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

    ROLES = %w(all create edit read remove)

    field :first_name, type: String
    field :last_name, type: String
    field :email, type: String
    field :password_hash, type: String
    field :roles, type: Array

    #validates :email,
    #          :password_hash, presence: true

    validates_presence_of :password_hash, if: Proc.new { |admin| admin.new_record? || admin.password_hash_changed? }
    validates_presence_of :email, :roles
    validates :email, email: true

    before_save :remove_nil_element_and_uniqueness_role, if: :"self.roles.present?"

    def authenticate(attemp_password)
      password == attemp_password
    end

    def password
      @password ||= Password.new(password_hash)
    end

    def password=(new_password)
      if new_password.present?
        @password = Password.create(new_password)
        self.password_hash = @password
      else
        self.password_hash = nil
      end
    end

    def create_access?
      all_access? || self.roles.include?("create")
    end

    def edit_access?
      all_access? || self.roles.include?("edit")
    end

    def read_access?
      all_access? || self.roles.include?("read")
    end

    def remove_access?
      all_access? || self.roles.include?("remove")
    end

    private
    def all_access?
      self.roles.include?("all")
    end

    def remove_nil_element_and_uniqueness_role
      if all_access?
        self.roles.clear.push("all")
      else
        self.roles.uniq!
        self.roles.delete_if { |item| item.blank? }
      end
    end
  end
end

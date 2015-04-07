require 'mongoid'

class User
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :password_hash, type: String
  field :created_at, type: DateTime

  attr_accessible :first_name, :last_name, :email, :password, :password_hash, :created_at

  validates :email, presence: true
  validates_presence_of :password_hash, if: Proc.new { |u| u.new_record? || u.password_hash_changed? }

  def password=(new_password)
    if new_password.present?
      self.password_hash = new_password
    else
      self.password_hash = nil
    end
  end
end

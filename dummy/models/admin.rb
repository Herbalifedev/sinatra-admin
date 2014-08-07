require 'mongoid'

class Admin < User
  field :password, type: String
  validates :password, presence: true
end

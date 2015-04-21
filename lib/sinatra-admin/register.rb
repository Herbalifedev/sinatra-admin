require 'sinatra-admin/register/configure'
require 'sinatra-admin/register/base'
require 'sinatra-admin/register/model'
require 'sinatra-admin/register/custom'

module SinatraAdmin
  class RegistrationException < Exception; end
  module Register; end
end

require 'rubygems'
require 'bundler'
Bundler.require
require  './dummy/dummy'

map "/" do
  run Dummy::API
end

map "/admin" do
  run Dummy::Admin
end

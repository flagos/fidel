#!/usr/bin/env ruby1.9.1

APP_ROOT = File.expand_path(File.dirname(__FILE__))

# global load
# DataMapper
require 'dm-core'  
require 'dm-timestamps'  
require 'dm-validations'  
require 'dm-migrations' 

# sinatra
require 'sinatra'

#gloabal gem
require 'json'

# local load
require './client.rb'
require './order.rb'


get '/' do
  redirect '/clients'
end

get '/orders' do
  "Hello World!"
end

get '/order/new' do
  "Hello World!"
end


# Setup for Datamapper
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup( :default, "sqlite3://#{Dir.pwd}/db/fidel.db" )

DataMapper.finalize
DataMapper.auto_upgrade!

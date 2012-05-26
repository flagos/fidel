#!/usr/bin/env ruby1.9.1

APP_ROOT = File.expand_path(File.dirname(__FILE__))

# global load
# DataMapper
require 'dm-core'  
require 'dm-timestamps'  
require 'dm-validations'  
require 'dm-migrations' 

# yaml
require 'yaml'

# sinatra
require 'sinatra'

#global gem
require 'json'

# local load
require './client.rb'
require './order.rb'


config = YAML::load(File.read("config.yml"))

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
if(config["db"]["connection_type"]=="sqlite3")
  DataMapper.setup( :default, "sqlite3://#{Dir.pwd}/db/fidel.db" )
else
  connec = config["db"]["connection_type"]
  host   = config["db"]["host"] || localhost
  db     = config["db"]["db"]
  user   = config["db"]["db_user"]
  pass   = config["db"]["db_pass"]

  DataMapper.setup( :default, "#{connec}://#{user}:#{pass}@#{host}/#{db}" )
end


DataMapper.finalize
DataMapper.auto_upgrade!

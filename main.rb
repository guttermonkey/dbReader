require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'dm-mysql-adapter'
require 'haml'

DataMapper::Logger.new($stdout, :debug)
DataMapper::setup(:default, 'mysql://hl7repeater:hl7repeater@localhost/hl7repeater')

class Message
	include DataMapper::Resource
	property :id, Serial
	property :raw_input, Text, :required => true
	property :created_at, DateTime
end

DataMapper.finalize.auto_upgrade!

class Main < Sinatra::Base
  get '/' do
	  @messages = Message.all
	  haml :home
  end
end

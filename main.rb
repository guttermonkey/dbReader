require 'rubygems'
require 'sinatra'
require 'data_mapper'

DataMapper::Logger.new($stdout, :debug)
DataMapper::setup(:default, 'mysql://hl7repeater:hl7repeater@localhost/hl7repeater')

class Message
	include DataMapper::Resource
	property :id, Serial
	property :raw_input, Text, :required => true
	property :created_at, DateTime
end

DataMapper.finalize.auto_upgrade!

get '/' do
	@messages = Message.all
	@title = 'All Messages'
	erb :home
end

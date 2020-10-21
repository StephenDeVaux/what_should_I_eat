     
require 'sinatra'
require 'sinatra/reloader' if development?# only reloads the main.rb file....
require 'pg'


get '/' do
  erb :index
end






require 'sinatra'
require 'sinatra/reloader' if development?# only reloads the main.rb file....
require 'pg'
require_relative 'db/data_access.rb'
require 'bcrypt'
require 'pry' if development?
enable :sessions # global variabls named session - which is just a hash

def logged_in?
  if session[:user_id]
    true
  else
    false
  end
end

get '/' do
  erb :index
end

get '/login' do 
  erb :login
end

post '/login' do 
  user = find_user_by_email(params["email"])
  if !user
    "No such user in system"
  elsif BCrypt::Password.new(user["password_hash"]) == params['password']
    session[:user_id] = user['id']
    # "loged in! sessionid = #{session[:user_id]}"
    redirect '/'
  else
    'failed to login'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end





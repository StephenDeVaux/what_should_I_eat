require 'sinatra'
require 'sinatra/reloader' if development? # only reloads the main.rb file....
require 'pg'
require_relative 'db/data_access.rb'
require 'bcrypt'
require 'pry' if development?
enable :sessions # global variabls named session - which is just a hash

def get_categories
  categories = %w[All Mains Side Dessert Starter Breakfast Snack Lunch Baking]
end

def get_units
  units = %w[Each g ml]
end

def number_of_pages ( num_results, recipes_pp) 
  pages = (num_results/recipes_pp).floor() 
  if num_results%recipes_pp == 0 
    return pages
  else
    return pages += 1
  end
end


def logged_in?
  if session[:user_id]
    true
  else
    false
  end
end

get '/' do
  recipes_pp = 5
  page_num = 1
  category = get_categories.first
  page_num = params['page_num'] unless params['page_num'].nil?
  recipes_pp = params['recipes_pp'] unless params['recipes_pp'].nil?
  category = params['category'] unless params['category'].nil?

  erb :index, locals: {page_num: page_num, recipes_pp: recipes_pp, category: category}
end

get '/login' do
  erb :login
end

post '/login' do
  user = find_user_by_email(params['email'])
  if !user
    'No such user in system'
  elsif BCrypt::Password.new(user['password_hash']) == params['password']
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

get '/myrecipes' do
  recipes_pp = 5
  page_num = 1
  category = get_categories.first
  page_num = params['page_num'] unless params['page_num'].nil?
  recipes_pp = params['recipes_pp'] unless params['recipes_pp'].nil?
  category = params['category'] unless params['category'].nil?

  erb :myrecipes, locals: {page_num: page_num, recipes_pp: recipes_pp, category: category}
end
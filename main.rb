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

def get_keywords
  keywords = %w[Vegetarian Beef Pork Chicken Quick Light Easy Italian Asian]
end

def get_units
  units = %w[Each g ml]
end

def get_recipes_pp
  num = 4
end

def number_of_pages(num_results, recipes_pp)
  pages = (num_results / recipes_pp).floor
  if num_results % recipes_pp == 0
    pages
  else
    pages += 1
  end
end

def logged_in?
  if session[:user_id]
    true
  else
    false
  end
end

require 'set'
def get_random_recipes(n, recipes)
  randoms = Set.new
  rand_recipes = []
  loop do
    randoms << rand(recipes.count)
    break if randoms.size >= n
  end
  randoms.each do |num|
    rand_recipes.push(recipes[num])
  end
  rand_recipes
end

def get_recipe_ids_from_list(recipes)
  indexes = recipes.map { |recipe| recipe['id'] }
end

get '/' do
  recipes_pp = get_recipes_pp
  page_num = 1
  category = get_categories.first
  page_num = params['page_num'] unless params['page_num'].nil?
  recipes_pp = params['recipes_pp'] unless params['recipes_pp'].nil?
  category = params['category'] unless params['category'].nil?
  erb :index, locals: { page_num: page_num, recipes_pp: recipes_pp, category: category }
end

get '/login' do
  message = ''
  message = params['message'] unless params['message'].nil?
  erb :login, locals: { message: message }
end

post '/login' do
  user = find_user_by_email(params['email'])
  if !user
    redirect '/login?message=No such user in system'
  elsif BCrypt::Password.new(user['password_hash']) == params['password']
    session[:user_id] = user['id']
    redirect '/'
  else
    redirect '/login?message=Password incorrect'
  end
end

get '/signup' do
  message = ''
  message = params['message'] unless params['message'].nil?
  erb :signup, locals: { message: message }
end

post '/user' do
  user = find_user_by_email(params['email'])
  if user
    redirect '/signup?message=User already exists'
  else
    add_user(email: params['email'], password_hash: BCrypt::Password.create(params['password']))
    redirect '/login?message=User created, please login'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/myrecipes' do
  recipes_pp = get_recipes_pp
  page_num = 1
  category = get_categories.first
  page_num = params['page_num'] unless params['page_num'].nil?
  recipes_pp = params['recipes_pp'] unless params['recipes_pp'].nil?
  category = params['category'] unless params['category'].nil?
  erb :myrecipes, locals: { page_num: page_num, recipes_pp: recipes_pp, category: category }
end

post '/userrecipe' do
  add_recipe_to_user_list(session[:user_id], params['recipe_id'])
  redirect '/myrecipes'
end

delete '/userrecipe' do
  delete_recipe_from_user_list(session[:user_id], params['recipe_id'])
  redirect '/myrecipes'
end

get '/addrecipe' do
  erb :addrecipe
end

get '/recipe' do
  erb :recipe, locals: { recipe_id: params['recipe_id'] }
end

post '/recipe' do
  ingredients = []
  1.upto 20 do |n|
    next unless (params["ingredient#{n}"]) != ''

    ingredients.push({
                       quantity: params["quantity#{n}"],
                       ingredient_id: find_ingredient_id_by_name(params["ingredient#{n}"])
                     })
  end

  recipe = {
    user_id: session[:user_id],
    name: params['name'],
    category: params['category'],
    servings: params['servings'],
    preperation_time: params['preperation_time'],
    recipe_steps: params['recipe_steps'],
    rating_stars: 0,
    rating_votes: 0,
    image_url: params['image_url'],
    ingredients: ingredients
  }

  add_recipe(recipe)
  redirect '/'
end

post '/userrecipe/edit/' do
  erb :editrecipe, locals: { recipe_id: params['recipe_id'] }
end

patch '/recipe' do
  ingredients = []
  1.upto 20 do |n|
    next unless (params["ingredient#{n}"]) != ''

    ingredients.push({
                       quantity: params["quantity#{n}"],
                       ingredient_id: find_ingredient_id_by_name(params["ingredient#{n}"])
                     })
  end

  recipe = {
    user_id: session[:user_id],
    name: params['name'],
    category: params['category'],
    servings: params['servings'],
    preperation_time: params['preperation_time'],
    recipe_steps: params['recipe_steps'],
    rating_stars: 0,
    rating_votes: 0,
    image_url: params['image_url'],
    ingredients: ingredients
  }

  update_recipe(recipe, params['recipe_id'])
  redirect '/myrecipes'
end

get '/mealplanner' do
  erb :mealplanner
end

post '/mealplanner' do
  erb :mealplannerresults, locals: { num_meals: params['num_meals'], category: params['category'] }
end

post '/shoppinglist' do
  # raise params["recipe_ids"]
  erb :shoppinglist, locals: { recipe_ids: params['recipe_ids'] }
end

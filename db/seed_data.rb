require 'pg'
require_relative 'data_access'
require 'bcrypt'

users = [{
  email: 'stevey@mail.com',
  password_hash: BCrypt::Password.create('pass1')
},
         {
           email: 'bob@mail.com',
           password_hash: BCrypt::Password.create('pass1')
         }]

ingredients = [{
  name: 'Tomato',
  units: 'each'
},
               {
                 name: 'Ham',
                 units: 'grams'
               },
               {
                 name: 'flour',
                 units: 'grams'
               },
               {
                 name: 'cheese',
                 units: 'grams'
               },
               {
                 name: 'eggs',
                 units: 'grams'
               },
               {
                 name: 'Bread',
                 units: 'slice'
               }]

create_recipe_hashes = [{
  user_id: 1,
  name: 'sandwhich',
  category: 'lunch',
  keywords: '{quick}',
  servings: 1,
  preperation_time: 5,
  recipe_steps: "{'Get out bread', 'cut bread', 'butter', 'assemble toppings on sandwhich', 'eat'}",
  rating_stars: 5,
  rating_votes: 100,
  image_url: nil,
  ingredients: [
    { quantity: 1, ingredient_id: 1 },
    { quantity: 100, ingredient_id: 2 },
    { quantity: 100, ingredient_id: 4 }
  ]
},
                        {
                          user_id: 1,
                          name: 'cake',
                          category: 'baking',
                          keywords: '{baking}',
                          servings: 8,
                          preperation_time: 120,
                          recipe_steps: "{'Measure ingredienst', 'Mix them all in a bowl', 'Bake in the oven', 'Put candles on top', 'eat'}",
                          rating_stars: 5,
                          rating_votes: 1000,
                          image_url: nil,
                          ingredients: [
                            { quantity: 3, ingredient_id: 5 },
                            { quantity: 500, ingredient_id: 3 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        }]

# full_recipe_hash = {
#   id:  ,
#   user_id:  ,
#   name:  ,
#   category:  ,
#   keyword:  ,
#   servings:  ,
#   preperation_time:  ,
#   recipe_steps:  ,
#   rating_stars:  ,
#   rating_votes:  ,
#   image_url:  ,
#   ingredients: [{
#     id: ,
#     recipe_id:,
#     quantity:,
#     ingredient_id:
#   }]
# }

users.each do |_user|
  add_user(_user)
end

ingredients.each do |_ingredient|
  add_ingredient(_ingredient)
end

create_recipe_hashes.each do |_recipe|
  add_recipe(_recipe)
end


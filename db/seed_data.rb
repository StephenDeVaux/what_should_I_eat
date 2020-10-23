require 'pg'
require_relative 'data_access'
require 'bcrypt'
# heroku pg:push local_database_name DATABASE_URL

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
  name: '1sandwhich',
  category: 'Lunch',
  servings: 1,
  preperation_time: 5,
  recipe_steps: "1. Get Bread 2. Cut Bread 3. Butter 4. Eat",
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
                          name: '2cake',
                          category: 'Baking',
                          servings: 8,
                          preperation_time: 120,
                          recipe_steps: "1. Measure Ingredients 2. Mix them 3. Bake in oven. 4.EAT",
                          rating_stars: 5,
                          rating_votes: 1000,
                          image_url: nil,
                          ingredients: [
                            { quantity: 3, ingredient_id: 5 },
                            { quantity: 500, ingredient_id: 3 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        },
                        {
                          user_id: 1,
                          name: '3sandwhich',
                          category: 'Lunch',
                          servings: 1,
                          preperation_time: 5,
                          recipe_steps: "1. Get Bread 2. Cut Bread 3. Butter 4. Eat",
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
                          name: '4cake',
                          category: 'Baking',
                          servings: 8,
                          preperation_time: 120,
                          recipe_steps: "1. Measure Ingredients 2. Mix them 3. Bake in oven. 4.EAT",
                          rating_stars: 5,
                          rating_votes: 1000,
                          image_url: nil,
                          ingredients: [
                            { quantity: 3, ingredient_id: 5 },
                            { quantity: 500, ingredient_id: 3 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        },
                        {
                          user_id: 1,
                          name: '5sandwhich',
                          category: 'Lunch',
                          servings: 1,
                          preperation_time: 5,
                          recipe_steps: "1. Get Bread 2. Cut Bread 3. Butter 4. Eat",
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
                          name: '6cake',
                          category: 'Baking',
                          servings: 8,
                          preperation_time: 120,
                          recipe_steps: "1. Measure Ingredients 2. Mix them 3. Bake in oven. 4.EAT",
                          rating_stars: 5,
                          rating_votes: 1000,
                          image_url: nil,
                          ingredients: [
                            { quantity: 3, ingredient_id: 5 },
                            { quantity: 500, ingredient_id: 3 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        },
                        {
                          user_id: 1,
                          name: '7sandwhich',
                          category: 'Lunch',
                          servings: 1,
                          preperation_time: 5,
                          recipe_steps: "1. Get Bread 2. Cut Bread 3. Butter 4. Eat",
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
                          name: '8cake',
                          category: 'Baking',
                          servings: 8,
                          preperation_time: 120,
                          recipe_steps: "1. Measure Ingredients 2. Mix them 3. Bake in oven. 4.EAT",
                          rating_stars: 5,
                          rating_votes: 1000,
                          image_url: nil,
                          ingredients: [
                            { quantity: 3, ingredient_id: 5 },
                            { quantity: 500, ingredient_id: 3 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        },
                        {
                          user_id: 1,
                          name: '9sandwhich',
                          category: 'Lunch',
                          servings: 1,
                          preperation_time: 5,
                          recipe_steps: "1. Get Bread 2. Cut Bread 3. Butter 4. Eat",
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
                          name: '10cake',
                          category: 'Baking',
                          servings: 8,
                          preperation_time: 120,
                          recipe_steps: "1. Measure Ingredients 2. Mix them 3. Bake in oven. 4.EAT",
                          rating_stars: 5,
                          rating_votes: 1000,
                          image_url: nil,
                          ingredients: [
                            { quantity: 3, ingredient_id: 5 },
                            { quantity: 500, ingredient_id: 3 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        },
                        {
                          user_id: 1,
                          name: '11sandwhich',
                          category: 'Lunch',
                          servings: 1,
                          preperation_time: 5,
                          recipe_steps: "1. Get Bread 2. Cut Bread 3. Butter 4. Eat",
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
                          name: '12sandwhich',
                          category: 'Lunch',
                          servings: 1,
                          preperation_time: 5,
                          recipe_steps: "1. Get Bread 2. Cut Bread 3. Butter 4. Eat",
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
                          name: '13cake',
                          category: 'Baking',
                          servings: 8,
                          preperation_time: 120,
                          recipe_steps: "1. Measure Ingredients 2. Mix them 3. Bake in oven. 4.EAT",
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

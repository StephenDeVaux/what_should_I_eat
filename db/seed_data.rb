require 'pg'
require_relative 'data_access'
require 'bcrypt'
# heroku pg:push whattoeat DATABASE_URL

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
                 units: 'each'
               },
               {
                 name: 'water',
                 units: 'ml'
               },
               {
                 name: 'butter',
                 units: 'grams'
               },
               {
                 name: 'bananas',
                 units: 'each'
               },
               {
                 name: 'lettuce',
                 units: 'pieces'
               },
               {
                 name: 'eggs',
                 units: 'each'
               },
               {
                 name: 'eggs',
                 units: 'each'
               },
               {
                 name: 'eggs',
                 units: 'each'
               },
               {
                 name: 'eggs',
                 units: 'each'
               },
               {
                 name: 'Bread',
                 units: 'slice'
               }]

create_recipe_hashes = [{
  user_id: 1,
  name: 'Nice Sandwhich',
  category: 'Lunch',
  servings: 1,
  preperation_time: 5,
  recipe_steps: "1. Get Bread 2. Cut Bread 3. Butter 4. Eat",
  rating_stars: 5,
  rating_votes: 100,
  image_url: "https://www.users.miamioh.edu/sheehac5/IMS222/img/ham_sandwhich.jpg",
  ingredients: [
    { quantity: 1, ingredient_id: 1 },
    { quantity: 100, ingredient_id: 2 },
    { quantity: 100, ingredient_id: 4 }
  ]
},
                        {
                          user_id: 1,
                          name: 'Chocolate Cake',
                          category: 'Baking',
                          servings: 8,
                          preperation_time: 120,
                          recipe_steps: "1. Measure Ingredients 2. Mix them 3. Bake in oven. 4.EAT",
                          rating_stars: 5,
                          rating_votes: 1000,
                          image_url: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/triple-chocolate-peanut-butter-layer-cake-2-06eee24.jpg?quality=90&resize=500%2C454",
                          ingredients: [
                            { quantity: 3, ingredient_id: 5 },
                            { quantity: 500, ingredient_id: 3 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        },
                        {
                          user_id: 1,
                          name: 'Average Sandwich',
                          category: 'Lunch',
                          servings: 1,
                          preperation_time: 5,
                          recipe_steps: "1. Get Bread 2. Cut Bread 3. Butter 4. Eat",
                          rating_stars: 5,
                          rating_votes: 100,
                          image_url: "https://www.pngitem.com/pimgs/m/416-4161059_blt-sandwhich-food-fakefood-yum-delicous-yum-breakfast.png",
                          ingredients: [
                            { quantity: 1, ingredient_id: 1 },
                            { quantity: 100, ingredient_id: 2 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        },
                        {
                          user_id: 1,
                          name: 'Pink Cake',
                          category: 'Baking',
                          servings: 8,
                          preperation_time: 120,
                          recipe_steps: "1. Measure Ingredients 2. Mix them 3. Bake in oven. 4.EAT",
                          rating_stars: 5,
                          rating_votes: 1000,
                          image_url: "https://img.taste.com.au/6BqPVQKE/taste/2020/04/may20_pretty-in-pink-cake-160772-1.jpg",
                          ingredients: [
                            { quantity: 3, ingredient_id: 5 },
                            { quantity: 500, ingredient_id: 3 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        },
                        {
                          user_id: 1,
                          name: 'Greasy sandwhich',
                          category: 'Lunch',
                          servings: 1,
                          preperation_time: 5,
                          recipe_steps: "1. Get Bread 2. Cut Bread 3. Butter 4. Eat",
                          rating_stars: 5,
                          rating_votes: 100,
                          image_url: "https://img-global.cpcdn.com/recipes/002daa18f189f68b/751x532cq70/chicken-fajita-sandwhich-recipe-main-photo.jpg",
                          ingredients: [
                            { quantity: 1, ingredient_id: 1 },
                            { quantity: 100, ingredient_id: 2 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        },
                        {
                          user_id: 1,
                          name: 'Carrot Cake',
                          category: 'Baking',
                          servings: 8,
                          preperation_time: 120,
                          recipe_steps: "1. Measure Ingredients 2. Mix them 3. Bake in oven. 4.EAT",
                          rating_stars: 5,
                          rating_votes: 1000,
                          image_url: "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/carrot-cake-8d8dfb5.jpg?quality=90&resize=960,872",
                          ingredients: [
                            { quantity: 3, ingredient_id: 5 },
                            { quantity: 500, ingredient_id: 3 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        },
                        {
                          user_id: 1,
                          name: 'Healthy Sandwhich',
                          category: 'Lunch',
                          servings: 1,
                          preperation_time: 5,
                          recipe_steps: "1. Get Bread 2. Cut Bread 3. Butter 4. Eat",
                          rating_stars: 5,
                          rating_votes: 100,
                          image_url: "https://motionmobs.com/wp-content/uploads/2019/05/mae-mu-1474246-unsplash.jpg",
                          ingredients: [
                            { quantity: 1, ingredient_id: 1 },
                            { quantity: 100, ingredient_id: 2 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        },
                        {
                          user_id: 1,
                          name: 'Berry cake',
                          category: 'Baking',
                          servings: 8,
                          preperation_time: 120,
                          recipe_steps: "1. Measure Ingredients 2. Mix them 3. Bake in oven. 4.EAT",
                          rating_stars: 5,
                          rating_votes: 1000,
                          image_url: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimg1.cookinglight.timeinc.net%2Fsites%2Fdefault%2Ffiles%2Fstyles%2F4_3_horizontal_-_1200x900%2Fpublic%2F1542062283%2Fchocolate-and-cream-layer-cake-1812-cover.jpg%3Fitok%3DR_xDiShk",
                          ingredients: [
                            { quantity: 3, ingredient_id: 5 },
                            { quantity: 500, ingredient_id: 3 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        },
                        {
                          user_id: 1,
                          name: 'Cheesy roll',
                          category: 'Lunch',
                          servings: 1,
                          preperation_time: 5,
                          recipe_steps: "1. Get Bread 2. Cut Bread 3. Butter 4. Eat",
                          rating_stars: 5,
                          rating_votes: 100,
                          image_url: "https://pbs.twimg.com/media/EOcjcH7XsAcSphJ.jpg",
                          ingredients: [
                            { quantity: 1, ingredient_id: 1 },
                            { quantity: 100, ingredient_id: 2 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        },
                        {
                          user_id: 1,
                          name: 'Christmas Cake',
                          category: 'Baking',
                          servings: 8,
                          preperation_time: 120,
                          recipe_steps: "1. Measure Ingredients 2. Mix them 3. Bake in oven. 4.EAT",
                          rating_stars: 5,
                          rating_votes: 1000,
                          image_url: "https://www.recipetineats.com/wp-content/uploads/2019/12/Christmas-Cake-decorated-with-fondant-marzipan-and-cherries.jpg",
                          ingredients: [
                            { quantity: 3, ingredient_id: 5 },
                            { quantity: 500, ingredient_id: 3 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        },
                        {
                          user_id: 1,
                          name: 'Layer sandwhich',
                          category: 'Lunch',
                          servings: 1,
                          preperation_time: 5,
                          recipe_steps: "1. Get Bread 2. Cut Bread 3. Butter 4. Eat",
                          rating_stars: 5,
                          rating_votes: 100,
                          image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTMXb3GKslVfZRkyqLYtfoeADTpqv34OrwwdQ&usqp=CAU",
                          ingredients: [
                            { quantity: 1, ingredient_id: 1 },
                            { quantity: 100, ingredient_id: 2 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        },
                        {
                          user_id: 1,
                          name: 'Noodel Bun',
                          category: 'Lunch',
                          servings: 1,
                          preperation_time: 5,
                          recipe_steps: "1. Get Bread 2. Cut Bread 3. Butter 4. Eat",
                          rating_stars: 5,
                          rating_votes: 100,
                          image_url: "https://favy-inbound-singapore.s3.amazonaws.com/uploads/topic_item/image/62163/retina_soba_sanwhich.jpg",
                          ingredients: [
                            { quantity: 1, ingredient_id: 1 },
                            { quantity: 100, ingredient_id: 2 },
                            { quantity: 100, ingredient_id: 4 }
                          ]
                        },
                        {
                          user_id: 1,
                          name: 'Car Cake',
                          category: 'Baking',
                          servings: 8,
                          preperation_time: 120,
                          recipe_steps: "1. Measure Ingredients 2. Mix them 3. Bake in oven. 4.EAT",
                          rating_stars: 5,
                          rating_votes: 1000,
                          image_url: "https://d266neeby8gbsu.cloudfront.net/eyJidWNrZXQiOiJwcm9kLWZlcmd1c29ucGxhcnJlLWFzc2V0cyIsImtleSI6ImNhdGFsb2cvcHJvZHVjdC9tL28vbW9uc3Rlcl90cnVja19ncmVjdXN0MTAuanBnIiwiZWRpdHMiOnsicmVzaXplIjp7IndpZHRoIjo1MDAsImhlaWdodCI6NTAwLCJmaXQiOiJjb250YWluIiwiYmFja2dyb3VuZCI6eyJyIjoyNTUsImciOjI1NSwiYiI6MjU1LCJhbHBoYSI6MX19fX0=",
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

def run_sql(sql, params = [])
  db = PG.connect(ENV['DATABASE_URL'] || { dbname: 'whattoeat' })
  results = db.exec(sql, params)
  db.close
  results
end

####################### USER #####################
def add_user(user_hash)
  run_sql('INSERT INTO users(email, password_hash) VALUES ($1, $2);', [user_hash[:email], user_hash[:password_hash]])
end

def find_user_by_email(email)
  user = run_sql("SELECT * from users WHERE email = '#{email}';")
  if user.count == 0
    nil
  else
    user[0]
  end
end

def find_user_by_id(id)
  user = run_sql("SELECT * from users WHERE id = #{id};")
  user[0]
end

####################### INGREDIENT #####################
def add_ingredient(ing_hash)
  run_sql('INSERT INTO ingredients (name, units) VALUES ($1, $2) RETURNING id;', [ing_hash[:name], ing_hash[:units]])
end

def all_ingredients
  run_sql('SELECT * FROM ingredients;')
end

def find_ingredient_id_by_name(name)
  ingredients = run_sql('SELECT * FROM ingredients WHERE name = $1', [name])
  ingredients[0]['id']
end

def find_ingredient_name_by_id(id)
  ingredients = run_sql('SELECT * FROM ingredients WHERE id = $1', [id])
  ingredients[0]['name']
end

def units_by_id(id)
  ingredients = run_sql('SELECT * FROM ingredients WHERE id = $1', [id])
  ingredients[0]['units']
end

####################### RECIPE #####################
def add_recipe(rec_hash)
  recipe_id = run_sql('INSERT INTO recipes(user_id, name, category, servings, preperation_time, recipe_steps, rating_stars, rating_votes, image_url) values($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING id;', [
                        rec_hash[:user_id],
                        rec_hash[:name],
                        rec_hash[:category],
                        rec_hash[:servings],
                        rec_hash[:preperation_time],
                        rec_hash[:recipe_steps],
                        rec_hash[:rating_stars],
                        rec_hash[:rating_votes],
                        rec_hash[:image_url]
                      ]).first['id']

  rec_hash[:ingredients].each do |ingredient|
    run_sql("INSERT INTO recipe_ingredients(recipe_id, quantity, ingredient_id) VALUES ('#{recipe_id}', '#{ingredient[:quantity]}', '#{ingredient[:ingredient_id]}');")
  end
end

def all_recipes(category = 'All', limit = 'NULL', skip = 0)
  if category == 'All'
    run_sql("SELECT * FROM recipes LIMIT #{limit} OFFSET #{skip};")
  else
    run_sql("SELECT * FROM recipes WHERE category = '#{category}'  LIMIT #{limit} OFFSET #{skip};")
  end
end

def find_recipe_by_id(id)
  recipe = run_sql('SELECT * FROM recipes WHERE id = $1;', [id])
  recipe[0]
end

def update_recipe(rec_hash, rec_id)
  recipe = run_sql('UPDATE recipes SET name = $1, category = $2, servings = $3, preperation_time =$4, recipe_steps = $5, rating_stars = $6, rating_votes = $7, image_url = $8 WHERE id = $9;', [
                     rec_hash[:name],
                     rec_hash[:category],
                     rec_hash[:servings],
                     rec_hash[:preperation_time],
                     rec_hash[:recipe_steps],
                     rec_hash[:rating_stars],
                     rec_hash[:rating_votes],
                     rec_hash[:image_url],
                     rec_id
                   ])

  run_sql('DELETE FROM recipe_ingredients WHERE recipe_id = $1;', [rec_id])
  rec_hash[:ingredients].each do |ingredient|
    run_sql("INSERT INTO recipe_ingredients(recipe_id, quantity, ingredient_id) VALUES ('#{rec_id}', '#{ingredient[:quantity]}', '#{ingredient[:ingredient_id]}');")
  end
end

####################### USER_RECIPES #####################
def add_recipe_to_user_list(user_id, recipe_id, rating = 4)
  run_sql('INSERT INTO user_recipes (user_id, recipe_id, rating) VALUES ($1, $2, $3);', [user_id, recipe_id, rating])
end

def find_user_recipe_list(category = 'All', limit = 'NULL', skip = 0)
  user_id = session[:user_id]
  recipe_list = []
  if category == 'All'
    recipe_ids = run_sql("SELECT * FROM user_recipes WHERE user_id = $1 LIMIT #{limit} OFFSET #{skip};", [user_id])
    recipe_ids.each do |recipe_id|
      recipe = run_sql("SELECT * FROM recipes WHERE id = '#{recipe_id['recipe_id']}';")
      recipe_list.push(recipe[0])
    end
  else
    recipe_ids = run_sql("SELECT * FROM user_recipes WHERE user_id = $1 LIMIT #{limit} OFFSET #{skip};", [user_id])
    recipe_ids.each do |recipe_id|
      recipe = run_sql('SELECT * FROM recipes WHERE (id = $1 AND category = $2);', [recipe_id['recipe_id'], category])
      recipe_list.push(recipe[0]) unless recipe.count == 0
    end
  end
  recipe_list
end

def delete_recipe_from_user_list(user_id, recipe_id)
  user_recipe = run_sql('SELECT * FROM user_recipes WHERE (user_id = $1 AND recipe_id = $2) LIMIT 1;', [user_id, recipe_id])
  run_sql('DELETE FROM user_recipes WHERE id = $1;', [user_recipe[0]['id']])
end

####################### RECIPES_INGREDIENTS #####################
def find_ingredients_for_recipe(recipe_id)
  run_sql('SELECT * FROM recipe_ingredients WHERE recipe_id = $1;', [recipe_id])
end

def find_ingredients_for_list_of_recipes(recipe_ids)
  ingredients = []
  recipe_ids.each do |id|
    list = run_sql('SELECT * FROM recipe_ingredients WHERE recipe_id = $1;', [id])
    ingredients = ingredients.concat(list.to_a)
  end

  ing_ids = ingredients.map { |n| n['ingredient_id'] }
  ing_ids.uniq!

  ingredients

  totals = []
  ing_ids.each do |id|
    sum = 0
    ingredients.each do |q|
      sum += q['quantity'].to_i if q['ingredient_id'] == id
    end
    hash = { 'ingredient_id' => id, 'quantity' => sum }
    totals.push(hash)
  end
  totals
end

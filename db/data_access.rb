def run_sql(sql, params = [])
  db = PG.connect(ENV['DATABASE_URL'] || { dbname: 'whattoeat' })
  results = db.exec(sql, params)
  db.close
  results
end

def add_user(user_hash = { recipe_list: nil })
  run_sql('INSERT INTO users(email, password_hash, recipe_list) VALUES ($1, $2, $3);', [user_hash[:email], user_hash[:password_hash], user_hash[:recipe_list]])
end

def find_user_by_email(email)
  user = run_sql("SELECT * from users WHERE email = '#{email}';")
  if user.count == 0
    return nil
  else
    return user[0]
  end
end

def find_user_by_id(id)
  user = run_sql("SELECT * from users WHERE id = #{id};")
  return user[0]
end

def add_ingredient(ing_hash)
  run_sql("INSERT INTO ingredients (name, units) VALUES ($1, $2) RETURNING id;", [ ing_hash[:name], ing_hash[:units]])
end

def all_ingredients
  run_sql('SELECT * FROM ingredients;')
end

def add_recipe(rec_hash)
  recipe_id = run_sql('INSERT INTO recipes(user_id, name, category, keywords, servings, preperation_time, recipe_steps, rating_stars, rating_votes, image_url) values($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING id;', [
                        rec_hash[:user_id],
                        rec_hash[:name],
                        rec_hash[:category],
                        rec_hash[:keywords],
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

# def find_all_recipes
#   run_sql("SELECT * FROM recipes;")
# end

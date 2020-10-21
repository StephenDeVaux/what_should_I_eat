def run_sql(sql, params = [])
    db = PG.connect(ENV['DATABASE_URL'] || dbname: 'recipes')
    results = db.exec(sql, params)
    db.close
    results
  end
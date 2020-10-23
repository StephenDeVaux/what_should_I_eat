CREATE DATABASE whattoeat;

\c whattoeat;

DROP TABLE IF EXISTS recipes; 
DROP TABLE IF EXISTS users; 
DROP TABLE IF EXISTS ingredients; 
DROP TABLE IF EXISTS recipe_ingredients; 
DROP TABLE IF EXISTS user_recipes; 

CREATE TABLE recipes ( 
    id SERIAL PRIMARY KEY,
    user_id INTEGER,
    name varCHAR(200), 
    category varCHAR(200),
    keywords varCHAR(200) [], 
    servings INTEGER, 
    preperation_time INTEGER, 
    recipe_steps TEXT [], 
    rating_stars INTEGER,
    rating_votes INTEGER,
    image_url TEXT
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY, 
    email varCHAR(200),
    password_hash TEXT
);

CREATE TABLE ingredients( 
    id SERIAL PRIMARY KEY,
    name varCHAR(200),
    units varCHAR(200),
    api_search_name varCHAR(200)
);

CREATE TABLE recipe_ingredients ( 
    id SERIAL PRIMARY KEY,
    recipe_id INTEGER, 
    quantity INTEGER, 
    ingredient_id INTEGER
);

CREATE TABLE user_recipes ( 
    id SERIAL PRIMARY KEY,
    user_id INTEGER, 
    recipe_id INTEGER, 
    rating INTEGER
);

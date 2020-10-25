# What Should I Eat?

Web app built for project as part of General Assembly course. The aim of the project was to build a web app on the following technology stack:
- Posgres SQL database
- Ruby server
- Hosted on Heroku

The topic choosen is a recipe site that solves the following problems!
1. To help manage your personal recipes by having central location where they are properly stored and easily accessible
2. To assist in deciding what to eat. Making decisions is hard, and this can be made easier by a computer choosing a weekly meal plan for you!
3. Making a shopping list. Another painful task that can be easily automated by a computer
4. As a scope creep function - the idea of being able to see what the nutrional value of your meal might be

Link - https://whatshouldieat2.herokuapp.com

![alt text](https://raw.githubusercontent.com/StephenDeVaux/what_should_I_eat/main/public/images/website.png)

### 2. Development

The first thing planned for was the overall functionality and interface of the site. This was done by building wireframes to visualise how it all fits together and how many pages will be required. 
![alt text](https://raw.githubusercontent.com/StephenDeVaux/what_should_I_eat/main/public/images/wireframes.png)

Next the database schema was outlined. As one fo the important features was to be able to create a shopping list, this resulted in the need to have a single global list of ingredients that defines each ingredient and its specific units(eg, grams, liters etc). Otherwise when creating the shopping list you would end up with duplicates or would be difficult to add equivalent ingredients from different recipes. 
![alt text](https://raw.githubusercontent.com/StephenDeVaux/what_should_I_eat/main/public/images/databaseSchema.png)

A project plan with all the forseen tasks was created using the kanbaan project planner feature in Github. 

### 3. Challenges
- Determining the shopping list requires multiple database queries and summation of results. Higher level database queries could improve the process
- There are still a number of outstanding bugs within the code
- With the serperation of Ruby and Javascript, difficult to use javascript for some styling. Navbar buttons styling quite dodgy.

### 5. Lessons
- Scope was a bit big for the time allowed
- ran out of time to refactor code nicely

Things to add still:
 - nutrional info API 
 - Sorting of recipes
 - Can add same recipe twice to your list? Maybe not useful
 - If User edits recipes, edits for all users, not very useful
 - The meal planner doesnt save your recipes anywhere, so once its gone its gone... 
 - addition of meal search



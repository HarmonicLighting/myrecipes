# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

chef = Chef.create!(name: 'John', email: 'admin@example.com',password: 'recipes', password_confirmation: 'recipes', admin: true)
chef2 = Chef.create!(name: 'Joe', email: 'JOE@EXAMPLE.COM',password: '12345asdef', password_confirmation: '12345asdef')
chef3 = Chef.create!(name: 'Keri', email: 'keri@EXAMPLE.COM',password: '12345asdef', password_confirmation: '12345asdef')
chef4 = Chef.create!(name: 'Russ', email: 'russ@EXAMPLE.COM',password: '12345asdef', password_confirmation: '12345asdef')
chef5 = Chef.create!(name: 'Terra', email: 'terra@EXAMPLE.COM',password: '12345asdef', password_confirmation: '12345asdef')
chef6 = Chef.create!(name: 'Caballo', email: 'ca.ballo@EXAMPLE.COM',password: '12345asdef', password_confirmation: '12345asdef')

recipe = chef.recipes.create!(name: 'Ordinary soup', description: 'Buy an instant soup at the closest grocery store and prepare it.')
chef.recipes.create!(name: 'Ordinary steak', description: 'Buy an steak at the closest grocery store and prepare it.')
chef.recipes.create!(name: 'Ordinary udon', description: 'Buy an instant udon at the closest grocery store and prepare it.')
chef.recipes.create!(name: 'Ordinary spagetti', description: 'Buy an spagetti at the closest grocery store and prepare it.')
chef.recipes.create!(name: 'Ordinary pancakes', description: 'Buy some pancakes at the closest grocery store and prepare it.')
chef.recipes.create!(name: 'Ordinary salad', description: 'Buy a salad at the closest grocery store and prepare it.')
chef2.recipes.create!(name: 'Ordinary taco', description: 'Buy an taco at the closest grocery store and prepare it.')
chef2.recipes.create!(name: 'Ordinary burrito', description: 'Buy an burrito at the closest grocery store and prepare it.')
chef3.recipes.create!(name: 'Ordinary Eggs', description: 'Buy some eggs at the closest grocery store and prepare it.')
chef3.recipes.create!(name: 'Ordinary sushi', description: 'Buy a sushi at the closest grocery store and prepare it.')
chef4.recipes.create!(name: 'Ordinary Chicken', description: 'Buy some chicken at the closest grocery store and prepare it.')
chef4.recipes.create!(name: 'Ordinary Beef', description: 'Buy some beef at the closest grocery store and prepare it.')
chef5.recipes.create!(name: 'Ordinary cocktail', description: 'Buy a cocktail at the closest grocery store and prepare it.')
chef5.recipes.create!(name: 'Ordinary pizza', description: 'Buy a pizza at the closest grocery store and prepare it.')
chef6.recipes.create!(name: 'Ordinary muffins', description: 'Buy some muffins at the closest grocery store and prepare it.')
chef6.recipes.create!(name: 'Ordinary coffee', description: 'Buy a coffee at the closest grocery store and prepare it.')

DifficultyLevel.create!(level: 1, name: 'Easy')
DifficultyLevel.create!(level: 2, name: 'Medium')
DifficultyLevel.create!(level: 3, name: 'High')

ingredient_1 = Ingredient.create!(name:'Chicken')
ingredient_2 = Ingredient.create!(name:'Potato')
Ingredient.create!(name:'Tomato')
Ingredient.create!(name:'Pork')
Ingredient.create!(name:'Apple')
Ingredient.create!(name:'Lettuce')
Ingredient.create!(name:'Orange')
Ingredient.create!(name:'Broccoli')
Ingredient.create!(name:'Butter')
Ingredient.create!(name:'Flour')
Ingredient.create!(name:'Milk')
Ingredient.create!(name:'Yogurt')
Ingredient.create!(name:'Cheddar Cheese')
Ingredient.create!(name:'Banana')
Ingredient.create!(name:'Coffee')

Chef.first.recipes.first.ingredients << ingredient_1
Chef.first.recipes.last.ingredients << ingredient_2

Chef.first.recipes.first.ingredients << Ingredient.last
Chef.first.recipes.last.ingredients << Ingredient.last

Chef.last.recipes.first.ingredients << Ingredient.first
Chef.last.recipes.last.ingredients << Ingredient.first

Chef.last.recipes.first.ingredients << Ingredient.last
Chef.last.recipes.last.ingredients << Ingredient.last

Comment.create!(description: 'Great recipe!', chef_id: chef.id, recipe_id: recipe.id)

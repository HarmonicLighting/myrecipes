# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

chef = Chef.create(name: 'John', email: 'john@example.com',password: 'asdef12345', password_confirmation: 'asdef12345')
chef2 = Chef.create(name: 'Joe', email: 'JOE@EXAMPLE.COM',password: '12345asdef', password_confirmation: '12345asdef')
chef.recipes.create(name: 'Ordinary soup', description: 'Buy an instant soup at the closest grocery store and prepare it.')
chef.recipes.create(name: 'Ordinary steak', description: 'Buy an steak at the closest grocery store and prepare it.')
chef2.recipes.create(name: 'Ordinary taco', description: 'Buy an taco at the closest grocery store and prepare it.')

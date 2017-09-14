# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

chef = Chef.create(name: 'John', email: 'john@example.com',password_digest: 'asdef12345')
Chef.create(name: 'Joe', email: 'JOE@EXAMPLE.COM',password_digest: '12345asdef')
recipe = Recipe.new(name: 'Ordinary soup', description: 'Buy an instant soup at the closest grocery store and prepare it.')
chef.recipes << recipe

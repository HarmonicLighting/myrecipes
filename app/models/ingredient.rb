class Ingredient < ApplicationRecord
  validates :name, presence: true, length: {in: 3..25}
  validates_uniqueness_of :name
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients
end

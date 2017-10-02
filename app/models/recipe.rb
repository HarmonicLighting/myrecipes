class Recipe < ApplicationRecord
  belongs_to :chef
  belongs_to :difficulty_level, optional: true
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates_associated :chef
  validates :name, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { in: 5..1500 }
  validates :chef_id, presence: true
  default_scope -> { order(updated_at: :desc)}
end

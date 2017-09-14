class Recipe < ApplicationRecord
  belongs_to :chef
  validates_associated :chef
  validates :name, presence: true, length: { minimum: 2 }
  validates :description, presence: true, length: { in: 5..500 }
end

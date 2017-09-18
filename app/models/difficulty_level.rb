class DifficultyLevel < ApplicationRecord
  has_many :recipes, dependent: :nullify
  validates :level, presence: true
  validates_uniqueness_of :level
  validates :name, presence: true, length: {in: 3..25}
  validates_uniqueness_of :name
end

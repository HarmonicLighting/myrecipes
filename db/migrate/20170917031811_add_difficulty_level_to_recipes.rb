class AddDifficultyLevelToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_reference :recipes, :difficulty_level, foreign_key: true
  end
end

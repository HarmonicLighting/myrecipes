class RenameIngredientesTableToIngredientsTable < ActiveRecord::Migration[5.1]
  def change
    rename_table :ingredientes, :ingredients
  end
end

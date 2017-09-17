class CreateIngredientes < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredientes do |t|
      t.string :name
    end
  end
end

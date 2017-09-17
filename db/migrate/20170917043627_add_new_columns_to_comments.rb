class AddNewColumnsToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :description, :text
    add_column :comments, :chef_id, :integer
    add_column :comments, :recipe_id, :integer
  end
end

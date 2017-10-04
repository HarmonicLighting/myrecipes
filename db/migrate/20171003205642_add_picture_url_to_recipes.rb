class AddPictureUrlToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :picture_url, :string
  end
end

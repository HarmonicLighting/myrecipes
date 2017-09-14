require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @user = Chef.create!(name:"TestChef", email:"thisisatest@email.com", password_digest:"asdasfasdas")
    @recipe = @user.recipes.create!(name:"Test recipe", description: "Add a lot of test to your app!")
    @recipe2 = @user.recipes.create!(name:"Test recipe 2", description: "Add a lot of test to your app! v2")
  end

  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  end

  test "should get new recipe page" do
    get new_recipe_path
    assert_response :success
  end

  test "should get recipe page" do
    get recipe_path(@recipe)
    assert_response :success
  end

  test "should get edit recipe page" do
    get edit_recipe_path(@recipe)
    assert_response :success
  end

end

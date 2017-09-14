require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @chef = Chef.create!(name:"TestChef", email:"thisisatest@email.com", password_digest:"asdasfasdas")
    @recipe = @chef.recipes.create!(name:"Test recipe", description: "Add a lot of test to your app!")
    @recipe2 = @chef.recipes.create!(name:"Test recipe 2", description: "Add a lot of test to your app! v2")
  end

  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
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

  test "should get recipes show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.name, response.body
  end

  test "create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "chicken saute"
    description_of_recipe = "add chicken and vegetables, coock for 20 minutes, serve with a pinch of salt"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params:{recipe:{name: name_of_recipe, description: description_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
  end

  test "reject invalid recipe submissions" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: {recipe: {name: " ", description: " "}}
    end
    assert_template 'recipes/new'
    assert_select 'div.recipe-block'
  end

end

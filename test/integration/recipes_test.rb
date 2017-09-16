require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest

  def setup
    @Email = "thisisatest@email.com"
    @Password = "asdasfasdas"
    @chef = Chef.create!(name:"TestChef", email: @Email, password: @Password, password_confirmation: "asdasfasdas")
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
    sign_in_as @chef, @Password
    get new_recipe_path
    assert_response :success
  end

  test "should get recipe page" do
    get recipe_path(@recipe)
    assert_response :success
  end

  test "should get edit recipe page" do
    sign_in_as @chef, @Password
    get edit_recipe_path(@recipe)
    assert_response :success
  end

  test "should get recipes show" do
    sign_in_as @chef, @Password
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.name, response.body
    assert_select 'a[href=?]', edit_recipe_path(@recipe), text:"edit it"
  end

  test "create new valid recipe" do
    sign_in_as @chef, @Password
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
    sign_in_as @chef, @Password
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: {recipe: {name: " ", description: " "}}
    end
    assert_template 'recipes/new'
    assert_select 'div.recipe-block'
  end

  test "edit valid recipe" do
    sign_in_as @chef, @Password
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = @recipe.name + " edited"
    updated_description = @recipe.description + " v2"
    assert_difference 'Recipe.count', 0 do
      patch recipe_path(@recipe), params:{recipe:{name: updated_name, description: updated_description}}
    end
    assert_redirected_to @recipe
    follow_redirect!
    assert_not flash.empty?
    assert_match updated_name.capitalize, response.body
    assert_match updated_description, response.body
    @recipe.reload
    assert_match updated_name.capitalize, @recipe.name
    assert_match updated_description, @recipe.description
  end

  test "reject invalid recipe update" do
    sign_in_as @chef, @Password
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params:{recipe:{name: " ", description:" some description"}}
    assert_template 'recipes/edit'
    assert_select 'div.recipe-block'
  end

  test "remove valid recipe" do
    sign_in_as @chef, @Password
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_select 'a[href=?]', recipe_path(@recipe)
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe)
    end
    assert_redirected_to recipes_path
    assert_not flash.empty?
  end

end

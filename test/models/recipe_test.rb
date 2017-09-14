require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup # Setting up test before being run
    @Chef = Chef.create!(name: 'Doe', email: 'doe@example.com',password_digest: 'asdef12345')
    @recipe = @Chef.recipes.create!(name: "vegetable", description:"great vegetable recipe")
  end

  test "previous recipe without chef should be invalid" do
    @recipe.chef_id = nil
    assert_not @recipe.save
  end

  test "new recipe without chef should be invalid" do
    new_recipe = Recipe.new(name: "vegetable", description:"great vegetable recipe")
    assert_not new_recipe.save
  end

  test "recipe should be valid" do
    assert @recipe.valid?
  end

  test "name should be preset" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end

  test "description should be preset" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end

  test "description shouldn't be less than 5 characters" do
    @recipe.description = "1234"
    assert_not @recipe.valid?
  end

  test "description shouldn't be more than 500 characters" do
    string = "a"*501
    @recipe.description = string
    assert_not @recipe.valid?
  end
end

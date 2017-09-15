require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest

  def setup # Setting up test before being run
    @chef = Chef.create!(name: 'Doe', email: 'doe@example.com',password: 'asdef12345', password_confirmation: 'asdef12345')
    @recipe = @chef.recipes.create!(name: "vegetable", description:"great vegetable recipe")
    @recipe2 = @chef.recipes.create!(name: "vegetable 2", description:"great vegetable recipe 2")
  end

  test "should get chefs show" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name.capitalize
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name.capitalize
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.name, response.body
  end

end

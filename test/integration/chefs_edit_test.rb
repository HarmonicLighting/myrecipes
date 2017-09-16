require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @Email = 'thisisatest@email.com'
    @Password = 'asdasfasdas'
    @chef = Chef.create!(name:"TestChef", email:"thisisatest@email.com", password: @Password, password_confirmation: @Password)
  end

  test "reject an invalid chef edit" do
    sign_in_as @chef, @Password
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params:{chef:{name: "", email: "someone@example.com"}}
    assert_template 'chefs/edit'
    assert_select 'div.chef-block'
  end

  test "Accept a valid chef edit" do
    sign_in_as @chef, @Password
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params:{chef:{name: "Someone Special", email: "someonespecial@example.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Someone Special", @chef.name
    assert_match "someonespecial@example.com", @chef.email
  end
end

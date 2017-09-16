require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @Email = 'thisisatest@email.com'
    @Email_2 = 'thisisatest2@email.com'
    @Email_admin = 'admin@email.com'
    @Password = 'asdasfasdas'
    @Password_2 = 'asdasfasdas'
    @Password_admin = 'asdasfasdas'
    @chef = Chef.create!(name: "TestChef", email:@Email, password: @Password, password_confirmation: @Password)
    @chef2 = Chef.create!(name: "TestChef2", email:@Email_2, password: @Password_2, password_confirmation: @Password_2)
    @admin = Chef.create!(name: "TestAdmin", email:@Email_admin, password: @Password_admin, password_confirmation: @Password_admin, admin: true)
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

  test "accept edit attempt by admin user" do
    sign_in_as @admin, @Password_admin
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params:{chef:{name: "Someone Special", email: "someonespecial@example.com"}}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Someone Special", @chef.name
    assert_match "someonespecial@example.com", @chef.email
  end

  test "redirect edit attempt by non-admin user" do
    sign_in_as @chef2, @Password_2
    patch chef_path(@chef), params:{chef:{name: "Someone Special", email: "someonespecial@example.com"}}
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_equal "Testchef", @chef.name
    assert_match @chef.email, @Email
  end
end

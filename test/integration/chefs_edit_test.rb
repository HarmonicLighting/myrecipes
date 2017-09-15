require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(name:"TestChef", email:"thisisatest@email.com", password:"asdasfasdas", password_confirmation: "asdasfasdas")
  end

  test "reject an invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params:{chef:{name: "", email: "someone@example.com"}}
    assert_template 'chefs/edit'
    assert_select 'div.chef-block'
  end

  test "accept valid signup" do
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

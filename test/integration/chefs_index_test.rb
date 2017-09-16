require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @Email = 'thisisatest@email.com'
    @Password = 'asdasfasdas'
    @Email_admin = 'admin@email.net'
    @Password_admin = 'asdasfasdas'
    @chef = Chef.create!(name: 'TestChef', email: @Email, password: @Password, password_confirmation: @Password)
    @chef2 = Chef.create!(name: 'TestChef2', email: 'chef2@example.com', password: 'iamchef2', password_confirmation: 'iamchef2')
    @chef_admin = Chef.create!(name: 'Testchef_admin', email: @Email_admin, password: @Password_admin, password_confirmation: @Password_admin, admin: true)
  end

  test 'should get chefs index' do
    get chefs_path
    assert_response :success
  end

  test 'should get chefs listing' do
    get chefs_path
    assert_template 'chefs/index'
    assert_select 'a[href=?]', chef_path(@chef), text: @chef.name
    assert_select 'a[href=?]', chef_path(@chef_admin), text: @chef_admin.name
  end

  test 'admin should delete chef' do
    sign_in_as @chef_admin, @Password_admin
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef)
    end
    assert_redirected_to chefs_path
    assert_not flash[:warning].empty?
  end

  test 'non admin should not delete chef' do
    sign_in_as @chef, @Password
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', 0 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash[:danger].empty?
  end

  test 'admin should not delete admin' do
    sign_in_as @chef_admin, @Password_admin
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', 0 do
      delete chef_path(@chef_admin)
    end
    assert_redirected_to chefs_path
    assert_not flash[:danger].empty?
  end
end

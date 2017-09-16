require 'test_helper'

class ChefsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(name: 'TestChef', email: 'thisisatest@email.com', password: 'asdasfasdas', password_confirmation: 'asdasfasdas')
    @chef2 = Chef.create!(name: 'TestChef2', email: 'thisisatest@email.net', password: 'asdasfasdas', password_confirmation: 'asdasfasdas')
  end

  test 'should get chefs index' do
    get chefs_path
    assert_response :success
  end

  test 'should get chefs listing' do
    get chefs_path
    assert_template 'chefs/index'
    assert_select 'a[href=?]', chef_path(@chef), text: @chef.name
    assert_select 'a[href=?]', chef_path(@chef2), text: @chef2.name
  end

  test 'should delete chef' do
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to chefs_path
    assert_not flash[:warning].empty?
  end
end

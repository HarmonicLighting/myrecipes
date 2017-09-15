require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create(name: 'Doe', email: 'doe@example.com', password: 'asdef12345', password_confirmation:'asdef12345')
  end

  test "should be valid" do
    assert @chef.valid?
  end

  test "name should be present" do
    @chef.name = " "
    assert_not @chef.valid?
  end

  test "name should be less than 31 characters" do
    @chef.name = "a"*31
    assert_not @chef.valid?
  end

  test "password_digest should be present" do
    @chef.password_digest = " "
    assert_not @chef.valid?
  end

  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "emails should be valid" do
    emails = %w(SoMeOne@someone.net aaaaaxqeeeeeee@asd.sg IAMANEMAIL@asd.it)
    emails.each do |email|
      @chef.email = email
      assert @chef.valid?, "#{email.inspect} should be valid"
    end
  end

  test "not emails should not be valid" do
    not_emails = %w(SoMeOne@someone aaaaaxqeeeeeeeasd.sg @asd.it)
    not_emails.each do |not_email|
      @chef.email = not_email
      assert_not @chef.valid?, "#{not_email.inspect} should be valid"
    end
  end

  test "email should be unique" do
    chef2 = @chef.dup
    chef2.save
    assert_not chef2.valid?
  end

  test "email should be lowercase before hitting db" do
    mixed_email = "eMaiL@gMaIl.CoM"
    @chef.email = mixed_email
    assert @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end

  test "password should be present" do
    chef = Chef.new(name: 'Doe', email: 'anotherone@example.com', password: ' ', password_confirmation:' ')
    assert_not chef.valid?
  end
  test "password show be at least 5 characters and at most 50 characters long" do
    chef = Chef.new(name: 'Doe', email: 'anotherone@example.com', password: 'a'*4, password_confirmation:'a'*4)
    assert_not chef.valid?
    chef.password = 'a'*51
    chef.password_confirmation = 'a'*51
    assert_not chef.valid?
    chef.password = 'a'*50
    chef.password_confirmation = 'a'*50
    assert chef.valid?
  end

  test "password should be confirmed" do
    chef = Chef.new(name: 'Doe', email: 'anotherone@example.com', password: 'a'*5, password_confirmation:"")
    assert_not chef.valid?
    chef.password_confirmation = 'a'*6
    assert_not chef.valid?
    chef.password_confirmation = 'a'*5
    assert chef.valid?
  end
end

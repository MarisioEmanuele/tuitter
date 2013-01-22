require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  setup do
    @user = create_a_user!
  end
  
  test "can authenticate a user" do
    assert @user.authenticate(@user.password), "password ok"
  end
  
  test "will reject invalid passwords" do
    assert !@user.authenticate("bad password"), "bad password"
  end
end

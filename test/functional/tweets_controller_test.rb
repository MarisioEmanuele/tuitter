require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  setup do
    User.delete_all
    create_a_user!
  end
  
  test "no post possible unless logged in" do
    post :create, :user_id => User.first.id
    assert_redirected_to "/sessions/new"    
  end
  
  test "logged in user can post" do
    log_in User.first
    post :create, :tweet => {:user_id => User.first.id, :text => "foo"}
    assert_redirected_to "/"
  end
  
  test "logged in user post as another user" do
    session[:user_id] = User.first.id
    post :create, :tweet => {:user_id => 12345, :text => "foo"}
    assert_response :unauthorized
  end
end

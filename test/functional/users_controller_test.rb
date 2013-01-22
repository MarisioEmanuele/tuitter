require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  setup do
    User.delete_all
    @user = create_a_user!
  end

  test "a user can update its own profile" do
    log_in @user
    post :update, :user => {:email => "z@y"}, :id => @user.id
    assert_redirected_to "/users/#{@user.id}"
    assert_equal "z@y", @user.reload.email
  end
  
  test "anonymous cannot update other user's profiles" do
    original_email = @user.email
    
    post :update, :user => {:email => "z@y"}, :id => @user.id
    
    assert_redirected_to "/sessions/new"
    assert_equal original_email, @user.reload.email    
  end
  
  test "a user cannot update another user's profile" do
    @another_user = create_a_user!("ginuz")
    original_email = @another_user.email

    log_in @user
    post :update, :user => {:email => "z@y"}, :id => @another_user.id
    
    assert_response :unauthorized
    assert_equal original_email, @another_user.reload.email    
  end
  
end

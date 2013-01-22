class FollowingsController < ApplicationController
  def create
    followed_user = User.find(params[:followed_user_id])

    current_user.followings_that_i_follow.create!(
      :followed_user_id => followed_user.id)

    redirect_to :back
  end
end

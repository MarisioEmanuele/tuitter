class Following < ActiveRecord::Base
  attr_accessible :followed_user_id, :follower_user_id
  
  belongs_to :followed_user
  belongs_to :follower_user
end

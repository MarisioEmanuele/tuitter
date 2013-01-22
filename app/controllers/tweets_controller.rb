class TweetsController < ApplicationController
  before_filter :authenticate, :only => :create

  def index
    @tweets = Tweet.includes("user").order("created_at desc")
    if current_user
      users_i_am_interested_in = [current_user] + current_user.users_that_i_follow
      @tweets = @tweets.where(["user_id in (?)", users_i_am_interested_in])
    end
  end
  
  def create 
    category = Category.where(["name = (?)", params[:category_id]]).first   
    if category.nil?  
      category = Category.create(:name => params[:category_id])
    end
    @tweet = current_user.tweets.build(params[:tweet], :category_id => category.id)
    if @tweet.save
      flash[:notice] = "New tweet!"
    else
      flash[:notice] = "Type something!"
    end
    redirect_to :action => "index"    
  end
end

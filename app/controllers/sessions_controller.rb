class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(["username = ?", params[:username]]).first
    if user && user.authenticate(params[:password])
      flash[:notice] = "Bentornato #{user.username}!"
      session[:user_id] = user.id
      redirect_to "/"
    else
      flash[:notice] = "Username o password errata"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to "/"
  end
end

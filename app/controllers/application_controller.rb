class ApplicationController < ActionController::Base
  # Rendi disponibile il metodo "current_user" nelle view
  helper_method :current_user

  def authenticate
    if current_user.nil?
      flash[:notice] = "Fatti riconoscere"
      redirect_to "/sessions/new"
    end
  end
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id]) 
    end
  end
end

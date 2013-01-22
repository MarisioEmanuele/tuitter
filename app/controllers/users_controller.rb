class UsersController < ApplicationController
  before_filter :authenticate, :only => :update
  before_filter :authorize_update_user, :only => :update
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Grazie per esserti registrato!"
      redirect_to :action => "show", :id => @user.id
    else
      render "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])  
    if @user.update_attributes(params[:user]) 
      flash[:notice] = "Utente aggiornato con successo"
      redirect_to :action => "show", :id => @user.id
    else
      render "edit"
    end
  end
  
  def followed_by
    @user = User.find(params[:id])    
  end
  
  private 
  
  def authorize_update_user
    if params[:id].to_i != current_user.id
      render :nothing => true, :status => 401
    end
  end
end

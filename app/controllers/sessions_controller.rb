class SessionsController < ApplicationController

  def login
  end

  def new
    @user = Shopper.find_by(username: params[:session][:username].downcase)

    if @user && @user.authenticate(params[:session][:password]) && @user.admin?
      session[:user_id] = @user.id
      flash[:success] = 'You have successfully logged in'
      redirect_to root_path
    else
      flash.now[:danger] = 'Could not log in as admin user.'
      render 'sessions/login', user: @user
    end

  end

  def logout
    session[:user_id] = nil
    flash[:success] = 'You have been logged out'
    redirect_to root_path
  end
end
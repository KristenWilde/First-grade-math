class SessionsController < ApplicationController

  def create
    user = User.where(username: params[:username]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/" + params[:username], turbolinks: false
    else
      flash[:message] = "There is something wrong with your username or password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:message] = "You've logged out."
    redirect_to root_path
  end

  def new

  end

end

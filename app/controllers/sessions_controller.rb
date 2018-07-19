class SessionsController < ApplicationController

  def create
    user = User.where(username: params[:username]).first

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      message = 'There is something wrong with your username or password.'
      redirect_to login_path, flash: { message: message }
    end
  end

  def destroy
    session[:user_id] = nil
    message = "You've logged out."
    redirect_to root_path, flash: { message: message }
  end
end

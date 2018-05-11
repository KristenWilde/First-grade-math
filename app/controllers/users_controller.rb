class UsersController < ApplicationController

  def show
    @user = User.find_by username: params[:id]

  end

  def create
    user = User.create(username: params[:username], password: params[:password])

    redirect user_path(user)
  end


  private

    def post_params

    end



end

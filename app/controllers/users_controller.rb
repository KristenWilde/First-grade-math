class UsersController < ApplicationController

  def show
    @username = params[:id]
    user = User.find_by username: @username
    @problems = user.problems

  end

  def create
    user = User.create(username: params[:username], password: params[:password])

    redirect user_path(user)
  end


  private

    def post_params

    end



end

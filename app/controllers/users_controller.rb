class UsersController < ApplicationController
  before_action :require_session, only: [:show, :edit, :update]

  def show
    @problems = @user.problems
    @username = @user.username
  end

  def new
  end

  def create
    username = params[:username]
    user = User.create(username: username, password: params[:password])
    session[:user_id] = user.id
    redirect_to "/" + username, status: '302', turbolinks: false
  end

  def update
    user = User.find_by username: params[:username]
    problems_to_update = params[:problems]
    update_problems(user, problems_to_update)
    redirect_to action: 'show', id: user.username, status: '303'
  end

  def available
    user = User.find_by username: params[:username]
    render plain: !user
  end

  private

    def post_params
    end

    def update_problems(user, problems_to_update)
      user_problems = user.problems
      problems_to_update.each do |prob|
        stored = user_problems.find_by id: prob['problem_id']
        stored.update success_times: prob['success_times']
      end
    end

    def require_session
      @user = User.find_by username: params[:username]
      if @user.id != session[:user_id]
        flash[:message] = "Please log in."
        redirect_to login_path
      end
    end
end

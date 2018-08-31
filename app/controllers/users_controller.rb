class UsersController < ApplicationController
  before_action :require_session, only: [:show, :edit, :update, :date_records]

  def show
    @problems = @user.problems
    @username = @user.username

    @secondsToday = PracticeDate.current_practice(@user).seconds
    @problemsToday = PracticeDate.current_practice(@user).problems_answered
  end

  def create
    user = User.create(username: params[:username], password: params[:password])
    session[:user_id] = user.id
    redirect_to user_path(user)
  end

  def update
    Problem.update_problems(params[:problems])
    PracticeDate.add_to_practice(@user, params[:seconds], params[:reps])
    render json: PracticeDate.current_practice(@user)
  end

  def available
    user = User.find_by username: params[:username]
    render plain: !user
  end

  def date_records
    render json: @user.practice_dates
  end
end

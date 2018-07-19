class UsersController < ApplicationController
  before_action :require_session, only: [:show, :edit, :update, :date_records]

  def show
    @problems = @user.problems
    @username = @user.username

    @secondsToday = DateRecord.today_record(@user).seconds
    @problemsToday = DateRecord.today_record(@user).problems_answered
  end

  def create
    user = User.create(username: params[:username], password: params[:password])
    session[:user_id] = user.id
    redirect_to user_path(user)
  end

  def update
    Problem.update_problems(params[:problems])
    DateRecord.update_date_records(@user, params[:seconds], params[:reps])
    render json: DateRecord.today_record(@user)
  end

  def available
    user = User.find_by username: params[:username]
    render plain: !user
  end

  def date_records
    render json: @user.date_records
  end
end

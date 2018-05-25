class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @username = params[:username]
    user = User.find_by username: @username
    redirect_to root_url unless user
    @problems = user.problems if user
  end

  def create
    user = User.create(username: params[:username], password: params[:password])
    redirect_to user_path(user)
  end

  def update
    user = User.find_by username: params[:username]
    problems_to_update = params[:problems]
    update_problems(user, problems_to_update)
    redirect_to action: 'show', id: user.username, status: '303'
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
end

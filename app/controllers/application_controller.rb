class ApplicationController < ActionController::Base

  private

    def require_session
      @user = User.find_by username: params[:username]
      if !@user
        message = params[:username] + " is not a registered user."
        redirect_to login_path, flash: { message: message }
      elsif @user.id != session[:user_id]
        redirect_to login_path, flash: { message: 'Please log in.' }
      end
    end
end

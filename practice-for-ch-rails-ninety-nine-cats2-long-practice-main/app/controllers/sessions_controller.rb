class SessionsController < ApplicationController
    before_action :require_logged_out, only: [:new, :create]
    
    def new
        render :new
    end

    def create
        user = User.find_by_credentials(session_params[:username], session_params[:password])
        if user
            login!(user)
            redirect_to cats_url
        else
            render :new
        end
    end

    def destroy
        current_user.reset_session_token!
        session[:session_token] = nil
        @current_user = nil
        render :new
    end

    private
    def session_params
        params.require(:user).permit(:username, :password)
    end
end

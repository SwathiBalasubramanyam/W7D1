class SessionsController < ApplicationController

    def new
        render :new
    end

    def create
        user = User.find_by_credentials(session_params)
        if user
            new_session_token = user.reset_session_token!
            session[:session_token] = new_session_token
            redirect_to cats_url    
        else
            render :new
        end
    end

    private
    def session_params
        params.require(:user).permit(:username, :password)
    end
end

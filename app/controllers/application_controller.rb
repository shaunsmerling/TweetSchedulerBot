class ApplicationController < ActionController::Base
    #before_action = before you run any actions, call set current user. This will make the 
    #set current user the FIRST thing that happens before any other method

    before_action :set_current_user

    def set_current_user
        if session[:user_id]
            Current.user = User.find_by(id: session[:user_id])
        end
    end


    def require_user_logged_in!
        redirect_to sign_in_path, alert: "You must be signed in to do that." if Current.user.nil?
    end
end

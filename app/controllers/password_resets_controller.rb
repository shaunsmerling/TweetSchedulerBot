class PasswordResetsController < ApplicationController
    def new
        render 
    end


    def create
        @user = User.find_by(email: params[:email])

        if @user.present?
            #send email
            #go to the password mailer, we want to send the reset email
            # but we want to include params so we know WHO we send it to
            #we use @user to send to that user, and then we do deliver_later
            #deliver_later sends it in a background job so our request in the browser can happen quickly
            #but the email will take a second to send out
            PasswordMailer.with(user: @user).reset.deliver_later
        end
        
        #if they have an account or not, we are going to redirect them to this page
        #we don't want to allow the login person to know if they have an account or not
        redirect_to root_path, notice: "If an account with that email was found, we have sent a link to reset your password" 
 
    end

    def edit
        @user = User.find_signed(params[:token], purpose: "password_reest")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to sign_in_path, alert: "Your token has expired. Please try again."
    end


    def update
        @user = User.find_signed(params[:token], purpose: "password_reest")
        if @user.update(password_params)
            redirect_to sign_in_path, notice: "Your password was reset succesffuly. Please sign in"
        else
            render :edit
        end
    end 



    private
    
    def password_params
        params.require(user).permit(:password, :password_confirmation)
    end 

end  
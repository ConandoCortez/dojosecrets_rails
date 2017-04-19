class SessionsController < ApplicationController
    def index
        render layout: "two_columns"
    end

    def register
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user[:id]
            redirect_to "/users/#{session[:user_id]}/dash"
        else
            flash[:errors] = user.errors.full_messages
            redirect_to "/"
        end
    end

    def login
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user[:id]
            redirect_to "/users/#{session[:user_id]}/dash"
        else
            flash[:login_errors] = ["User credentials are wrong"]
            redirect_to '/'
        end
    end

    def logout
        session.delete(:user_id)
        redirect_to '/'
    end
    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end

class UsersController < ApplicationController
    before_action :check_sessions
    # before_action :check_user, only: [:edit, :update, :destroy]
    def dash
        @secrets = Secret.all
        @user = User.find_by_id(session[:user_id])
        @likes = Like.where(user: User.find_by_id(session[:user_id]))
        render layout: "two_columns"
    end

    def edit
        @user = User.find_by_id(session[:user_id])
    end

    def update
        @user = User.find_by_id(params[:id])
        @user.update(update_params)
        if !@user.valid?
            flash[:errors] = @user.errors.full_messages
        end
        redirect_to "/users/#{@user.id}/edit"
    end

    def destroy
        User.find_by_id(params[:id]).destroy
        redirect_to '/'
    end

    private

    # def check_user
    #     if session[:user_id] != params[:id]
    #         redirect_to "/users/#{session[:user_id]}/dash"
    #     end
    # end

    def check_sessions
        if !session[:user_id]
            redirect_to '/'
        end
    end

    def update_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end

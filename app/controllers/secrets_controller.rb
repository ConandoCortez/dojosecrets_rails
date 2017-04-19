class SecretsController < ApplicationController
    before_action :check_sessions
    def add
        secret = Secret.create(content: params[:content], user:User.find_by_id(params[:id]))
        if !secret.valid?
            flash[:errors] = secret.errors.full_messages
        end
        redirect_to :back
    end

    def liked
        Like.create(user:User.find_by_id(params[:id]), secret:Secret.find_by_id(params[:secret_id]))
        redirect_to "/users/#{params[:id]}/dash"
    end

    def unlike
        Like.find_by_user_id_and_secret_id(params[:id], params[:secret_id]).destroy
        redirect_to :back
    end

    def destroy
        secret = Secret.find_by_id(params[:secret_id])
        if session[:user_id] == secret.user_id
            secret.destroy
        end
        redirect_to :back
    end

    private

    def check_user
        secret = Secret.find_by_id(params[:secret_id])
        if session[:user_id] != secret.user_id
            redirect_to "/users/#{session[:user_id]}/edit"
        end
    end

    def check_sessions
        if !session[:user_id]
            redirect_to '/'
        end
    end
end

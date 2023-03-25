class UsersController < ApplicationController

    def create
 
        user = User.create!(user_params)
        session[:user_id] = user.id

    rescue ActiveRecord::RecordInvalid => invalid
        byebug
        render json: {error: invalid.record.errors.full_messages}, status: :unprocessable_entity

        
        render json: user
    end

    def show
        user = User.find(session[:user_id])
        if user
            render json: user
        end
        
    end

    private

    def user_params
        params.permit(:username, :password)
    end
end

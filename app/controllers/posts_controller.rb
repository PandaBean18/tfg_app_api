class PostsController < ApplicationController
    before_action :authorize_request

    def create 
        if !@current_user.admin 
            current_params = rescue_request_params
            current_params[:author_id] = @current_user.user_id 
            current_params[:closed] = false 

            puts current_params 
            
            post = RescueRequest.new(current_params)

            if post.save 
                render json: {status: 200, new_token: @new_token, new_refresh_token: @new_refresh_token}, status: 200
            else  
                render json: {status: 400, error: post.errors.full_messages[0], new_token: @new_token, new_refresh_token: @new_refresh_token}, status: 400 
            end
        end
    end

    private 

    def rescue_request_params
        params.require(:post).permit(:heading, :description, :reference_number, :longitude, :latitude)
    end
end

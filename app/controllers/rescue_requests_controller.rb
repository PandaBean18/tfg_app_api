class RescueRequestsController < ApplicationController
    before_action :authorize_request

    def create 
        if !@current_user.admin 
            current_params = rescue_request_params
            current_params[:author_id] = @current_user.user_id 
            current_params[:closed] = false             
            post = RescueRequest.new(current_params)

            if post.save 
                render json: {status: 200, new_token: @new_token, new_refresh_token: @new_refresh_token}, status: 200
            else  
                render json: {status: 400, error: post.errors.full_messages[0], new_token: @new_token, new_refresh_token: @new_refresh_token}, status: 400 
            end
        end
    end

    # returns a single post
    def show 
        id = params[:id]
        rescue_request = RescueRequest.find_by(rescue_request_id: id)
    
        if rescue_request  
            render json: {status: 200, post: rescue_request, new_token: @new_token, new_refresh_token: @new_refresh_token}, status: 200 
        else 
            render json: {status: 404}, status: 404
        end
    end 

    # update this method to return so that new posts show on top
    def index 
        rescue_requests = RescueRequest.all 
        render json: {status: 200, post: rescue_requests, new_token: @new_token, new_refresh_token: @new_refresh_token}, status: 200
    end

    private 

    def rescue_request_params
        params.require(:post).permit(:heading, :description, :reference_number, :longitude, :latitude)
    end
end

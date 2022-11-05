class RescueRequestsController < ApplicationController
    before_action :authorize_request

    def create 
        if !@current_user.admin 
            current_params = rescue_request_params
            current_params[:author_id] = @current_user.user_id 
            current_params[:closed] = false             
            post = RescueRequest.new(current_params)

            if post.save 
                render json: {status: 200}, status: 200
            else  
                render json: {status: 400, error: post.errors.full_messages[0]}, status: 400 
            end
        end
    end

    # returns a single post
    def show 
        id = params[:id]
        rescue_request = RescueRequest.find_by(rescue_request_id: id)
    
        if rescue_request  
            render json: {status: 200, post: rescue_request}, status: 200 
        else 
            render json: {status: 404}, status: 404
        end
    end 

    # update this method to return so that new posts show on top
    def index 
        rescue_requests = RescueRequest.all 
        render json: {status: 200, posts: rescue_requests}, status: 200
    end

    def update 
        rescue_request_id = params[:id]
        rescue_request = RescueRequest.find_by(rescue_request_id: rescue_request_id)
        if rescue_request && rescue_request.author == @current_user
            if rescue_request.update(rescue_request_params)
                render json: {status: 200}, status: 200
            else  
                render json: {status: 422, error: rescue_request.errors.full_messages[0]}, status: 422
            end 
        else 
            render json: {status: 404}, status: 404
        end
    end 

    def destroy
        rescue_request_id = params[:id]
        rescue_request = RescueRequest.find_by(rescue_request_id: rescue_request_id)
        if rescue_request && rescue_request.author == @current_user
            rescue_request.destroy
            render json: {status: 200}, status: 200
        else  
            render json: {status: 404}, status: 404
        end
    end

    private 

    def rescue_request_params
        params.require(:post).permit(:heading, :description, :reference_number, :longitude, :latitude)
    end
end

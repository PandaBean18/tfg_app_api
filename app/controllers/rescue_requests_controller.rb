class RescueRequestsController < ApplicationController
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

    # returns a single post
    def show 
        id = params[:id]
        rescue_request = RescueRequest.find_by(rescue_request_id: id)
        current_rescue_request = {
            rescue_request_id: rescue_request.rescue_request_id, 
            author_id: rescue_request.author_id, 
            heading: rescue_request.heading, 
            description: rescue_request.description, 
            reference_number: rescue_request.reference_number, 
            google_maps_link: "https://www.google.com/maps/search/?api=1&query=#{rescue_request.latitude},#{rescue_request.longitude}",
            created_at: rescue_request.created_at
        }
        if rescue_request  
            render json: {status: 200, post: current_rescue_request, new_token: @new_token, new_refresh_token: @new_refresh_token}, status: 200 
        else 
            render json: {status: 404}, status: 404
        end
    end 

    private 

    def rescue_request_params
        params.require(:post).permit(:heading, :description, :reference_number, :longitude, :latitude)
    end
end

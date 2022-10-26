class ApplicationController < ActionController::API

    def not_found
        render json: {status: 404}, status: 404 
    end

    def authorize_request 
        token = request.headers['Authorization']
        token = token.split(' ').last if token 

        refresh_token = request.headers['Refresh-token']
        refresh_token = refresh_token.split(' ').last if refresh_token 

        decoded_token = JsonWebToken.valid_token?(token)
        if decoded_token
            @current_user = User.find_by(session_token: decoded_token[:session])
            if !@current_user 
                render json: {status: 401, error: 'Invalid token.'}, status: 401
            end 
        elsif refresh_token
            decoded_refresh_token = JsonWebToken.valid_refresh_token?(refresh_token)
            puts decoded_refresh_token
            if decoded_refresh_token
                @current_user = User.find_by(session_token: decoded_refresh_token[:session])

                if !@current_user 
                    render json: {status: 401, error: 'Invalid token.'}, status: 401
                end

                session_token = @current_user.reset_session_token!
                
                payload = {
                    session: session_token, 
                    refresh_token: false 
                }

                @new_token = JsonWebToken.encode(payload, 24.hours.from_now)
                payload[:refresh_token] = true 
                @new_refresh_token = JsonWebToken.encode(payload, 480.hours.from_now)
            else  
                render json: {status: 401, error: 'Invalid token.'}, status: :unauthorized 
            end 
        else  
            render json: {status: 401, error: 'Invalid or missing token.'}, status: :unauthorized
        end 
    end
end

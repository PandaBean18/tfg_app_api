class AuthenticationController < ApplicationController
    before_action :authorize_request, except: :login

    def login 
        username = login_params[:username]
        password = login_params[:password]

        user = User.find_by_credentials(username, password)
        puts user
        if user 
            session_token = user.session_token
            payload = {
                session: session_token, 
                refresh_token: false 
            }

            @new_token = JsonWebToken.encode(payload)
            payload[:refresh_token] = true 
            @new_refresh_token = JsonWebToken.encode(payload, 480.hours.from_now)
            
            user = {
            first_name: user.first_name,
            last_name: user.last_name, 
            username: user.username, 
            mail: user.mail, 
            phone: user.phone, 
            admin: user.admin, 
            created_at: user.created_at, 
            }

            render json: {status: 200, user: user, token: @new_token, refresh_token: @new_refresh_token}, status: 200
        else 
            render json: {status: 401, error: 'Failed login.'}, status: 401
        end        
    end

    def logout 
        if @current_user
            @current_user.reset_session_token!
            render json: {status: 200}, status: 200
        else 
            render json: {status: 403}, status: 403
        end 
    end 

    private 

    def login_params 
        params.require(:user).permit(:username, :password)
    end
end

class AuthenticationController < ApplicationController
    before_action :authorize_request, except: :login

    def login 
        username = login_params[:username]
        password = login_params[:password]

        user = User.find_by_credentials(username, password)

        if user 
            session_token = user.session_token
            payload = {
                session: session_token, 
                refresh_token: false 
            }

            @new_token = JsonWebToken.encode(payload)
            payload[:refresh_token] = true 
            @new_refresh_token = JsonWebToken.encode(payload, 480.hours.from_now)

            render json: {status: 200, user: user, token: @new_token, refresh_token: @new_refresh_token}, status: 200
        else 
            render json: {status: 401, error: 'Failed login.'}
        end        
    end

    private 

    def login_params 
        params.require(:user).permit(:username, :password)
    end
end

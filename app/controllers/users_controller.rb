class UsersController < ApplicationController
    before_action :authorize_request, except: :create

    def create 
        current_user_params = user_params
        first_name = current_user_params[:first_name]
        last_name = current_user_params[:last_name] == '' ? nil : current_user_params[:last_name]
        username = current_user_params[:username]
        password = current_user_params[:password]
        mail = current_user_params[:mail]
        phone = current_user_params[:phone]

        user = User.new(
            {
                first_name: first_name, 
                last_name: last_name, 
                username: username, 
                password: password, 
                mail: mail, 
                phone: phone, 
                admin: false
            }
        )

        if user.save
            session_token = user.session_token
            payload = {
                session: session_token, 
                refresh_token: false 
            }

            @new_token = JsonWebToken.encode(payload, 24.hours.from_now)
            payload[:refresh_token] = true 
            @new_refresh_token = JsonWebToken.encode(payload, 480.hours.from_now)

            user = {
                user_id: user.user_id,
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
            render json: {status: 400, error: user.errors.full_messages[0]}, status: 400
        end
    end 

    def show 
        user = {
            user_id: @current_user.user_id,
            first_name: @current_user.first_name,
            last_name: @current_user.last_name, 
            username: @current_user.username, 
            mail: @current_user.mail, 
            phone: @current_user.phone, 
            admin: @current_user.admin, 
            created_at: @current_user.created_at, 
        }
        render json: {status: 200, user: user}, status: 200 
    end

    def update
        if @current_user.update(edit_user_params)
            user = {
                user_id: @current_user.user_id,
                first_name: @current_user.first_name,
                last_name: @current_user.last_name, 
                username: @current_user.username, 
                mail: @current_user.mail, 
                phone: @current_user.phone, 
                admin: @current_user.admin, 
                created_at: @current_user.created_at, 
            }
            render json: {status: 200, user: user} , status: 200 
        else  
            render json: {status: 422, error: @current_user.errors.full_messages[0]}, status: :unprocessable_entity 
        end 
    end 

    def update_password
        if @current_user.update(edit_user_password_params)
            render json: {status: 200}, status: 200
        else  
            render json: {status: 422, error: @current_user.errors.full_messages[0]}, status: :unprocessable_entity 
        end 
    end

    def destroy 
        @current_user.destroy
        render json: {status: 200}
    end

    private

    def user_params
        return params.require(:user).permit(:first_name, :last_name, :username, :password, :mail, :phone)
    end 

    def edit_user_params 
        return params.require(:user).permit(:first_name, :last_name, :username, :mail, :phone)
    end 

    def edit_user_password_params
        return params.require(:user).permit(:password)
    end
end
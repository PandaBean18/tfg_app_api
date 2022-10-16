class UsersController < ApplicationController
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
            render json: {status: 200, session_token: user.session_token}, status: 200
        else 
            render json: {status: 400, error: user.errors.full_messages[0]}, status: 400
        end
    end 

    def show 
        user_id = params[:id]
        user = User.find_by(user_id: user_id)
        puts params
        if user 
            render json: {status: 200, user: user}, status: 200
        else 
            render json: {status: 404}, status: 404
        end
    end

    def update
        user_id = params[:id]
        user = User.find_by(user_id: user_id)

        if !user 
            render json: {status: 404}, status: 404 
        end 

        id = user.id 

        if user.update(edit_user_params)
            render json: {status: 200, user: user}, status: 200
        else  
            render json: {status: 400, error: user.errors.full_messages[0]}, status: 400 
        end 
    end 

    private

    def user_params
        return params.require(:user).permit(:first_name, :last_name, :username, :password, :mail, :phone)
    end 

    def edit_user_params 
        return params.require(:user).permit(:first_name, :last_name, :username, :mail, :phone)
    end 
end
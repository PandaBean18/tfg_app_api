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
            render json: {user_id: user.user_id}, status: 200
        else 
            render json: {error: user.errors.full_messages[0]}, status: 400
        end
    end 

    private

    def user_params
        return params.require(:user).permit(:first_name, :last_name, :username, :password, :mail, :phone)
    end 
end
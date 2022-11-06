class UserMailer < ApplicationMailer
    default from: 'notification@helpinghandstest.com'

    def welcome_mail 
        @user = params[:user]
        mail(to: @user.mail, subject: 'test mail')
    end
end

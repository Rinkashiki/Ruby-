class UserMailer < ApplicationMailer

  def new_user_email
    @user = params[ :user]
    mail(to: @user.email, subject: 'Thanks for your registration!')
  end
end

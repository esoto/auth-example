class LoginMailer < ApplicationMailer
  def magic_link
    @user = params[:user]
    @token = params[:token]
    mail to: @user.email, subject: "Your magic link"
  end
end
